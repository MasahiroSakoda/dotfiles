import type { Plugin } from '@opencode-ai/plugin';

// ─── Category 1: Dangerous Bash Commands ─────────────────────────────────────
const DANGEROUS_BASH_PATTERNS: RegExp[] = [
  /\brm\s+(?:-[^\s]*\s+)*-[rRf]\b/,
  /\brm\s+.*--(recursive|force)/,
  /\bsudo\s+/,
  /\bchmod\s+(-[^\s]+\s+)*0?777\b/,
  /\bchmod\s+-[Rr].*0?777/,
  /\bchown\s+-[Rr].*\broot\b/,
  /\bkill\s+-9\s+-1\b/,
  /\bkillall\s+-9\b/,
  /\bpkill\s+-9\b/,
  /\bmkfs\./,
  /\bdd\s+.*of=\/dev\//,
  /\bhistory\s+-c\b/,
  /\bcurl\s+.*\|\s*(bash|sh|zsh)\b/,
  /\bwget\s+.*\|\s*(bash|sh|zsh)\b/,
  /\bmv\s+.*\/dev\/null/,
];

// ─── Category 2: Secret/Credential Access (bash) ─────────────────────────────
const SECRET_BASH_PATTERNS: RegExp[] = [
  /(cat|vim|nano|less|head|tail|base64|grep|sed|awk|sort|cut)\s+.*\.env\b(?!\.sample|\.example)/,
  /(cat|vim|nano|less|head|tail|cp|scp|rsync)\s+.*\/(\.(ssh|aws|gcp|gnupg))\//,
  /(cat|vim|nano|less|head|tail)\s+.*\.(pem|key|p12|pfx)\b/,
  /(cat|vim|nano|less|head|tail|grep|sed|awk|sort|cut)\s+.*credentials/,
  /(cp|scp|rsync)\s+.*\.(env|pem|key|p12|pfx)\b/,
  /(cp|scp|rsync)\s+.*\/(\.(ssh|aws|gcp|gnupg))\//,
];

// ─── Category 2: Secret/Credential Access (file paths) ───────────────────────
const SECRET_PATH_PATTERNS: RegExp[] = [
  /\/\.env(?!\.sample|\.example)/,
  /\/\.env\.(?!sample|example)/,
  /\/\.ssh\//,
  /\/\.aws\//,
  /\/\.gcp\//,
  /\/\.gnupg\//,
  /\/(\.(ssh|aws|gcp|gnupg))\/.*(pem|key|p12|pfx)$/,
  /\/\.tfstate$/,
  /\/(\.|^)credentials$/,
  /\/credentials\.(json|yaml|yml|xml|toml)$/,
];

// ─── Category 3: Destructive File Paths ──────────────────────────────────────
const DESTRUCTIVE_PATH_PATTERNS: RegExp[] = [
  /\/node_modules\//,
  /\/dist\//,
  /\/build\//,
  /\/\.next\//,
  /\/__pycache__\//,
  /\/\.venv\//,
  /package-lock\.json$/,
  /yarn\.lock$/,
  /pnpm-lock\.yaml$/,
  /bun\.lockb$/,
  /\.min\.(js|css)$/,
  /\.bundle\.js$/,
];

// ─── Category 4: Cloud CLI Destructive Ops ───────────────────────────────────
const CLOUD_CLI_PATTERNS: RegExp[] = [
  /\baws\s+s3\s+rm\s+.*--recursive/,
  /\baws\s+ec2\s+terminate-instances\b/,
  /\baws\s+rds\s+delete-db-instance\b/,
  /\baws\s+cloudformation\s+delete-stack\b/,
  /\baws\s+dynamodb\s+delete-table\b/,
  /\bgcloud\s+projects\s+delete\b/,
  /\bgcloud\s+compute\s+instances\s+delete\b/,
  /\bgcloud\s+sql\s+instances\s+delete\b/,
  /\bgcloud\s+container\s+clusters\s+delete\b/,
  /\bvercel\s+remove\s+.*--yes/,
  /\bvercel\s+projects\s+rm\b/,
  /\bdocker\s+system\s+prune\s+.*-a/,
  /\bdocker\s+volume\s+(rm|prune)\b/,
  /\bkubectl\s+delete\s+namespace\b/,
  /\bkubectl\s+delete\s+all\s+--all/,
  /\bterraform\s+destroy\b/,
  /\bpulumi\s+destroy\b/,
  /\bheroku\s+apps:destroy\b/,
  /\bheroku\s+pg:reset\b/,
  /\bredis-cli\s+FLUSHALL/,
  /\bredis-cli\s+FLUSHDB/,
  /\bgh\s+repo\s+delete\b/,
  /\bgh\s+pr\s+merge\b/,
  /\bnpm\s+unpublish\b/,
];

