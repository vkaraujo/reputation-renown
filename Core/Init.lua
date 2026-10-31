-- Reputation Renown
-- Addon initialization

ReputationRenown = ReputationRenown or {}

local addon = ReputationRenown

addon.name = "Reputation Renown"
addon.version = "0.1.0"

-- Slash command: /rr
SLASH_REPUTATIONRENOWN1 = "/rr"

SlashCmdList["REPUTATIONRENOWN"] = function(msg)
    addon:ToggleReputationFrame()
end
