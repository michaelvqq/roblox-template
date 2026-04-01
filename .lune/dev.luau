-- lune/dev.luau
local process = require("@lune/process")

local STDIO_FORWARD = { stdio = "forward" :: "forward" }

-- 1. Start Sourcemap Watcher (Background)
-- We use 'process.create' here because we want it to run in the background
-- without stopping our script. We don't need task.spawn() because create() is already non-blocking.
print("🗺️  Spawning Rojo sourcemap watch...")
local sourcemap = process.create(
	"rojo",
	{ "sourcemap", "--output", "sourcemap.json", "--include-non-scripts", "--watch" },
	STDIO_FORWARD
)

-- 2. Start Rojo Serve (Foreground / Blocking)
-- We use 'process.exec' here. It will start Rojo and BLOCK this script until Rojo exits.
-- Because we use stdio="forward", the output will stream directly to your terminal in real-time.
print("🚀 Spawning Rojo serve...")
process.exec("rojo", { "serve" }, STDIO_FORWARD)

-- 3. Cleanup (Optional)
-- If Rojo Serve stops (you press Ctrl+C or it crashes), the script reaches here.
-- We can kill the sourcemap process to be clean.
if sourcemap then
	pcall(function()
		sourcemap:kill()
	end)
end
