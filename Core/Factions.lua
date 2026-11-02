local addon = ReputationRenown

addon.factions = addon.factions or {}
addon.factionsById = addon.factionsById or {}

-- Register a new faction
function addon:RegisterFaction(faction)
    assert(type(faction) == "table", "Faction must be a table")
    assert(type(faction.id) == "string", "Faction must have an id")
    assert(type(faction.name) == "string", "Faction must have a name")
    assert(type(faction.rewards) == "table", "Faction must have rewards")

    assert(
        not self.factions[faction.id],
        "Faction already registered: " .. faction.id
    )

    if faction.factionId then
        assert(
            not self.factionsById[faction.factionId],
            "Faction ID already registered"
        )
    end

    self.factions[faction.id] = faction

    if faction.factionId then
        self.factionsById[faction.factionId] = faction
    end
end

-- Get faction by internal key
function addon:GetFaction(key)
    return self.factions[key or "timbermaw"]
end

-- Get faction by WoW faction ID
function addon:GetFactionById(factionId)
    return self.factionsById[factionId]
end

-- Get rewards for a specific reputation standing
function addon:GetRewards(factionKey, tier)
    local faction = self:GetFaction(factionKey)

    if not faction then
        return {}
    end

    return faction.rewards[tier] or {}
end
