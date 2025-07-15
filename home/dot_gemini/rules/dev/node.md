# Node.js Environment Rules

- **Language**: Always use latest [TypeScript](https://www.typescriptlang.org/docs) features with strict type checking
- **Package Manager**: Use [`pnpm`](https://pnpm.io/motivation) command as package management instead of `npm` or `yarn`
- **Dynamic package execution**: Use [`pnpm dlx`](https://pnpm.io/cli/dlx) instead of `npx` or `yarn dlx` or `bunx`
- **Monorepo Management**: Use [Turborepo](https://turborepo.com/docs) with [pnpm workspaces](https://pnpm.io/workspaces)
- **Dependency Management**: Use [`pnpm` catalogs](https://pnpm.io/catalogs) to maintain unique versions
- **Linter & Formatter**: Use [`biome`](https://biomejs.dev/guides/getting-started/) instead of `prettier` and `eslint`
- **Testing**: Add tests for new features, especially in services and state management.
  - **Unit Test**: Use [Jest](https://jestjs.io/docs) for unit tests unless explicitly requested.
  - **E2E Test**: Use [Playwright](https://playwright.dev/docs) for E2E tests unless explicitly requested.
- **Frontend**: React 19 with [Next.js](https://nextjs.org/docs) 15 App Router unless explicitly requested.
  - **Styling**: [Tailwind CSS](https://tailwindcss.com/docs/styling-with-utility-classes) v4 with custom CSS variables for theming
  - **UI Component**: Built on [shadcn/ui](https://ui.shadcn.com/docs) components with [Radix UI](https://www.radix-ui.com/themes/docs/overview/getting-started) primitives
