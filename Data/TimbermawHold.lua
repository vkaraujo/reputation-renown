local addon = ReputationRenown

local placeholderIcon = "Interface\\Icons\\INV_Misc_QuestionMark"

-- Creates a reward entry
local function reward(name, category, price, itemId)
    return {
        name = name,
        category = category,
        price = price,
        itemId = itemId,
        texture = placeholderIcon,
    }
end

addon:RegisterFaction({
    id = "timbermaw",
    factionId = 576,

    name = "Timbermaw Hold",
    description = "A reputation with the furbolgs of Felwood.",

    -- Visual configuration
    theme = {
        background = { 0.055, 0.085, 0.07, 0.98 },
        surface = { 0.105, 0.14, 0.12, 1 },
        accent = { 0.81, 0.68, 0.40, 1 },
        border = { 0.45, 0.36, 0.23, 1 },

        emblemTexture = placeholderIcon,

        tierTextures = {
            friendly = placeholderIcon,
            honored = placeholderIcon,
            revered = placeholderIcon,
            exalted = placeholderIcon,
        },

        borderStyle = "classic",
    },

    -- Real rewards from the WoW Forever beta
    rewards = {

        friendly = {
            reward(
                "Formula: Enchant 2H Weapon - Agility",
                "Enchanting",
                25000
            ),

            reward(
                "Pattern: Warbear Harness",
                "Pattern",
                16000
            ),

            reward(
                "Pattern: Warbear Woolies",
                "Pattern",
                20000
            ),

            reward(
                "Recipe: Transmute Earth to Water",
                "Alchemy",
                15000
            ),
        },

        honored = {
            reward(
                "Formula: Enchant Weapon - Agility",
                "Enchanting",
                30000
            ),

            reward(
                "Pattern: Heavy Timbermaw Belt",
                "Pattern",
                22000
            ),

            reward(
                "Pattern: Might of the Timbermaw",
                "Pattern",
                22000
            ),

            reward(
                "Pattern: Wisdom of the Timbermaw",
                "Pattern",
                22000
            ),
        },

        revered = {
            reward(
                "Formula: Enchant Shield - Law of Nature",
                "Enchanting",
                100000
            ),

            reward(
                "Pattern: Heavy Timbermaw Boots",
                "Pattern",
                40000
            ),

            reward(
                "Pattern: Mantle of the Timbermaw",
                "Pattern",
                40000
            ),

            reward(
                "Pattern: Timbermaw Brawlers",
                "Pattern",
                40000
            ),

            reward(
                "Plans: Bagh Nakh",
                "Blacksmithing",
                100000
            ),

            reward(
                "Plans: Stormcarver",
                "Blacksmithing",
                100000
            ),
        },

        exalted = {
            reward(
                "Defender of the Timbermaw",
                "Trinket",
                35965
            ),
        },
    },
})
