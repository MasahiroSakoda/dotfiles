#!/usr/bin/env bun

import type { Payload } from "./types";

// Premium ANSI 256-color palette
const ANSI = {
  reset: "\x1b[0m",
  bold:  "\x1b[1m",
  dim:   "\x1b[2m",

  // Vibrant text colors (256-color palette)
  green:   "\x1b[38;5;78m",  // Emerald Green
  amber:   "\x1b[38;5;214m", // Amber/Orange
  blue:    "\x1b[38;5;39m",  // Bright Blue
  magenta: "\x1b[38;5;170m", // Lavender/Magenta
  purple:  "\x1b[38;5;141m", // Rich Purple
  red:     "\x1b[38;5;196m", // Bright Red
  cyan:    "\x1b[38;5;51m",  // Electric Cyan
  gray:    "\x1b[38;5;244m", // Medium Gray
};

// Separator styled in dimmed gray
const SEPARATOR = ` ${ANSI.dim}•${ANSI.reset} `;

// Function to abbreviate model names for visual compactness
function abbreviateModel(name: string | undefined): string {
  if (!name) return "Unknown Model";

  let effort = "";
  const lower = name.toLowerCase();

  // Extract effort level
  if (lower.includes("(low)")) effort = " (Low)";
  else if (lower.includes("(medium)")) effort = " (Mid)";
  else if (lower.includes("(high)")) effort = " (High)";
  else if (lower.includes("(thinking)")) effort = " (Think)";

  // Normalize name by removing parenthesized effort first
  const cleanName = name.replace(/\((low|medium|high)\)/gi, "").trim();
  const cleanLower = cleanName.toLowerCase();

  let baseName = cleanName;
  if (cleanLower.includes("gemini 3.5 flash") || lower.includes("gemini-3.5-flash")) {
    baseName = "3.5-Flash";
  } else if (cleanLower.includes("gemini 3.1 pro") || lower.includes("gemini-3.1-pro")) {
    baseName = "3.1-Pro";
  } else if (cleanLower.includes("claude opus 4.6") || lower.includes("claude-opus-4.6")) {
    baseName = "Opus 4.6";
  } else if (cleanLower.includes("claude sonnet 4.6") || lower.includes("claude-sonnet-4.6")) {
    baseName = "Sonnet 4.6";
  } else if (cleanLower.includes("gpt-oss 120b") || lower.includes("gpt-oss-120b")) {
    baseName = "GPT-OSS 120B";
  } else {
    basename = cleanName.replace(/gemini/gi, "").trim();
  }
  return `${baseName}${effort}`;
}

// Function to format and compact current working directory
function abbreviateSegment(segment: string): string {
  if (!segment) return "";
  if (segment === "~") return "~";
  const dotIdx = segment.indexOf(".");
  if (dotIdx !== -1) {
    if (dotIdx === 0) {
      return segment[0] + (segment[1] ?? "");
    } else {
      return segment[0] + "." + (segment[dotIdx + 1] ?? "");
    }
  }
  return segment[0];
}

function formatCwd(path: string | undefined): string {
  if (!path) return "~";
  const home = process.env.HOME;
  let formatted = path;

  if (home && path.startsWith(home)) {
    formatted = "~" + path.slice(home.length);
  }

  if (formatted.endsWith("/") && formatted !== "/") {
    formatted = formatted.slice(0, -1);
  }

  const parts = formatted.split("/");
  const abbreviatedParts = parts.map((part, index) => {
    if (index === parts.length - 1) {
      return part;
    }
    return abbreviateSegment(part);
  });
  return abbreviatedParts.join("/");
}