// ─── Category 4b: Database Destructive Ops ─────────────────────────────────
const DATABASE_DESTRUCTIVE_PATTERNS: RegExp[] = [
  /DROP\s+(TABLE|DATABASE)\b/i,
  /TRUNCATE\s+TABLE\b/i,
  /DELETE\s+FROM\s+\w+/i,
];

// ─── Category 5: Git Safety ─────────────────────────────────────────────────
const GIT_SAFETY_PATTERNS: RegExp[] = [
  /\bgit\s+reset\s+--hard\b/,
  /\bgit\s+clean\s+.*-[fFxX]/,
  /\bgit\s+push\s+.*--force(?!-with-lease|-if-includes)/,
  /\bgit\s+push\s+.*-[^\s]*f/,
  /\bgit\s+stash\s+clear\b/,
  /\bgit\s+reflog\s+expire\b/,
  /\bgit\s+gc\s+.*--prune=now/,
  /\bgit\s+filter-branch\b/,
];

// ─── Category 6: Data Exfiltration ──────────────────────────────────────────
// Catches indirect file reading via network tools (curl @file, wget --post-file, etc.)
const EXFILTRATION_PATTERNS: RegExp[] = [
  // curl @file syntax — reads local file contents into request body / form data
  /\bcurl\b.*@\S*\/(\.(ssh|aws|gcp|gnupg))\//,
  /\bcurl\b.*@\S*\.env\b(?!\.sample|\.example)/,
  /\bcurl\b.*@\S*\.(pem|key|p12|pfx)\b/,
  /\bcurl\b.*@\S*credentials\b/,
  /\bcurl\b.*@\S*\bid_(rsa|ed25519|ecdsa|dsa)\b/,
  // curl --upload-file / -T with sensitive paths
  /\bcurl\b.*(-T|--upload-file)\s+\S*\/(\.(ssh|aws|gcp|gnupg))\//,
  /\bcurl\b.*(-T|--upload-file)\s+\S*\.(env|pem|key|p12|pfx)\b/,
  // wget --post-file with sensitive paths
  /\bwget\b.*--post-file\s*=?\s*\S*\/(\.(ssh|aws|gcp|gnupg))\//,
  /\bwget\b.*--post-file\s*=?\s*\S*\.(env|pem|key|p12|pfx)\b/,
  // netcat/socat with input redirection from sensitive files
  /\b(nc|ncat|socat)\b.*<\s*\S*\/(\.(ssh|aws|gcp|gnupg))\//,
  /\b(nc|ncat|socat)\b.*<\s*\S*\.(pem|key|p12|pfx)\b/,
  // openssl s_client with sensitive file input
  /\bopenssl\b.*s_client.*<\s*\S*\/(\.(ssh|aws|gcp|gnupg))\//,
];

// Broad heuristic — block if command has BOTH a sensitive path AND outbound network
const SENSITIVE_PATH_INDICATORS: RegExp[] = [
  /\/(\.(ssh|aws|gcp|gnupg))\//,
  /\.env\b(?!\.sample|\.example)/,
  /\.(pem|key|p12|pfx)\b/,
  /\/credentials\b/,
  /\bid_(rsa|ed25519|ecdsa|dsa)\b/,
];

const OUTBOUND_INDICATORS: RegExp[] = [
  /https?:\/\//,
  /\bcurl\b/,
  /\bwget\b/,
  /\b(nc|ncat|netcat)\s+\S+\s+\d+/,
  /\bsocat\b.*TCP/i,
  /\bsendmail\b/,
  /\btelnet\b/,
];

// TODO: permission.ask hook may be dead code due to OpenCode bug #7006.
// Remove this workaround if/when the hook starts firing reliably.
// ─── Safe Patterns for permission.ask auto-approval ──────────────────────────
const SAFE_BASH_PATTERNS: RegExp[] = [
  /^(ls|ls\s)/,
  /^(git\s+(status|diff|log|show|branch|remote|stash\s+list|ls-files|grep))/,
  /^(cat\s+(?!.*\.(env|pem|key)))/,
  /^(grep|find\s+(?!.*-delete|-exec))/,
  /^(bun\s+(test|run\s+typecheck))/,
  /^(npm\s+view)/,
  /^(gh\s+(pr|issue|repo|release|run|search)\s+(view|list|checks|diff))/,
  /^(date|pwd|which|tree|stat|head|tail|wc|file|mkdir\s+-p)/,
];

