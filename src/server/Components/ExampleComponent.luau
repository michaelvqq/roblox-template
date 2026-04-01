--!strict
local ExampleComponent = {}
ExampleComponent.__index = ExampleComponent

function ExampleComponent.new()
	return setmetatable({}, ExampleComponent)
end

return ExampleComponent
