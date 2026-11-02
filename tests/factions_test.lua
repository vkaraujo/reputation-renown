-- Initialize namespace without the WoW client
ReputationRenown = {}

local addon = ReputationRenown

-- Load our modules
dofile("Core/Factions.lua")
dofile("Core/Reputation.lua")
dofile("Data/TimbermawHold.lua")

-- Test faction registration
local faction = addon:GetFaction("timbermaw")

assert(faction ~= nil)
assert(faction.name == "Timbermaw Hold")
assert(faction.factionId == 576)

-- Test lookup by faction ID
local byId = addon:GetFactionById(576)

assert(byId == faction)

-- Test reward counts
assert(#addon:GetRewards("timbermaw", "friendly") == 4)
assert(#addon:GetRewards("timbermaw", "honored") == 4)
assert(#addon:GetRewards("timbermaw", "revered") == 6)
assert(#addon:GetRewards("timbermaw", "exalted") == 1)

-- Test total rewards
local total = 0

for _, tier in ipairs(addon.TIERS) do
    total = total + #addon:GetRewards("timbermaw", tier)
end

assert(total == 15)

-- Test reputation unlock logic
assert(addon:IsTierUnlocked("friendly", "honored"))
assert(addon:IsTierUnlocked("honored", "honored"))
assert(not addon:IsTierUnlocked("revered", "honored"))
assert(not addon:IsTierUnlocked("friendly", "neutral"))
assert(not addon:IsTierUnlocked("friendly", "invalid"))

-- Test missing faction
assert(#addon:GetRewards("unknown", "friendly") == 0)

print("All faction tests passed!")
