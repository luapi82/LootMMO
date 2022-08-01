function COMBAT()
    return require(script:GetCustomProperty('Combat_Connector'))
end

local Root = script.parent
local Trigger = script:GetCustomProperty('Trigger'):WaitForObject()
local TrapActivationTemplate = script:GetCustomProperty('TrapActivationTemplate')
local damage = Root:GetCustomProperty('Damage')
local Stun = Root:GetCustomProperty('Stun')
local Bleed = Root:GetCustomProperty('Bleed')

while Root:GetCustomProperty('OwnerID') == '' do
    Task.Wait()
end

local ownerID = Root:GetCustomProperty('OwnerID')
local TrapOwner
for _, player in pairs(Game.GetPlayers()) do
    if player.id == ownerID then
        TrapOwner = player
        break
    end
end

if not TrapOwner then
    Root:Destroy()
    return
end

local OverlapEvent

function DoDamage(other)
    if other:IsA('Player') and other.team ~= TrapOwner.team and not other.isDead then
        other:ResetVelocity()
        if OverlapEvent then
            OverlapEvent:Disconnect()
            OverlapEvent = nil
        end
        Root.visibility = Visibility.FORCE_OFF
        World.SpawnAsset(
            TrapActivationTemplate,
            {position = Root:GetWorldPosition(), rotation = Root:GetWorldRotation()}
        )

        warn('AddBleed')
        warn('AddStun')

        local dmg = Damage.New()
        dmg.amount = damage

        dmg.reason = DamageReason.COMBAT
        dmg.sourcePlayer = TrapOwner

        local attackData = {
            object = other,
            damage = dmg,
            source = dmg.sourcePlayer,
            position = nil,
            rotation = nil,
            tags = {id = 'Hunter_R'}
        }
        COMBAT().ApplyDamage(attackData)
        Root:Destroy()
        Task.Wait()
        other:ResetVelocity()
    end
end

function OnBeginOverlap(thisTrigger, other)
    DoDamage(other)
end

Task.Wait(1)
for _, other in pairs(Trigger:GetOverlappingObjects()) do
    DoDamage(other)
end

if Object.IsValid(Trigger) then
    OverlapEvent = Trigger.beginOverlapEvent:Connect(OnBeginOverlap)
end