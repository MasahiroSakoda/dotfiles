export interface Payload {
  agent_state?: {status?: string;};
  model?: {id?: string; display_name?: string;};
  sandbox?: boolean;
  cwd?: string;
  vcs?: {type?: string; branch?: string; dirty: boolean;};
  context_window?: {used_percentage?: number; used?: number; limit?: number;};
  tasks?: Array<{ title?: string }>;
  artifacts?: Array<{ title?: string }>;
}
