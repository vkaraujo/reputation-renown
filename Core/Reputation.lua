local addon = ReputationRenown

-- All classic reputation standings
addon.STANDINGS = {
    "hated",
    "hostile",
    "unfriendly",
    "neutral",
    "friendly",
    "honored",
    "revered",
    "exalted",
}

-- Only standings with reward milestones
addon.TIERS = {
    "friendly",
    "honored",
    "revered",
    "exalted",
}

addon.TIER_NAMES = {
    hated = "Hated",
    hostile = "Hostile",
    unfriendly = "Unfriendly",
    neutral = "Neutral",
    friendly = "Friendly",
    honored = "Honored",
    revered = "Revered",
    exalted = "Exalted",
}

-- Temporary data until the WoW reputation API is integrated
addon.mockStanding = "honored"
addon.mockProgress = 5400
addon.mockMaximum = 12000

-- Get the index of a reputation standing
function addon:GetStandingIndex(standing)
    for index, name in ipairs(self.STANDINGS) do
        if name == standing then
            return index
        end
    end

    return 0
end

-- Keep compatibility with the existing UI
function addon:GetTierIndex(tier)
    for index, name in ipairs(self.TIERS) do
        if name == tier then
            return index
        end
    end

    return 0
end

-- Check whether a reward tier is unlocked
function addon:IsTierUnlocked(tier, standing)
    local requiredIndex = self:GetStandingIndex(tier)
    local currentIndex = self:GetStandingIndex(standing)

    if requiredIndex == 0 or currentIndex == 0 then
        return false
    end

    return currentIndex >= requiredIndex
end
