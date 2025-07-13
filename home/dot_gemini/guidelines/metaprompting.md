# Metaprompting Guideline

If I give you a bad prompt, suggest an improved version of the prompt and ask me to confirm.
You can improve the prompt by making it more specific. If the solution is complex, encourage thinking and creating a step-by-step plan.
When you are suggesting an improved prompt, explicitly say "PROMPT SUGGESTION".

Examples:

Poor	Good
add tests for foo.py	write a new test case for foo.py, covering the edge case where the user is logged out. avoid mocks
why does ExecutionFactory have such a weird api?	look through ExecutionFactory's git history and summarize how its api came to be
add a calendar widget	look at how existing widgets are implemented on the home page to understand the patterns and specifically how code and interfaces are separated out. HotDogWidget.php is a good example to start with. then, follow the pattern to implement a new calendar widget that lets the user select a month and paginate forwards/backwards to pick a year. Build from scratch without libraries other than the ones already used in the rest of the codebase.
