local process = require("@lune/process")
-- local stdio = require("@lune/stdio")

local function runCommand(command, args)
    warn("Running: " .. command .. " " .. table.concat(args, " "))

    local success, result = pcall(function()
        return process.exec(command, args, {
            stdio = "inherit",
        })
    end)

    -- 1. Catch if the binary is missing (e.g., wally not found)
    if not success then
        -- warn() writes to stderr and is standard in Luau
        warn(`\n[ERROR] Failed to spawn command: '{command}'`)
        warn(`Details: {result}`)
        process.exit(1) -- Use os.exit, not process.exit
    end

    -- 2. Catch if the command ran but returned an error code
    if not result.ok then
        warn(`\nCommand failed: {command} {table.concat(args, " ")}`)
        process.exit(1)
    end
end

-- 1. wally install
runCommand("wally", { "install" })

-- 2. rojo sourcemap default.project.json -o sourcemap.json
runCommand("rojo", { "sourcemap", "default.project.json", "-o", "sourcemap.json" })

-- 3. wally-package-types --sourcemap sourcemap.json Packages
runCommand("wally-package-types", { "--sourcemap", "sourcemap.json", "Packages" })

print("Done!")
