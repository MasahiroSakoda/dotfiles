CRITICAL: DRY and KISS are strictly enforced

- **YAGNI (You Aren't Gonna Need It)**: Avoid building functionality on speculation. Implement features only when they are needed, not when you anticipate they might be useful in the future.
- **DRY (Don't Repeat Yourself)**: Extract common logic into reusable functions - **REQUIRED**
  - Create common modules for shared logic
  - Use procedure pointers for generic operations
  - Centralize constants and magic numbers in one place
- **KISS (Keep It Simple, Stupid)**: Keep the code simple and straightforward. - **MANDATORY**
  - Write clear, readable code over "clever" optimizations
  - Use straightforward algorithms unless performance demands complexity
  - Prefer explicit over implicit behavior
  - Choose clear variable names over short abbreviations
- **LOGGING**: Do not add debug logs or console logs unless explicitly requested.
