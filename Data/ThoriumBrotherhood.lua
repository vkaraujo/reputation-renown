local addon = ReputationRenown

local placeholderIcon = addon.PLACEHOLDER_ICON
local reward = addon.CreateReward

addon:RegisterFaction({
  id = "thorium",
  factionId = 59,

  name = "Thorium Brotherhood",
  description = "Master craftsmen of the Blackrock Mountains, renowned for their skill in forging powerful weapons and armor.",

  -- Visual configuration
  theme = {
    background = { 0.085, 0.065, 0.055, 0.98 },
    surface = { 0.15, 0.105, 0.075, 1 },
    accent = { 0.95, 0.52, 0.20, 1 },
    border = { 0.50, 0.28, 0.15, 1 },

    emblemTexture = placeholderIcon,

    tierTextures = {
      friendly = placeholderIcon,
      honored = placeholderIcon,
      revered = placeholderIcon,
      exalted = placeholderIcon,
    },

    borderStyle = "classic",
  },

  -- Source: MaxDPS WoW Forever (build 1.60.1.70532)
  -- Reputation requirements and item IDs verified against game data.
  -- Prices are reference vendor prices, subject to in-game verification.
  -- Items may be unavailable during earlier content phases.
  rewards = {
    friendly = {
      reward("Formula: Enchant Weapon - Strength", "Enchanting", 31764, 19444),
      reward("Pattern: Corehound Boots", "Leatherworking", 158823, 17022),
      reward("Plans: Dark Iron Bracers", "Blacksmithing", 74117, 17051),
      reward("Pattern: Molten Helm", "Leatherworking", 169411, 17023),
      reward("Recipe: Transmute Elemental Fire", "Alchemy", 127058, 20761),
      reward("Pattern: Flarecore Gloves", "Tailoring", 84705, 17018),
    },

    honored = {
      reward("Plans: Fiery Chain Girdle", "Blacksmithing", 95294, 17049),
      reward("Pattern: Black Dragonscale Boots", "Leatherworking", nil, 17025),
      reward("Pattern: Flarecore Mantle", "Tailoring", 190588, 17017),
      reward("Plans: Dark Iron Reaver", "Blacksmithing", 232941, 17059),
      reward("Plans: Dark Iron Destroyer", "Blacksmithing", 232941, 17060),
      reward("Plans: Dark Iron Helm", "Blacksmithing", 63529, 19206),
      reward("Pattern: Flarecore Robe", "Tailoring", 63529, 19219),
      reward("Pattern: Lava Belt", "Leatherworking", 63529, 19330),
      reward("Formula: Enchant Weapon - Mighty Spirit", "Enchanting", 84705, 19448),
      reward("Formula: Enchant Cloak - Greater Fire Resistance", "Enchanting", 112500, 229008),
      reward("Formula: Enchant Cloak - Greater Nature Resistance", "Enchanting", 112500, 229009),
    },

    revered = {
      reward("Plans: Dark Iron Leggings", "Blacksmithing", 190588, 17052),
      reward("Plans: Fiery Chain Shoulders", "Blacksmithing", 211764, 17053),
      reward("Plans: Black Amnesty", "Blacksmithing", 74117, 19208),
      reward("Plans: Blackfury", "Blacksmithing", 74117, 19209),
      reward("Plans: Dark Iron Gauntlets", "Blacksmithing", 84705, 19207),
      reward("Pattern: Flarecore Leggings", "Tailoring", 95294, 19220),
      reward("Pattern: Chromatic Gauntlets", "Leatherworking", 95294, 19331),
      reward("Pattern: Corehound Belt", "Leatherworking", 95294, 19332),
      reward("Pattern: Molten Belt", "Leatherworking", 95294, 19333),
      reward("Formula: Enchant Weapon - Mighty Intellect", "Enchanting", 105882, 19449),
    },

    exalted = {
      reward("Plans: Ebon Hand", "Blacksmithing", 108000, 19210),
      reward("Plans: Blackguard", "Blacksmithing", 108000, 19211),
      reward("Plans: Nightfall", "Blacksmithing", 135000, 19212),
      reward("Plans: Dark Iron Boots", "Blacksmithing", 72000, 20040),
    },
  },
})
