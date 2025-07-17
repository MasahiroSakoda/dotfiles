# Node.js Environment Rules

- **Language**: Always use latest [TypeScript](https://www.typescriptlang.org/docs) features with strict type checking
- **Package Manager**: Strongly prefer [`pnpm`](https://pnpm.io/motivation) command as package management instead of `npm` and `yarn`
- **Dynamic package execution**: Use [`pnpm dlx`](https://pnpm.io/cli/dlx) instead of `npx` or `yarn dlx` or `bunx`
- **Dependency Management**: Use [`pnpm` catalogs](https://pnpm.io/catalogs) to maintain unique versions
- **Linter & Formatter**: Use [`biome`](https://biomejs.dev/guides/getting-started/) instead of `prettier` and `eslint`
- **Testing**: Add tests for new features, especially in services and state management.
  - **Unit Test**: Use [Jest](https://jestjs.io/docs) for unit tests unless explicitly requested.
  - **E2E Test**: Use [Playwright](https://playwright.dev/docs) for E2E tests unless explicitly requested.
