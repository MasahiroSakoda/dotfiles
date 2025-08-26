- Current directory: !`pwd`
- Task Master state: !`cat .taskmaster/state.json 2>/dev/null || echo "No state file yet"`
- Current tag: !`jq -r '.currentTag // "master"' .taskmaster/state.json 2>/dev/null || echo "master"`
- Available tags: !`jq -r '.tags | keys | join(", ")' .taskmaster/tasks/tasks.json 2>/dev/null || echo "No tags yet"`
- PRD files: !`ls -la .taskmaster/docs/prd*.md 2>/dev/null | tail -5 || echo "No PRD files found"`

## Goal

Parse a Product Requirements Document (PRD) into structured Task Master tasks. This command handles tag creation, context switching, and PRD parsing in a streamlined workflow.

## Process

### 1. Determine PRD Location

**Think about which PRD file the user wants to parse.**

Check for:

- Explicit PRD path in
- Default PRD location: `.taskmaster/docs/prd.txt` or `.taskmaster/docs/prd.md`
- Tag-specific PRD: `.taskmaster/docs/prd-[tag-name].md`

### 2. Tag Context Decision

Determine if we need a new tag:

- If PRD is for a specific feature → Create new tag
- If updating existing work → Use current tag
- If starting fresh → Consider new tag

### 3. Execute Parse Workflow

Based on context:

1. Create new tag if needed
2. Switch to appropriate tag
3. Parse the PRD
4. Generate tasks with proper numbering
5. Suggest next steps

## Execution Steps

### Scenario 1: Parse with New Tag Creation

If the user wants to parse a feature-specific PRD:

```markdown
1. **Create a new tag** for this feature:
   Using: add_tag with name and description

2. **Switch to the new tag**:
   Using: use_tag to set context

3. **Parse the PRD**:
   Using: parse_prd with the PRD path

4. **Confirm success**:
   Show task count and suggest next steps
```

### Scenario 2: Parse in Current Context

If parsing into the current tag:

```markdown
1. **Confirm current tag** is appropriate
   Show current tag context

2. **Parse the PRD directly**:
   Using: parse_prd with the PRD path

3. **Show results**:
   Display generated tasks summary
```

### Scenario 3: Parse Default PRD

If no specific PRD mentioned:

```markdown
1. **Check for default PRD**:
   Look for .taskmaster/docs/prd.txt or prd.md

2. **Confirm with user** if found
3. **Parse the default PRD**:
   Using: parse_prd
```

## Interactive Flow

Based on User Request, determine the appropriate flow:

### If arguments include a tag name

1. Create the tag
2. Switch to it
3. Parse the corresponding PRD

### If arguments include a PRD path

1. Ask if a new tag is needed
2. Parse the specified PRD

### If no arguments

1. Check current tag context
2. Look for default PRD
3. Proceed with parsing

## Best Practices

### DO

- **Check tag context** before parsing
- **Use descriptive tag names** for features
- **Keep PRDs organized** by feature/tag
- **Verify PRD exists** before parsing
- **Show task summary** after parsing

### DON'T

- **Parse into master tag** for feature work
- **Overwrite existing tasks** without confirmation
- **Mix unrelated features** in one tag
- **Skip tag creation** for new features

## Example Usage

```bash
# Parse default PRD in current context
/project:parse

# Parse specific PRD with new tag
/project:parse user-auth feature

# Parse existing PRD file
/project:parse .taskmaster/docs/prd-payments.md
```

## Natural Language Examples

Since MCP supports natural language:

```
"Please parse my PRD for the user authentication feature"
"Create tasks from the payments PRD and put them in a new tag"
"Parse the default PRD into the current tag context"
```

## Next Steps

After parsing, suggest:

1. **View generated tasks**: Use `/next` to see the first task
2. **Analyze complexity**: Run complexity analysis if many tasks
3. **Expand tasks**: Break down complex tasks into subtasks
4. **Start implementation**: Begin with the highest priority task

## Task Tracking

Add parsed PRD to todo list for tracking:

```typescript
{
  content: "Parse PRD: [filename]",
  status: "completed",
  priority: "high"
}
```

This helps track which PRDs have been processed and when.
