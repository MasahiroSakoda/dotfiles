# Monorepo Management Rules

## Principles

- **Monorepo Management**: Use [Turborepo](https://turborepo.com/docs) with [pnpm workspaces](https://pnpm.io/workspaces)

## Project Structure

```text
├── apps/
│   ├── docs/              # Documentation site for web application
│   └── web/               # The user-facing web application.
├── packages/
│   ├── auth/              # Shared authentication configurations
│   ├── database/          # Shared database configurations
│   └── ui/                # Shared UI components
├── tooling/
│   ├── biome-config/      # Shared biome linter / formatter configurations
│   ├── typescript-config/ # Shared TypeScript configurations
│   ├── next-config/       # Shared Next.js configurations
├── scripts/               # Various automation and utility scripts
├── .npmrc
├── pnpm-lock.yaml         # Lock file for pnpm package manager
├── pnpm-workspace.yaml    # pnpm workspace structure
└── turbo.json             # Turborepo task configurations
```


## Executing Turborepo apps

- `pnpm build`: Build all project
- `pnpm dev`: Run all environment
- `pnpm biome:check`: Check code quality with `biome`
- `pnpm biome:fix`: Run lint / formatter with `biome`
- `pnpm test`: Run all tests
  - `pnpm test:unit`: Run unit tests
  - `pnpm test:e2e`: Run E2E tests
- `pnpm test:watch`: Run all tests with watch mode
