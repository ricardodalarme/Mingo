// Generates the Hasura metadata of the app's tables and functions from the spec in `metadata-spec.mjs`.
// Column names come from the local database, so run it against a stack with every migration applied:
//   node nhost/tools/build-metadata.mjs
// It rewrites `nhost/metadata/databases/default/{tables,functions}`; the `auth_*` and `storage_*` files that Nhost
// owns are kept, except `storage_files.yaml`, which gains the app's relationships and permissions.
// Run `nhost/tools/up.sh` afterwards: Nhost normalizes the files it loads, and that normalized form is what is committed.
import { readFileSync, readdirSync, rmSync, writeFileSync, mkdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { enums, functions, storageFiles, tables } from './metadata-spec.mjs';

const root = join(dirname(fileURLToPath(import.meta.url)), '..', '..');
const tablesDir = join(root, 'nhost/metadata/databases/default/tables');
const functionsDir = join(root, 'nhost/metadata/databases/default/functions');
const hasuraUrl = process.env.NHOST_HASURA_URL ?? 'http://localhost:8080';

function adminSecret() {
  if (process.env.NHOST_ADMIN_SECRET) return process.env.NHOST_ADMIN_SECRET;
  const line = readFileSync(join(root, '.secrets'), 'utf8').split('\n').find((l) => l.startsWith('HASURA_GRAPHQL_ADMIN_SECRET'));
  return line.split('=')[1].trim().replace(/^'|'$/g, '');
}

async function sql(text) {
  const res = await fetch(`${hasuraUrl}/v2/query`, {
    method: 'POST',
    headers: { 'x-hasura-admin-secret': adminSecret() },
    body: JSON.stringify({ type: 'run_sql', args: { source: 'default', sql: text, read_only: true } }),
  });
  const body = await res.json();
  if (!res.ok) throw new Error(JSON.stringify(body));
  return body.result.slice(1);
}

const camel = (s) => s.replace(/_([a-z0-9])/g, (_, c) => c.toUpperCase());
const pascal = (s) => camel(s).replace(/^./, (c) => c.toUpperCase());

// A small YAML writer: enough for metadata (maps, lists, strings, numbers, booleans).
function scalar(v) {
  if (typeof v === 'string') {
    return /^[A-Za-z_][A-Za-z0-9_./-]*$/.test(v) && !['true', 'false', 'null', 'yes', 'no', 'on', 'off'].includes(v.toLowerCase())
      ? v
      : JSON.stringify(v);
  }
  return String(v);
}
function yaml(value, indent = 0) {
  const pad = '  '.repeat(indent);
  if (Array.isArray(value)) {
    if (value.length === 0) return ' []\n';
    return '\n' + value.map((item) => {
      if (item !== null && typeof item === 'object') {
        const body = yaml(item, indent + 1).replace(/^\n/, '');
        return `${pad}- ${body.slice(pad.length + 2)}`;
      }
      return `${pad}- ${scalar(item)}\n`;
    }).join('');
  }
  if (value !== null && typeof value === 'object') {
    const keys = Object.keys(value);
    if (keys.length === 0) return ' {}\n';
    return '\n' + keys.map((k) => `${pad}${scalar(k)}:${yaml(value[k], indent + 1)}`).join('');
  }
  return ` ${scalar(value)}\n`;
}
const toYaml = (obj) => yaml(obj).replace(/^\n/, '');

function relationship(name, def) {
  if (typeof def === 'string') return { name, using: { foreign_key_constraint_on: def } };
  if (def.manual) {
    const [schema, table] = def.manual.includes('.') ? def.manual.split('.') : ['public', def.manual];
    return { name, using: { manual_configuration: { column_mapping: def.on, insertion_order: null, remote_table: { name: table, schema } } } };
  }
  const [schema, table] = def.table.includes('.') ? def.table.split('.') : ['public', def.table];
  return { name, using: { foreign_key_constraint_on: { column: def.column, table: { name: table, schema } } } };
}

function permissions(spec, kind) {
  return Object.entries(spec.roles ?? {})
    .filter(([, perms]) => perms[kind])
    .map(([role, perms]) => {
      const p = perms[kind];
      const permission = {};
      if (kind === 'select') {
        permission.columns = p.columns;
        permission.filter = p.filter ?? {};
        if (p.aggregate) permission.allow_aggregations = true;
      } else if (kind === 'insert') {
        permission.check = p.check ?? {};
        if (p.set) permission.set = p.set;
        permission.columns = p.columns;
      } else if (kind === 'update') {
        permission.columns = p.columns;
        permission.filter = p.filter ?? {};
        permission.check = p.check ?? null;
        if (p.set) permission.set = p.set;
      } else {
        permission.filter = p.filter ?? {};
      }
      return { role, permission };
    });
}

function tableMetadata(schema, name, spec, columns) {
  const gql = spec.name ?? camel(name);
  const cap = gql.replace(/^./, (c) => c.toUpperCase());
  const out = {
    table: { name, schema },
    configuration: {
      column_config: Object.fromEntries(columns.map((c) => [c, { custom_name: camel(c) }])),
      custom_column_names: Object.fromEntries(columns.map((c) => [c, camel(c)])),
      custom_name: gql,
      custom_root_fields: {
        delete: `delete${cap}`,
        delete_by_pk: `delete${cap}ByPk`,
        insert: `insert${cap}`,
        insert_one: `insert${cap}One`,
        select: gql,
        select_aggregate: `${gql}Aggregate`,
        select_by_pk: `${gql}ByPk`,
        select_stream: `${gql}Stream`,
        update: `update${cap}`,
        update_by_pk: `update${cap}ByPk`,
        update_many: `update${cap}Many`,
      },
    },
  };
  const objects = Object.entries(spec.object ?? {}).map(([n, d]) => relationship(n, d));
  const arrays = Object.entries(spec.array ?? {}).map(([n, d]) => relationship(n, d));
  if (objects.length) out.object_relationships = objects;
  if (arrays.length) out.array_relationships = arrays;
  for (const kind of ['insert', 'select', 'update', 'delete']) {
    const list = permissions(spec, kind);
    if (list.length) out[`${kind}_permissions`] = list;
  }
  if (spec.eventTriggers) out.event_triggers = spec.eventTriggers;
  return out;
}

const columnRows = await sql(`
  select table_schema, table_name, string_agg(column_name, ',' order by column_name)
  from information_schema.columns where table_schema in ('public', 'private') group by 1, 2`);
const columnsOf = Object.fromEntries(columnRows.map(([s, t, cols]) => [`${s}.${t}`, cols.split(',')]));

for (const file of readdirSync(tablesDir)) {
  if (!/^(auth|storage)_/.test(file) || file === 'storage_files.yaml') rmSync(join(tablesDir, file));
}
rmSync(functionsDir, { recursive: true, force: true });
mkdirSync(functionsDir, { recursive: true });

const files = readdirSync(tablesDir).filter((f) => f.endsWith('.yaml')).sort();

for (const name of enums) {
  if (!columnsOf[`public.${name}`]) throw new Error(`enum table public.${name} does not exist`);
  const file = `public_${name}.yaml`;
  writeFileSync(join(tablesDir, file), toYaml({ table: { name, schema: 'public' }, is_enum: true, configuration: { custom_name: pascal(name) } }));
  files.push(file);
}

for (const [qualified, spec] of Object.entries(tables)) {
  const [schema, name] = qualified.includes('.') ? qualified.split('.') : ['public', qualified];
  const columns = columnsOf[`${schema}.${name}`];
  if (!columns) throw new Error(`table ${schema}.${name} does not exist`);
  for (const perms of Object.values(spec.roles ?? {})) {
    for (const kind of ['select', 'insert', 'update']) {
      if (perms[kind]?.columns === '*') perms[kind].columns = columns;
      for (const c of perms[kind]?.columns ?? []) {
        if (!columns.includes(c)) throw new Error(`${qualified}: unknown column ${c} in ${kind} permission`);
      }
    }
  }
  const file = `${schema}_${name}.yaml`;
  writeFileSync(join(tablesDir, file), toYaml(tableMetadata(schema, name, spec, columns)));
  files.push(file);
}

// storage.files keeps the configuration Nhost Storage expects and gains the app's relationships and permissions.
{
  const columns = ['bucket_id', 'created_at', 'etag', 'id', 'is_uploaded', 'metadata', 'mime_type', 'name', 'size', 'updated_at', 'uploaded_by_user_id'];
  const base = tableMetadata('storage', 'files', { ...storageFiles, name: 'files' }, columns);
  base.configuration.custom_root_fields = {
    delete: 'deleteFiles', delete_by_pk: 'deleteFile', insert: 'insertFiles', insert_one: 'insertFile', select: 'files',
    select_aggregate: 'filesAggregate', select_by_pk: 'file', update: 'updateFiles', update_by_pk: 'updateFile',
  };
  writeFileSync(join(tablesDir, 'storage_files.yaml'), toYaml(base));
  files.push('storage_files.yaml');
}

writeFileSync(join(tablesDir, 'tables.yaml'), [...new Set(files)].filter((f) => f !== 'tables.yaml').sort().map((f) => `- "!include ${f}"\n`).join(''));

const functionFiles = [];
for (const [qualified, spec] of Object.entries(functions)) {
  const [schema, name] = qualified.includes('.') ? qualified.split('.') : ['public', qualified];
  const configuration = { custom_name: camel(name), custom_root_fields: { function: camel(name), function_aggregate: `${camel(name)}Aggregate` } };
  if (spec.exposedAs) configuration.exposed_as = spec.exposedAs;
  if (spec.session) configuration.session_argument = 'session';
  const out = { function: { name, schema }, configuration };
  if (spec.roles?.length) out.permissions = spec.roles.map((role) => ({ role }));
  const file = `${schema}_${name}.yaml`;
  writeFileSync(join(functionsDir, file), toYaml(out));
  functionFiles.push(file);
}
writeFileSync(join(functionsDir, 'functions.yaml'), functionFiles.sort().map((f) => `- "!include ${f}"\n`).join(''));

console.log(`wrote ${files.length} tables and ${functionFiles.length} functions`);
