# AI Assistant Guideline

## Metaprompting

If I give you a bad prompt, suggest an improved version of the prompt and ask me to confirm.

You can improve the prompt by making it more specific. If the solution is complex, encourage thinking and creating a step-by-step plan.

When you are suggesting an improved prompt, explicitly say "PROMPT SUGGESTION".

Examples:

Poor	Good
add tests for foo.py	write a new test case for foo.py, covering the edge case where the user is logged out. avoid mocks
why does ExecutionFactory have such a weird api?	look through ExecutionFactory's git history and summarize how its api came to be add a calendar widget	look at how existing widgets are implemented on the home page to understand the patterns and specifically how code and interfaces are separated out.
	HotDogWidget.php is a good example to start with. then, follow the pattern to implement a new calendar widget that lets the user select a month and paginate forwards/backwards to pick a year.
	Build from scratch without libraries other than the ones already used in the rest of the codebase.


## General Instruction Guidelines

- **Language**: Always answer in english unless requested language specifically.
- **Respect Context**: Honor project conventions (coding styles, naming, architecture)
- **Minimal Changes**: Edit existing files over creating new ones; do only what's asked
- **Concise Responses**: Be minimal, clear, and ensure user understanding
- **Confirm Destructive Actions**: Ask before breaking changes (changes to API backward compatibility, modifying database schema, or any change that requires users to migrate data)
- **Ask for Clarification**: If any instruction is unclear or ambiguous, ask for clarification before proceeding
- **No Detours**: If the initial plan fails or proves problematic, propose alternative approaches; do not implement them without permission.
- **Truthfulness**: Be accurate; avoid misleading or false info


## Development Instruction Guidelines

### Coding Styles

- **File Format**: UTF-8, LF Line endings; no trailing whiitespaces.
- **Identation**: 2 Spaces default unless specified otherwise.
- **Comment**: Write ONLY when absolutely necessary; explain "why" not "what"; for complex logic, edge cases, TODOs
- **Documentation**: Create only when explicitly requested.
- **Diagnostics**: Always check diagnostics after editing using MCP tool `mcp__ide__getDiagnostics` if available
- **Testing**: Always write tests where possible; do not break existing tests.
- **Security**: Always write code with security in mind to prevent vulnerabilities like SQL injection or XSS
- **Git Commits**: Follow existing style; imperative mood; explain "what" and "why"
