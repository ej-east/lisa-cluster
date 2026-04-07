export default {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      ['feat', 'fix', 'security', 'revert', 'docs', 'style', 'chore'],
    ],
  },
};
