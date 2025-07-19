# Test-Driven Development Rules

## 📄 TDD Workflow

**MANDATORY**: Execute strict Test-Driven Development following RED-GREEN-REFACTOR cycle.
**NEVER** implement features without tests.

### 1. **🔴 RED Phase**

- Update TODO.md (pending → in_progress)
- Write ONE failing test
- Run test
- Verify test fails for correct reason (not syntax/import errors)

```typescript
// Step 1: Red - Write failing test
describe("PaymentProcessor", () => {
  it("should decline payment when insufficient funds", () => {
    const payment = createPayment({ amount: 1000 });
    const account = createAccount({ balance: 500 });

    const result = processPayment(payment, account);

    expect(result.success).toBe(false);
    expect(result.error.message).toBe("Insufficient funds");
  });
});
```

### 2. **🟢 GREEN Phase**

- Write MINIMAL code to pass test (YAGNI principle)
- Run test (all tests must pass)
- No extra features or optimizations

```typescript
// Step 2: Green - Minimal implementation
const processPayment = (payment: Payment, account: Account): Result => {
  if (account.balance < payment.amount) {
    return { success: false, error: new Error("Insufficient funds") };
  }
  return { success: true };
};
```

### 3. **🔵 REFACTOR Phase** (optional)

- Improve code while keeping tests green
- Remove duplication, improve naming, simplify logic

```typescript
// Step 3: Refactor - Extract constants, improve readability
const INSUFFICIENT_FUNDS_ERROR = "Insufficient funds";

const hasInsufficientFunds = (account: Account, amount: number): boolean => {
  return account.balance < amount;
};

const processPayment = (payment: Payment, account: Account): Result => {
  if (hasInsufficientFunds(account, payment.amount)) {
    return { success: false, error: new Error(INSUFFICIENT_FUNDS_ERROR) };
  }
  return { success: true };
};
```

### 4. **✅ COMPLETE Phase**

- Update TODO.md (mark complete [x])
- Request approval with following format:

 ```txt
Task: [description]
Expected behavior: [what user should see/experience]
Manual test: [how to verify manually]
All tests pass ✓
May I commit?
```

- Wait for: APPROVE/承認/Yes/OK
- Commit

Think step-by-step before each phase. Test behavior, not implementation.
After completion, check TODO.md for next task or ask for priorities.

## ❓ Getting Help

- ALWAYS ask for clarification rather than making assumptions.
- If you're having trouble with something, it's ok to stop and ask for help. Especially if it's something your human might be better at.

## 🎗️ Important Instruction Reminders

- Use English for commit messages and comment in code
- Use `gh` to handle GitHub related resources
- Commit messages should be concise and descriptive in English
- Commit messages should use [Commitizen](https://github.com/commitizen/cz-cli) to follow the conventional commit format
- Commit messages should use [Commitizen](https://github.com/commitizen/cz-cli) to follow the conventional commit format
