## Process Overview
1. **Identify Changes**: Analyze the staged changes.
2. **Read and Analyze files**:
3. **Comprehensive Pattern Analysis**:
4. **Anti-Pattern Detection**:
5. **Generate Structured Review Report**:
6. **Provide Actionable Next Steps**:

## Review Instructions

### Step 0: Check for Staged

Check repository status with `git status`. If nothing is staged at the moment, exit command with warning messages.

### Step 1: Change Analysis

Analyze the changes by:
- Examining staged files using `git diff --staged`

### Step 2: Read and Analyze files

For each file to review:
1. Read the entire file carefully
2. Understand the context (module, package, configuration)
3. Identify the purpose and scope

### Step 3: Comprehensive Pattern Analysis

#### Code Quality Review

- ✅ **Readability**: Is the code readable and self-documenting?
- ✅ **Duplication**: Check repeated patterns?
- ✅ **Complexity**: Is there appropriate commenting for complex logic?
- ✅ **Functionality**: Are functions/methods focused and not too long?

#### Security Review

- ✅ **Service isolation**: Is authentication/authorization handled correctly?
- ✅ **Secret management**: Are sensitive data properly protected?

#### Performance Review

- ✅ **Bottlenecks**: Are there any obvious performance bottlenecks?

<!-- NOTE: Add project-specific review item from best practices document -->

### Step 4: Anti-Pattern Detection

<!-- NOTE: Add project-specific review item for following headings from anti-pattern document -->
#### Language Anti-Patterns

#### Security Anti-Patterns

#### Package Writing Anti-Patterns

#### #### Module System Anti-Patterns

#### Architecture Anti-Patterns

### Step 5: Generate Structured Review Report

Provide output in this format:

`````markdown
## Code Review Report

### Files Reviewed
- path/to/file1
- path/to/file2
- path/to/file3

### Summary
[Brief overview of the code quality and purpose]

---
## ✅ Strengths

### What's Done Well
1. **[Pattern/Aspect]**: [Specific example from code]
2. **[Pattern/Aspect]**: [Specific example]
  ...

## ⚠️ Issues Found

### Critical Issues (Must Fix)
1. **[Anti-Pattern Name]** (Line XX)
  ```
  [Code snippet showing the issue]
  ```
  - **Problem**: [Clear explanation of why this is wrong]
  - **Fix**: [Specific solution with code example]
  - **Reference**: [Section in NIXOS-ANTI-PATTERNS.md]
  - **Impact**: [Security/Performance/Maintainability impact]

### Recommended Improvements (Should Fix)
1. **[Improvement Area]** (Line XX)
  ```text
  [Code Snippet]
  ```
  - **Suggestion**: [How to improve]
  - **Benefit**: [Why this matters]

### Minor Suggestions (Nice to Have)
1. **[Suggestion]** (Line XX)
- [Brief description]

---
## 📋 Checklist Results

### Language & Syntax
- [x] Passed linter

### Module System

### Security & Safety
- [x] Secrets use runtime loading
- [x] Services run with minimal privileges

### Package Writing (if applicable)


---
## 🔧 Recommended Actions
### Immediate (Before Merge)
1. Fix [Critical Issue 1]
2. Fix [Critical Issue 2]

### Short-term (This Week)
1. Implement [Recommended Improvement 1]
2. Add [Missing Feature]

### Long-term (Future Enhancement)
1. Consider [Architectural Improvement]

---
## 📚 References

Key documentation sections to review:
- Official docs: [Relevant links]

---
## 💯 Overall Assessment

**Code Quality Score**: [X/10]

**Readability**: [Score/10] - [Brief comment]
**Security**: [Score/10] - [Brief comment]
**Performance**: [Score/10] - [Brief comment]
**Maintainability**: [Score/10] - [Brief comment]
**Best Practices Adherence**: [Score/10] - [Brief comment]

**Recommendation**: [APPROVE / APPROVE WITH CHANGES / NEEDS WORK]

**Summary**: [1-2 sentence overall assessment]

`````

### Step 6: Provide Actionable Next Steps

After the review report, offer:

1. **Quick fixes**: Provide exact code snippets to replace problematic code
2. **Example implementations**: Show how to implement recommended improvements
3. **Testing guidance**: Suggest how to test the changes
4. **Documentation links**: Point to specific sections in PATTERNS.md or ANTI-PATTERNS.md

## Review Best Practices

1. **Be Constructive**: Focus on education, not criticism
2. **Be Specific**: Always reference line numbers and provide code examples
3. **Prioritize**: Separate critical issues from nice-to-haves
4. **Explain Why**: Always explain why something is an anti-pattern
5. **Provide Solutions**: Don't just identify problems, show how to fix them
6. **Reference Documentation**: Link to specific sections in PATTERNS.md or ANTI-PATTERNS.md
7. **Consider Context**: Understand the purpose before suggesting changes
8. **Check Thoroughly**: Review against the entire checklist in ANTI-PATTERNS.md

## Usage Examples

## Important Notes

- **Always read the full files** - Don't make assumptions based on partial code
- **Check the complete checklist** - Use the comprehensive checklist from ANTI-PATTERNS.md
- **Provide examples** - Show correct code alongside identified issues
- **Be thorough** - This is meant to be a comprehensive, in-depth review
- **Follow the structure** - Use the report format consistently
- **Reference line numbers** - Always specify exact locations of issues

## After Review

Once the review is complete, offer to:
1. Create a summary document
2. Help implement the fixes
3. Re-review after changes are made
4. Explain any patterns or anti-patterns in more detail
