import type { Plugin } from "@opencode-ai/plugin";

// TODO: Make it compatible with Linux as well as macOS
export const NotificationPlugin: Plugin = async ({ client, $ }) => {

  const sounds = {
    idle: "/System/Library/Sounds/Glass.aiff",
    error: "/System/Library/Sounds/Funk.aiff",
    asked: "/System/Library/Sounds/Submarine.aiff",
  } as const;

  const isMainSession = async (sessionID: string) => {
    try {
      const result = await client.session.get({ path: { id: sessionID } });
      const session = result.data ?? result;
      return !session.parentID
    } catch {
      return true;
    }
  };

  function escapeForAppleScript(str: string): string {
    return str
      .replace(/\\/g, '\\\\')
      .replace(/"/g, '\\"')
      .replace(/\n/g, '\\n')
      .replace(/\r/g, '\\r')
      .replace(/\t/g, '\\t');
  }

  async function playSound(soundPath: string): Promise<void> {
    if (process.platform !== "darwin") return;
    try {
      await $`afplay ${soundPath}`.quiet();
    } catch (e) {
      console.warn("Notification sound failed:", e);
    }
  }

  async function showNotification(title: string, message: string): Promise<void> {
    try {
      const script = `display notification "${escapeForAppleScript(message)}" with title "${escapeForAppleScript(title)}"`;
      await $`osascript -e ${script}`.quiet();
    } catch (e) {
      console.warn("Desktop notification failed:", e);
    }
  }

  async function notify(soundType: keyof typeof sounds, title: string, message: string): Promise<void> {
    await Promise.all([playSound(sounds[soundType]), showNotification(title, message)]);
  }

  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        const sessionID = event.properties.sessionID;
        if (await isMainSession(sessionID)) {
          await notify("idle", "OpenCode", "Waiting for user input");
        }
        return;
      }

      if (event.type === "session.error") {
        const errorEvent = event as { properties?: { error?: string } };
        const errorMessage = errorEvent.properties?.error ?? "An error occurred";
        await notify("idle", "OpenCode", errorMessage.slice(0, 100));
      }

      if (event.type === "permission.asked") {
        await playSound("asked");
      }
    },
  };
};
