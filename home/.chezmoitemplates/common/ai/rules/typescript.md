# TypeScript Rules

## Absolute Rules

- **Coding Style**: Follow [Google TypeScript Style Guide](https://google.github.io/styleguide/tsguide.html) basically
- **NEVER USE `any`**: Use `unknown` if type is truely unknown
- **No type assertions** (`as SomeType`) unless absolutely necessary with clear justification
- **No `@ts-ignore`** or `@ts-expect-error` without explicit explanation
- These rules apply to test code as well as production code

## Type Definition Rules

- Prefer `type` over `interface` like below:

```typescript
// Good
type User = {
  id:   string,
  name: string,
}
// Avoid
interface User = {
  id:   string,
  name: string,
}
```

- Create Domain-Specific Types like below:

```typescript
// Good - branded type for type safety
type UserId = string & { readonly brand: unique symbol };
type Count  = number & { readonly brand: unique symbol };
```

```typescript
// Avoid - too generic
type UserId = string;
type Count  = number;
```

- Schema-first Development with Zod like below:

```typescript
// Define schemas first
const UserSchema = z.object({
  id: z.string().uuid(),
  email: z.string().email(),
  createdAt: z.date(),
});

// Derive types from schemas
type User = z.infer<typeof UserSchema>;

// Use at runtime boundaries
export const parseUser = (data: unknown): User => {
  return UserSchema.parse(data);
};

```
