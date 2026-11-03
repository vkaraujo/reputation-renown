ReputationRenown = {}

local addon = ReputationRenown

-- Mock WoW event frame
CreateFrame = function()
    return {
        RegisterEvent = function() end,
        SetScript = function() end,
    }
end

-- Mock WoW item API
C_Item = {
    GetItemIconByID = function(itemId)
        if itemId == 21326 then
            return 123456
        end
    end,

    GetItemInfo = function(itemId)
        if itemId == 21326 then
            return "Defender of the Timbermaw", nil, 3
        end
    end,

    RequestLoadItemDataByID = function()
        return true
    end,
}

dofile("UI/RewardCard.lua")

local reward = {
    itemId = 21326,
    name = "Defender of the Timbermaw",
    texture = "fallback",
}

local result = addon:GetRewardItemInfo(reward)

assert(result.name == "Defender of the Timbermaw")
assert(result.icon == 123456)
assert(result.quality == 3)

-- Test missing item ID
local unknown = addon:GetRewardItemInfo({
    name = "Unknown Reward",
    texture = "fallback",
})

assert(unknown.name == "Unknown Reward")
assert(unknown.icon == "fallback")

print("All reward card tests passed!")
