local addon = ReputationRenown

addon.PLACEHOLDER_ICON = "Interface\\Icons\\INV_Misc_QuestionMark"

-- Creates a standardized reward entry.
--
-- name: Item name
-- category: Item category or profession
-- price: Vendor price in copper (optional)
-- itemId: WoW item ID
-- options: Additional acquisition metadata (optional)
--
-- Supported optional fields:
-- source: "vendor", "quest", "drop" or "unknown"
-- questItem: Whether the item is used in a quest
-- questId: Associated quest ID
-- notes: Additional information

local ALLOWED_OPTIONS = {
    source = true,
    questItem = true,
    questId = true,
    notes = true,
}

-- Creates a standardized reward entry.
function addon.CreateReward(name, category, price, itemId, options)
    local entry = {
        name = name,
        category = category,
        price = price,
        itemId = itemId,
        texture = addon.PLACEHOLDER_ICON,
    }

    if options then
        for key, value in pairs(options) do
            if ALLOWED_OPTIONS[key] then
                entry[key] = value
            end
        end
    end

    return entry
end
