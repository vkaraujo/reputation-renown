-- Reputation Renown
-- Addon initialization

ReputationRenown = ReputationRenown or {}

local addon = ReputationRenown

addon.name = "Reputation Renown"
addon.version = "0.1.0"

-- Slash command: /rr
SLASH_REPUTATIONRENOWN1 = "/rr"

SlashCmdList["REPUTATIONRENOWN"] = function(msg)
    print("|cff00ff00Reputation Renown|r v" .. addon.version)
    print("Addon loaded successfully!")
end
