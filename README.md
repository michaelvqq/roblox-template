# roblox-template

Roblox project starter. Includes full toolchain, all packages, and src skeleton.

## Setup

1. `rokit install`
2. `lune run refresh` — installs packages, generates types + sourcemap
3. `lune run dev` — starts Rojo + sourcemap watcher

## Commands

| Command | Purpose |
|---------|---------|
| `wally install` | Reinstall packages |
| `lune run refresh` | Regenerate types + sourcemap |
| `lune run dev` | Start dev session |
| `selene src/` | Lint (must pass with zero warnings) |

## After cloning

- `wally.toml` — update `[package] name` to your project
- `default.project.json` — update `"name"` to your project name
- `src/server/SETTINGS.luau` — update `DATASTORE_NAME` to a new unique key
- GitHub: Settings → check **Template repository**
