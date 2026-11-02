local addon = ReputationRenown
addon.factions = addon.factions or {}

local icon = "Interface\\Icons\\INV_Misc_QuestionMark"

addon.factions.timbermaw = {
    id = "timbermaw",
    name = "Timbermaw Hold",
    description = "A reputation with the furbolgs of Felwood.",
    theme = {
        background = { 0.055, 0.085, 0.07, 0.98 },
        surface = { 0.105, 0.14, 0.12, 1 },
        accent = { 0.81, 0.68, 0.40, 1 },
        border = { 0.45, 0.36, 0.23, 1 },
        emblemTexture = icon, -- Replace with a real asset later.
        tierTextures = { friendly = icon, honored = icon, revered = icon, exalted = icon },
        borderStyle = "classic", -- Reserved for a future border renderer.
    },
    rewards = {
        friendly = {
            { name = "Sample Friendly reward 1", category = "Demonstration", texture = icon },
            { name = "Sample Friendly reward 2", category = "Demonstration", texture = icon },
        },
        honored = {
            { name = "Sample Honored reward 1", category = "Demonstration", texture = icon },
            { name = "Sample Honored reward 2", category = "Demonstration", texture = icon },
            { name = "Sample Honored reward 3", category = "Demonstration", texture = icon },
        },
        revered = {},
        exalted = {
            { name = "Sample Exalted reward", category = "Demonstration", texture = icon },
        },
    },
}

-- Make Revered long enough to exercise scrolling while the client is unavailable.
for i = 1, 12 do
    table.insert(addon.factions.timbermaw.rewards.revered, {
        name = "Sample Revered reward " .. i,
        category = "Scrolling demonstration",
        texture = icon,
    })
end
