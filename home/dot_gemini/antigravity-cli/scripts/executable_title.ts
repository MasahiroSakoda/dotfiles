#!/usr/bin/env bun

import type { Payload } from "./types";

// Separator styled in dimmed gray
const SEPARATOR = ` • `;

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

async function main(): Promise<void> {
  let payload: Payload
  try {
    const text = await Bun.stdin.text();
    if (!text || !text.trim()) {
      console.error("⚠️ Error: stdin is empty. This script requires a JSON payload piped to stdin.");
    }
    payload = JSON.parse(text);
    if (!payload || typeof payload !== "object") {
      throw new Error("Parsed JSON is not an object")
    }

    const title = [formatCwd(payload.cwd)].join(SEPARATOR)
    process.stdout.write(`agy: ${title} \n`);
  } catch (err: unknown) {
    console.error(`${ANSI.red}${ANSI.bold}⚠️ Error parsing JSON from stdin: ${err.message}${ANSI.reset}`);
    process.exit(1);
  }
}

main();
