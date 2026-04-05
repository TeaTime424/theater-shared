#!/bin/bash
# Auto-sync hooks for Claude Code web sessions only.
# Detects web environment and configures git pull/push hooks in ~/.claude/settings.json.
# No-op on local PC.

if [ "$CLAUDE_CODE_REMOTE_ENVIRONMENT_TYPE" != "cloud_default" ]; then
  exit 0
fi

BRANCH=$(git -C /home/user/theater-shared rev-parse --abbrev-ref HEAD 2>/dev/null || echo "master")
SETTINGS="$HOME/.claude/settings.json"

# Read existing settings, merge our hooks in
python3 -c "
import json, os, sys

path = '$SETTINGS'
try:
    with open(path) as f:
        cfg = json.load(f)
except:
    cfg = {}

cfg.setdefault('hooks', {})
branch = '$BRANCH'
pull_cmd = f'cd /home/user/theater-shared && git pull origin {branch} 2>/dev/null || true'
push_cmd = f\"cd /home/user/theater-shared && git add -A && git diff --cached --quiet || (git commit -m 'auto: update files' && git push -u origin {branch})\"

hook_entry = lambda cmd: [{'hooks': [{'type': 'command', 'command': cmd}]}]
match_entry = lambda matcher, cmd: [{'matcher': matcher, 'hooks': [{'type': 'command', 'command': cmd}]}]

cfg['hooks']['UserPromptSubmit'] = hook_entry(pull_cmd)
cfg['hooks']['PostToolUse'] = match_entry('Edit|Write', push_cmd)

with open(path, 'w') as f:
    json.dump(cfg, f, indent=4)
"
