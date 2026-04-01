--!strict
local ByteNet = require(game.ReplicatedStorage.Packages.ByteNet)

return ByteNet.defineNamespace("Example", function()
	return {
		ExampleEvent = ByteNet.definePacket({ value = ByteNet.types.string }),
	}
end)