function testPatterns(value: string, patterns: RegExp[]): RegExp | undefined {
  for (const pattern of patterns) {
    if (pattern.test(value)) {
      return pattern;
    }
  }
  return undefined;
}

function hasExfiltrationRisk(cmd: string): boolean {
  const hasSensitivePath = SENSITIVE_PATH_INDICATORS.some((p) => p.test(cmd))
  const hasOutbound = OUTBOUND_INDICATORS.some((p) => p.test(cmd))
  return hasSensitivePath && hasOutbound
}

export const EnvProtectionPlugin: Plugin = async () => {
  return {
    "tool.execute.before": async (input, output) => {
      try {
        if (input.tool === "bash" && typeof output.args?.command === "string") {
          const cmd = output.args.command;

          const dangerousMatch = testPatterns(cmd, DANGEROUS_BASH_PATTERNS);
          if (dangerousMatch) {
            throw new Error(`[damage-control] BLOCKED: Dangerous bash command matched ${dangerousMatch}`);
          }

          const secretMatch = testPatterns(cmd, SECRET_BASH_PATTERNS);
          if (secretMatch) {
            throw new Error(`[damage-control] BLOCKED: Secret/credential access matched ${secretMatch}`);
          }

          const cloudMatch = testPatterns(cmd, CLOUD_CLI_PATTERNS);
          if (cloudMatch) {
            throw new Error(`[damage-control] BLOCKED: Destructive cloud CLI operation matched ${cloudMatch}`);
          }

          const dbMatch = testPatterns(cmd, DATABASE_DESTRUCTIVE_PATTERNS);
          if (dbMatch) {
            throw new Error(`[damage-control] BLOCKED: Destructive database operation matched ${dbMatch}`);
          }

          const gitMatch = testPatterns(cmd, GIT_SAFETY_PATTERNS);
          if (gitMatch) {
            throw new Error(`[damage-control] BLOCKED: Dangerous git operation matched ${gitMatch}`);
          }

          const exfilMatch = testPatterns(cmd, EXFILTRATION_PATTERNS);
          if (exfilMatch) {
            throw new Error(`[damage-control] BLOCKED: Data exfiltration attempt matched ${exfilMatch}`);
          }

          if (hasExfiltrationRisk(cmd)) {
            throw new Error(`[damage-control] BLOCKED: Command references both sensitive files and outbound network destination`);
          }
        }

        // ── Read tool checks (Category 2: secrets) ──
        if (input.tool === "read" && typeof output.args?.filePath === "string") {
          const filePath = output.args.filePath;

          const secretPathMatch = testPatterns(filePath, SECRET_PATH_PATTERNS);
          if (secretPathMatch) {
            throw new Error(`[damage-control] BLOCKED: Reading secret/credential file matched ${secretPathMatch}`);
          }
        }
        // ── Edit/Write tool checks (Categories 2, 3) ──
        if ((input.tool === "edit" || input.tool === "write") && typeof output.args?.filePath === "string") {
          const filePath = output.args.filePath;

          const secretPathMatch = testPatterns(filePath, SECRET_PATH_PATTERNS);
          if (secretPathMatch) {
            throw new Error(`[damage-control] BLOCKED: Writing to secret/credential file matched ${secretPathMatch}`);
          }

          const destructiveMatch = testPatterns(filePath, DESTRUCTIVE_PATH_PATTERNS);
          if (destructiveMatch) {
            throw new Error(`[damage-control] BLOCKED: Writing to generated/locked file matched ${destructiveMatch}`);
          }
        }

      } catch (err) {
        if (err instanceof Error && err.message.startsWith("[damage-control] BLOCKED")) {
          throw err;
        }
        console.error("[damage-control] tool.execute.before error:", err);
      }
    },
    "permission.ask": async (input, output) => {
      try {
        // Auto-approve safe bash patterns
        if (input.type === "bash" && input.metadata) {
          const command = input.metadata.command;
          if (typeof command === "string") {
            const safeMatch = testPatterns(command, SAFE_BASH_PATTERNS);
            if (safeMatch) {
              output.status = "allow";
            }
          }
        }
      } catch (err) {
        // Fail-open — don't block permission flow on unexpected errors
        console.error("[damage-control] permission.ask error:", err);
      }
    },
  }
}
