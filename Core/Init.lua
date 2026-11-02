-- The global table is shared across files listed in the .toc.
ReputationRenown = ReputationRenown or {}
local addon = ReputationRenown

addon.name = "Reputation Renown"
addon.version = "0.2.0"

SLASH_REPUTATIONRENOWN1 = "/rr"
SlashCmdList["REPUTATIONRENOWN"] = function()
    addon:ToggleReputationFrame()
end
