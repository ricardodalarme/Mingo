import { test } from 'node:test';
import { assert, couple, denied, ok, person } from '../lib.ts';

test('a shared ritual can be planned by either person of the couple', async () => {
  const { a, b, coupleId } = await couple();
  const ritual = (await ok(a, `mutation ($c: uuid!, $p: uuid!) { insertRitualsOne(object: {title: "café", coupleId: $c, plannerId: $p}) { id plannerId } }`, { c: coupleId, p: b.id })).insertRitualsOne;
  assert.equal(ritual.plannerId, b.id);

  const changed = (await ok(b, `mutation ($id: uuid!, $p: uuid!) { updateRitualsByPk(pk_columns: {id: $id}, _set: {plannerId: $p}) { plannerId } }`, { id: ritual.id, p: b.id })).updateRitualsByPk;
  assert.equal(changed.plannerId, b.id);
});

test('somebody outside the couple, or a private ritual, cannot have a planner', async () => {
  const { a, coupleId } = await couple();
  const stranger = await person();
  const result = await denied(a, `mutation ($c: uuid!, $p: uuid!) { insertRitualsOne(object: {title: "x", coupleId: $c, plannerId: $p}) { id } }`, { c: coupleId, p: stranger.id });
  assert.match(JSON.stringify(result), /INVALID_PLANNER/);
  const privateOne = await denied(a, `mutation ($p: uuid!) { insertRitualsOne(object: {title: "y", plannerId: $p}) { id } }`, { p: a.id });
  assert.match(JSON.stringify(privateOne), /INVALID_PLANNER/);
});
