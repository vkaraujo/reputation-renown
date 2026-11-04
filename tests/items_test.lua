ReputationRenown = {}

local addon = ReputationRenown

local requestedItems = {}
local eventCallback

-- Mock WoW event frame
CreateFrame = function()
    return {
        RegisterEvent = function() end,

        SetScript = function(_, script, callback)
            if script == "OnEvent" then
                eventCallback = callback
            end
        end,
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

    RequestLoadItemDataByID = function(itemId)
        requestedItems[itemId] = (requestedItems[itemId] or 0) + 1
        return true
    end,
}

-- Load item information module
dofile("Core/Items.lua")

-- 1. Cached item information
local reward = {
    itemId = 21326,
    name = "Defender of the Timbermaw",
    texture = "fallback",
}

local result = addon:GetRewardItemInfo(reward)

assert(result.name == "Defender of the Timbermaw")
assert(result.icon == 123456)
assert(result.quality == 3)
assert(requestedItems[21326] == nil)

-- 2. Missing item ID
local unknown = addon:GetRewardItemInfo({
    name = "Unknown Reward",
    texture = "fallback",
})

assert(unknown.name == "Unknown Reward")
assert(unknown.icon == "fallback")
assert(unknown.quality == nil)

-- 3. Item not cached: request asynchronous loading
local uncachedReward = {
    itemId = 99999,
    name = "Uncached Reward",
    texture = "fallback",
}

local uncached = addon:GetRewardItemInfo(uncachedReward)

assert(uncached.name == "Uncached Reward")
assert(uncached.icon == "fallback")
assert(uncached.quality == nil)
assert(requestedItems[99999] == 1)

-- Repeated calls should not request the same item again
addon:GetRewardItemInfo(uncachedReward)

assert(requestedItems[99999] == 1)

-- 4. Item API unavailable
local originalCItem = C_Item
C_Item = nil

local fallback = addon:GetRewardItemInfo(reward)

assert(fallback.name == "Defender of the Timbermaw")
assert(fallback.icon == "fallback")
assert(fallback.quality == nil)

C_Item = originalCItem

-- Verify event handler was registered
assert(type(eventCallback) == "function")

print("All reward item tests passed!")