// Function to generate the visual progress bar for context token usage
function formatContext(contextWindow: Payload["context_window"]): string {
  if (!contextWindow) return `${ANSI.gray}[░░░░░░░░] 0%${ANSI.reset}`;

  const percentage = contextWindow.used_percentage;

  const filledLength = Math.max(0, Math.min(8, Math.round((percentage / 100) * 8)));
  const unfilledLength = 8 - filledLength;

  const filled = "■".repeat(filledLength);
  const unfilled = "░".repeat(unfilledLength);

  let barColor = ANSI.green;
  if (percentage > 80) {
    barColor = ANSI.red;
  } else if (percentage > 60) {
    barColor = ANSI.amber;
  }

  const pctString = `${Math.round(percentage)}%`;
  return `💬 ${barColor}[${filled}${unfilled}]${ANSI.reset} ${ANSI.bold}${pctString}${ANSI.reset}`;
}

// Main processing function
async function main(): Promise<void> {
  let payload: Payload;

  try {
    const text = await Bun.stdin.text();
    if (!text || !text.trim()) {
      console.error(`${ANSI.red}${ANSI.bold}⚠️ Error: stdin is empty. This script requires a JSON payload piped to stdin.${ANSI.reset}`);
      process.exit(1);
    }
    payload = JSON.parse(text);
    if (!payload || typeof payload !== "object") {
      throw new Error("Parsed JSON is not an object")
    }
  } catch (err: unknown) {
    console.error(`${ANSI.red}${ANSI.bold}⚠️ Error parsing JSON from stdin: ${err.message}${ANSI.reset}`);
    process.exit(1);
  }

  // Field 1: State (Ready | Thinking | Working)
  const status = payload.agent_state?.status || "Ready";
  let stateStr = "";
  if (status === "thinking") {
    stateStr = `🤔${ANSI.amber}${ANSI.bold}${ANSI.reset}`;
  } else if (status === "working") {
    stateStr = `🚧${ANSI.blue}${ANSI.bold}${ANSI.reset}`;
  } else if (status === "initializing") {
    stateStr = `⏳${ANSI.green}${ANSI.bold}${ANSI.reset}`;
  } else if (status === "tool_use") {
    stateStr = `🛠️${ANSI.green}${ANSI.bold}${ANSI.reset}`;
  } else {
    stateStr = `🟢${ANSI.green}${ANSI.bold}${ANSI.reset}`;
  }

  // Field 2: Model Name
  const modelName = abbreviateModel(payload.model?.display_name || payload.model?.id);
  const modelStr = `🤖 ${ANSI.magenta}${modelName}${ANSI.reset}`;

  // Field 3: Sandbox Status
  const isSandbox = payload.sandbox !== false; // Default to true if not specified
  const sandboxStr = isSandbox
    ? `${ANSI.green}🛡️ sandbox${ANSI.reset}`
    : `${ANSI.red}${ANSI.bold}⚠️ no-sandbox${ANSI.reset}`;

  // Field 4: Current Directory
  const cwdStr = `📁 ${ANSI.cyan}${formatCwd(payload.cwd)}${ANSI.reset}`;

  // Field 5: Context Token Usage
  const contextStr = formatContext(payload.context_window);

  // Field 6: Remaining Tasks
  const tasksCount = payload.tasks ? payload.tasks.length : 0;
  const tasksStr = tasksCount > 0
    ? `${ANSI.amber}📋 ${tasksCount} ${ANSI.reset}`
    : `${ANSI.gray}📋 0 ${ANSI.reset}`;

  // Field 7: Artifacts
  const artifactsCount = payload.artifacts ? payload.artifacts.length : 0;
  const artifactsStr = artifactsCount > 0
    ? `${ANSI.purple}📦 ${artifactsCount} ${ANSI.reset}`
    : `${ANSI.gray}📦 0 ${ANSI.reset}`;

  // Print the finalized status line to stdout
  const statusline = [
    stateStr,
    modelStr,
    sandboxStr,
    cwdStr,
    contextStr,
    tasksStr,
    artifactsStr,
  ].join(SEPARATOR);

  // console.log(statusline);
  console.log(`${statusline}`)
}

main();
