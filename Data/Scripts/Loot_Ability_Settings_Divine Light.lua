local MODIFIERS = require(script:GetCustomProperty('Modifiers'))
local STATS_CONNECTOR = require(script:GetCustomProperty('Stats_Connector'))
local ROOT_CALCULATION_API = require(script:GetCustomProperty('RootCalculation_Api'))
local ROOT = script:GetCustomProperty('Root'):WaitForObject()

local modifiers = {
    [MODIFIERS.Radius.name] = setmetatable({}, {__index = MODIFIERS.Radius}),
    [MODIFIERS.Cooldown.name] = setmetatable({}, {__index = MODIFIERS.Cooldown}),
    [MODIFIERS.Heal.name] = setmetatable({}, {__index = MODIFIERS.Heal})
}
modifiers[MODIFIERS.Radius.name].calculation = function()
    return 2
end
modifiers[MODIFIERS.Cooldown.name].calculation = function()
    return 6
end
modifiers[MODIFIERS.Heal.name].calculation = function()
    return 2
end

ROOT_CALCULATION_API.RegisterCalculation(ROOT, modifiers)