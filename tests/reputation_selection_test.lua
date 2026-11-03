ReputationRenown = {}

local addon = ReputationRenown

-- Load domain modules
dofile("Core/Factions.lua")
dofile("Core/Reputation.lua")
dofile("Data/TimbermawHold.lua")

-- Load interface coordinator
dofile("UI/ReputationFrame.lua")

-- Initial state
assert(addon.selectedFaction == "timbermaw")
assert(addon.selectedTier == "friendly")

-- Select a valid tier
addon:SelectTier("revered")

assert(addon.selectedTier == "revered")

-- Invalid tiers should be ignored
addon:SelectTier("invalid")

assert(addon.selectedTier == "revered")

-- Select a valid faction
assert(addon:SelectFaction("timbermaw"))

assert(addon.selectedFaction == "timbermaw")
assert(addon.selectedTier == "friendly")

-- Invalid factions should be rejected
assert(not addon:SelectFaction("unknown"))

assert(addon.selectedFaction == "timbermaw")

-- Mock reputation
local reputation = addon:GetCurrentReputation()

assert(reputation.standing == "honored")
assert(reputation.current == 5400)
assert(reputation.maximum == 12000)
assert(reputation.isMock)

print("All reputation selection tests passed!")
