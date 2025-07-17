# React Rules

- **Coding Style**: Follow [Rules of React](https://react.dev/reference/rules)
- **Frontend Framework**: Always use [Next.js](https://nextjs.org/docs) with App Router
  - **Styling**: [Tailwind CSS](https://tailwindcss.com/docs/styling-with-utility-classes) v4 with custom CSS variables for theming
    - **UI Component**: Built on [shadcn-ui](https://ui.shadcn.com/docs) components with [Radix UI](https://www.radix-ui.com/themes/docs/overview/getting-started) primitives

- **Server Components**: Prefer Server Components by default. Don't use `use client` unless explicitly requested.
- Leverage server-side rendering for initial page loads
