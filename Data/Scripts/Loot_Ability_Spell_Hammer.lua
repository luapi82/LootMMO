local MODIFIERS = require(script:GetCustomProperty('Modifiers'))
properties = {
    description = script:GetCustomProperty('Description'),
    icon = script:GetCustomProperty('Icon')
}

modifiers = {
    [MODIFIERS.DamageRange.name] = setmetatable({}, {__index = MODIFIERS.DamageRange}),
    [MODIFIERS.Cooldown.name] = setmetatable({}, {__index = MODIFIERS.Cooldown}),
    [MODIFIERS.ChargingDamage.name] = setmetatable({}, {__index = MODIFIERS.ChargingDamage})
}

modifiers[MODIFIERS.DamageRange.name].calculation = function(self, stats)
    return 2
end
modifiers[MODIFIERS.Cooldown.name].calculation = function(self, stats)
    return 2
end
modifiers[MODIFIERS.ChargingDamage.name].calculation = function(self, stats)
    return 2
end