local addon = ReputationRenown

addon.TIERS = { "friendly", "honored", "revered", "exalted" }
addon.TIER_NAMES = {
    friendly = "Friendly",
    honored = "Honored",
    revered = "Revered",
    exalted = "Exalted",
}

-- These values are mock data until the game's reputation API is wired up.
addon.mockStanding = "honored"
addon.mockProgress = 5400
addon.mockMaximum = 12000

function addon:GetTierIndex(tier)
    for index, name in ipairs(self.TIERS) do
        if name == tier then return index end
    end
    return 0
end

function addon:IsTierUnlocked(tier, standing)
    return self:GetTierIndex(standing) >= self:GetTierIndex(tier)
end

function addon:GetFaction()
    return self.factions and self.factions.timbermaw
end
