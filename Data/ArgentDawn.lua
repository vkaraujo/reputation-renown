local addon = ReputationRenown

local placeholderIcon = addon.PLACEHOLDER_ICON
local reward = addon.CreateReward

addon:RegisterFaction({
    id = "argent",
    factionId = 529,

    name = "Argent Dawn",
    description = "A faction dedicated to fighting the Scourge and protecting Azeroth from the undead threat.",

    -- Visual configuration
    theme = {
        background = { 0.065, 0.075, 0.085, 0.98 },
        surface = { 0.115, 0.125, 0.14, 1 },
        accent = { 0.90, 0.77, 0.45, 1 },
        border = { 0.48, 0.40, 0.25, 1 },

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
    --
    -- Reputation requirements and item IDs verified against game data.
    -- Vendor prices are reference values and require in-game verification.
    -- Some items may be unavailable during earlier content phases.
    --
    -- Optional reward metadata:
    -- source: "vendor", "quest" or "unknown"
    -- questItem: true when the item is classified as a quest item
    -- notes: additional information about acquisition or availability
    --
    -- Items with identical names but different IDs are intentionally
    -- preserved as separate rewards.

    rewards = {
        friendly = {
            reward(
                "Enriched Manna Biscuit",
                "Consumable",
                6315,
                13724,
                { source = "vendor" }
            ),
        },

        honored = {
            reward(
                "Sam's Tome",
                "Book",
                nil,
                1164,
                {
                    source = "unknown",
                    notes = "Acquisition method not confirmed.",
                }
            ),

            reward(
                "Hallowed Brazier",
                "Quest Item",
                1333333,
                22014,
                {
                    source = "vendor",
                    questItem = true,
                    notes = "Quest item sold by Argent Dawn quartermasters.",
                }
            ),

            reward(
                "Recipe: Transmute Air to Fire",
                "Alchemy",
                15789,
                13482,
                { source = "vendor" }
            ),

            reward(
                "Plans: Girdle of the Dawn",
                "Blacksmithing",
                23157,
                19203,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Argent Boots",
                "Tailoring",
                23157,
                19216,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Dawn Treaders",
                "Leatherworking",
                23157,
                19328,
                { source = "vendor" }
            ),

            reward(
                "Formula: Powerful Anti-Venom",
                "First Aid",
                105263,
                19442,
                { source = "vendor" }
            ),

            reward(
                "Formula: Enchant Bracer - Mana Regeneration",
                "Enchanting",
                31578,
                19446,
                { source = "vendor" }
            ),

            -- Alternate item ID present in WoW Forever game data
            reward(
                "Pattern: Argent Boots",
                "Tailoring",
                nil,
                227896,
                {
                    source = "unknown",
                    notes = "Alternate recipe ID. Requires in-game verification.",
                }
            ),

            reward(
                "Drinkable Stratholme Holy Water",
                "Consumable",
                nil,
                227813,
                {
                    source = "vendor",
                    notes = "Provisional item data. Price requires verification.",
                }
            ),
        },

        revered = {
            reward(
                "Blessed Sunfruit",
                "Consumable",
                6315,
                13810,
                { source = "vendor" }
            ),

            reward(
                "Blessed Sunfruit Juice",
                "Consumable",
                6315,
                13813,
                { source = "vendor" }
            ),

            reward(
                "Plans: Dawnbringer Shoulders",
                "Blacksmithing",
                23157,
                12698,
                { source = "vendor" }
            ),

            reward(
                "Plans: Gloves of the Dawn",
                "Blacksmithing",
                40000,
                19205,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Argent Shoulders",
                "Tailoring",
                42105,
                19217,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Golden Mantle of the Dawn",
                "Leatherworking",
                40000,
                19329,
                { source = "vendor" }
            ),

            reward(
                "Formula: Enchant Bracer - Healing",
                "Enchanting",
                63157,
                19447,
                { source = "vendor" }
            ),

            -- Alternate item ID present in WoW Forever game data
            reward(
                "Pattern: Golden Mantle of the Dawn",
                "Leatherworking",
                nil,
                227895,
                {
                    source = "unknown",
                    notes = "Alternate recipe ID. Requires in-game verification.",
                }
            ),

            -- Alternate item ID present in WoW Forever game data
            reward(
                "Pattern: Argent Shoulders",
                "Tailoring",
                nil,
                227897,
                {
                    source = "unknown",
                    notes = "Alternate recipe ID. Requires in-game verification.",
                }
            ),

            reward(
                "Plans: Icebane Gauntlets",
                "Blacksmithing",
                nil,
                22704,
                {
                    source = "unknown",
                    notes = "Availability requires in-game verification.",
                }
            ),
        },

        exalted = {
            reward(
                "Plans: Icebane Breastplate",
                "Blacksmithing",
                nil,
                22703,
                {
                    source = "unknown",
                    notes = "Availability requires in-game verification.",
                }
            ),
        },
    },
})
