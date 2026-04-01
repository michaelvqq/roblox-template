local StarterGui = game:GetService("StarterGui")

-- Disable Roblox's default leaderboard
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)

local Controllers = script.Controllers

local singletons = {}

local function safeRequire(module: ModuleScript)
	local success, result = pcall(require, module)
	if not success then
		warn(`Failed to load module {module.Name}: {result}`)
		return nil
	end
	return result
end

-- Load Controllers
for _, module in Controllers:GetChildren() do
	if module:IsA("ModuleScript") then
		local singleton = safeRequire(module)
		if singleton then
			singletons[module.Name] = singleton
		end
	end
end

-- Init Singletons (only Controllers get lifecycle calls)
for name, singleton in singletons do
	if type(singleton.Init) == "function" then
		local success, err = pcall(function()
			singleton:Init()
		end)
		if not success then
			warn(`Failed to Init singleton {name}: {err}`)
		end
	end
end

-- Start Singletons (only Controllers get lifecycle calls)
for name, singleton in singletons do
	if type(singleton.Start) == "function" then
		task.spawn(function()
			local success, err = pcall(function()
				singleton:Start()
			end)
			if not success then
				warn(`Failed to Start singleton {name}: {err}`)
			end
		end)
	end
end

print("Client started")
