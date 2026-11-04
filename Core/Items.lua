local addon = ReputationRenown

-- Stores items whose data has already been requested.
local pendingItems = {}

-- Resolve item information from the WoW client.
function addon:GetRewardItemInfo(reward)
    local result = {
        name = reward.name,
        icon = reward.texture or addon.PLACEHOLDER_ICON,
        quality = nil,
    }

    if not reward.itemId then
        return result
    end

    if not C_Item then
        return result
    end

    -- Icons can be available even when item details are not cached.
    if C_Item.GetItemIconByID then
        local icon = C_Item.GetItemIconByID(reward.itemId)

        if icon then
            result.icon = icon
        end
    end

    -- Retrieve cached item information.
    if C_Item.GetItemInfo then
        local name, _, quality = C_Item.GetItemInfo(reward.itemId)

        if name then
            result.name = name
            result.quality = quality

            return result
        end
    end

    -- Request missing item information asynchronously.
    if C_Item.RequestLoadItemDataByID
        and not pendingItems[reward.itemId] then

        pendingItems[reward.itemId] = true
        C_Item.RequestLoadItemDataByID(reward.itemId)
    end

    return result
end

-- Listen for asynchronous item data loading.
local eventFrame = CreateFrame("Frame")

eventFrame:RegisterEvent("ITEM_DATA_LOAD_RESULT")

eventFrame:SetScript("OnEvent", function(_, event, itemID, success)
    if event ~= "ITEM_DATA_LOAD_RESULT" then
        return
    end

    if not pendingItems[itemID] then
        return
    end

    pendingItems[itemID] = nil

    if not success then
        return
    end

    -- Refresh displayed cards that reference this item.
    if not addon.ui or not addon.ui.rewardCards then
        return
    end

    for _, card in ipairs(addon.ui.rewardCards) do
        if card.reward and card.reward.itemId == itemID then
            addon:RefreshRewardCard(card)
        end
    end
end)
