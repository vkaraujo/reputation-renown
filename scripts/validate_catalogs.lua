-- Standalone catalog validator for ReputationRenown.
-- Run from the project root:
-- lua scripts/validate_catalogs.lua
--
-- No World of Warcraft API required.

local ROOT = (arg and arg[1]) or "."

local FILES = {
    "Data/TimbermawHold.lua",
    "Data/ThoriumBrotherhood.lua",
    "Data/ArgentDawn.lua",
    "Data/CenarionCircle.lua",
    "Data/ZandalarTribe.lua",
}

local TIERS = {
    friendly = true,
    honored = true,
    revered = true,
    exalted = true,
}

local SOURCES = {
    vendor = true,
    quest = true,
    drop = true,
    unknown = true,
}

local errors = 0
local warnings = 0
local totalRewards = 0

local factions = {}
local factionIds = {}
local factionKeys = {}

local function report(level, location, message)
    print(string.format(
        "[%s] %s: %s",
        level,
        location,
        message
    ))

    if level == "ERROR" then
        errors = errors + 1
    elseif level == "WARNING" then
        warnings = warnings + 1
    end
end

local function errorAt(location, message)
    report("ERROR", location, message)
end

local function warnAt(location, message)
    report("WARNING", location, message)
end

local function isNonEmptyString(value)
    return type(value) == "string"
        and value:match("%S") ~= nil
end

local function isPositiveInteger(value)
    return type(value) == "number"
        and value > 0
        and value % 1 == 0
end

local function validateReward(reward, location)
    if type(reward) ~= "table" then
        errorAt(location, "Reward must be a table.")
        return
    end

    if not isNonEmptyString(reward.name) then
        errorAt(location, "Missing or invalid name.")
    end

    if not isNonEmptyString(reward.category) then
        errorAt(location, "Missing or invalid category.")
    end

    if not isPositiveInteger(reward.itemId) then
        errorAt(location, "Missing or invalid itemId.")
    end

    if reward.price ~= nil then
        if type(reward.price) ~= "number"
            or reward.price < 0
            or reward.price % 1 ~= 0 then
            errorAt(location, "Price must be a non-negative integer.")
        end
    else
        warnAt(location, "Price not defined.")
    end

    if not isNonEmptyString(reward.texture) then
        errorAt(location, "Missing or invalid texture.")
    end

    if reward.source ~= nil then
        if not SOURCES[reward.source] then
            errorAt(location, "Invalid source: " .. tostring(reward.source))
        elseif reward.source == "unknown" then
            warnAt(location, "Acquisition source is unknown.")
        elseif reward.source == "quest" and reward.questId == nil then
            warnAt(location, "Quest reward without questId.")
        end
    end

    if reward.questId ~= nil
        and not isPositiveInteger(reward.questId) then
        errorAt(location, "Invalid questId.")
    end

    if reward.questItem ~= nil
        and type(reward.questItem) ~= "boolean" then
        errorAt(location, "questItem must be a boolean.")
    end

    if reward.notes ~= nil
        and not isNonEmptyString(reward.notes) then
        errorAt(location, "Invalid notes.")
    end
end

local function validateFaction(faction)
    if type(faction) ~= "table" then
        errorAt("Faction", "Faction must be a table.")
        return
    end

    local name = faction.name or "Unknown faction"

    if not isNonEmptyString(faction.id) then
        errorAt(name, "Missing or invalid id.")
    elseif factionKeys[faction.id] then
        errorAt(name, "Duplicate faction id: " .. faction.id)
    else
        factionKeys[faction.id] = true
    end

    if not isPositiveInteger(faction.factionId) then
        errorAt(name, "Missing or invalid factionId.")
    elseif factionIds[faction.factionId] then
        errorAt(name, "Duplicate factionId: " .. faction.factionId)
    else
        factionIds[faction.factionId] = true
    end

    if not isNonEmptyString(faction.name) then
        errorAt(name, "Missing or invalid faction name.")
    end

    if type(faction.rewards) ~= "table" then
        errorAt(name, "Missing rewards table.")
        return
    end

    local itemIds = {}
    local itemNames = {}
    local factionRewards = 0

    for tier in pairs(faction.rewards) do
        if not TIERS[tier] then
            errorAt(name, "Invalid reputation tier: " .. tostring(tier))
        end
    end

    for _, tier in ipairs({
        "friendly",
        "honored",
        "revered",
        "exalted",
    }) do
        local rewards = faction.rewards[tier]

        if rewards ~= nil then
            if type(rewards) ~= "table" then
                errorAt(name, tier .. " rewards must be a table.")
            else
                for index, reward in ipairs(rewards) do
                    local location = string.format(
                        "%s / %s / #%d",
                        name,
                        tier,
                        index
                    )

                    validateReward(reward, location)

                    if type(reward) == "table" then
                        if isPositiveInteger(reward.itemId) then
                            if itemIds[reward.itemId] then
                                errorAt(
                                    location,
                                    "Duplicate itemId: " .. reward.itemId
                                )
                            else
                                itemIds[reward.itemId] = true
                            end
                        end

                        if isNonEmptyString(reward.name) then
                            local previousId = itemNames[reward.name]

                            if previousId
                                and previousId ~= reward.itemId then
                                warnAt(
                                    location,
                                    "Duplicate name with different itemId: "
                                        .. reward.name
                                )
                            else
                                itemNames[reward.name] = reward.itemId
                            end
                        end
                    end

                    factionRewards = factionRewards + 1
                end
            end
        end
    end

    totalRewards = totalRewards + factionRewards

    print(string.format(
        "[OK] %s: %d rewards checked.",
        name,
        factionRewards
    ))
end

-- Minimal addon namespace used by the actual catalog files.
ReputationRenown = {}

function ReputationRenown:RegisterFaction(faction)
    table.insert(factions, faction)
end

local function loadFile(relativePath)
    local path = ROOT .. "/" .. relativePath

    local success, message = pcall(dofile, path)

    if not success then
        errorAt(relativePath, "Unable to load: " .. tostring(message))
        return false
    end

    return true
end

print("========================================")
print(" ReputationRenown - Catalog Validator")
print("========================================")
print()

-- Load the real reward factory.
if not loadFile("Data/Rewards.lua") then
    print()
    print("Validation aborted: reward factory unavailable.")
    os.exit(1)
end

-- Load the real faction catalogs.
for _, path in ipairs(FILES) do
    local before = #factions

    if loadFile(path) and #factions == before then
        errorAt(path, "File did not register a faction.")
    end
end

print()
print("Validating registered factions...")
print()

for _, faction in ipairs(factions) do
    validateFaction(faction)
end

print()
print("========================================")
print(" Validation summary")
print("========================================")

print(string.format("Factions: %d", #factions))
print(string.format("Rewards:  %d", totalRewards))
print(string.format("Errors:   %d", errors))
print(string.format("Warnings: %d", warnings))

if errors > 0 then
    print()
    print("FAILED: Catalog validation found errors.")
    os.exit(1)
end

print()
print("PASSED: No structural errors found.")
os.exit(0)
