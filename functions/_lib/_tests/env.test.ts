import assert from 'node:assert/strict';
import { afterEach, test } from 'node:test';
import { restoreEnv, setEnv } from '../_testing.ts';
import { ConfigError, env, jsonEnv, requireEnv } from '../env.ts';

afterEach(restoreEnv);

test('a variable that is unset or empty reads as undefined', () => {
  assert.equal(env('CHAT_MODEL'), undefined);
  setEnv({ CHAT_MODEL: '' });
  assert.equal(env('CHAT_MODEL'), undefined);
  setEnv({ CHAT_MODEL: 'm' });
  assert.equal(env('CHAT_MODEL'), 'm');
});

test('requireEnv returns the value or throws a ConfigError naming the variable', () => {
  setEnv({ CHAT_API_KEY: 'k' });
  assert.equal(requireEnv('CHAT_API_KEY'), 'k');
  assert.throws(
    () => requireEnv('CHAT_API_URL'),
    (error) => error instanceof ConfigError && /CHAT_API_URL/.test(error.message),
  );
});

test('jsonEnv reads an object and ignores anything else', () => {
  setEnv({ CHAT_EXTRA_BODY: '{"a":1}' });
  assert.deepEqual(jsonEnv('CHAT_EXTRA_BODY'), { a: 1 });
  setEnv({ CHAT_EXTRA_BODY: '[1,2]' });
  assert.deepEqual(jsonEnv('CHAT_EXTRA_BODY'), {});
  setEnv({ CHAT_EXTRA_BODY: 'not json' });
  assert.deepEqual(jsonEnv('CHAT_EXTRA_BODY'), {});
  restoreEnv();
  assert.deepEqual(jsonEnv('CHAT_EXTRA_BODY'), {});
});
