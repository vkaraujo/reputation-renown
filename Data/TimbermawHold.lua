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
        reward("Formula: Enchant 2H Weapon - Agility", "Enchanting", 25000, 22392),
        reward("Pattern: Warbear Harness", "Leatherworking", 16000, 20253),
        reward("Pattern: Warbear Woolies", "Leatherworking", 20000, 20254),
        reward("Recipe: Transmute Earth to Water", "Alchemy", 15000, 13484),
    },

    honored = {
        reward("Formula: Enchant Weapon - Agility", "Enchanting", 30000, 19445),
        reward("Pattern: Heavy Timbermaw Belt", "Leatherworking", 22000, 19202),
        reward("Pattern: Might of the Timbermaw", "Leatherworking", 22000, 19326),
        reward("Pattern: Wisdom of the Timbermaw", "Tailoring", 22000, 19215),
    },

    revered = {
        reward("Formula: Enchant Shield - Law of Nature", "Enchanting", 100000, 228982),
        reward("Pattern: Heavy Timbermaw Boots", "Leatherworking", 40000, 19204),
        reward("Pattern: Mantle of the Timbermaw", "Tailoring", 40000, 19218),
        reward("Pattern: Timbermaw Brawlers", "Leatherworking", 40000, 19327),
        reward("Plans: Bagh Nakh", "Blacksmithing", 100000, 251470),
        reward("Plans: Stormcarver", "Blacksmithing", 100000, 251469),
    },

    exalted = {
        reward("Defender of the Timbermaw", "Trinket", 35965, 21326),
    },
  },
})
