local addon = ReputationRenown

local placeholderIcon = addon.PLACEHOLDER_ICON
local reward = addon.CreateReward

addon:RegisterFaction({
    id = "cenarion",
    factionId = 609,

    name = "Cenarion Circle",
    description = "The druids of the Cenarion Circle are guardians of nature, dedicated to preserving balance and protecting Azeroth from ancient threats.",

    -- Visual configuration
    theme = {
        background = { 0.055, 0.085, 0.065, 0.98 },
        surface = { 0.10, 0.145, 0.105, 1 },
        accent = { 0.65, 0.80, 0.38, 1 },
        border = { 0.35, 0.48, 0.25, 1 },

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
    -- Reputation requirements and item IDs: MaxDPS game data.
    -- Vendor prices and acquisition sources: Wowhead reference data.
    -- All prices are in copper and require in-game verification.
    --
    -- Optional metadata:
    -- source: "vendor", "quest", "drop" or "unknown"
    -- questItem: true when the item is used in a quest
    -- notes: additional acquisition information
    --
    -- Some rewards may be unavailable during earlier content phases.

    rewards = {
        friendly = {
            reward(
                "Scroll: Create Signet of Beckoning",
                "Miscellaneous",
                nil,
                229897,
                {
                    source = "unknown",
                    notes = "Used to create a Signet of Beckoning: Fire.",
                }
            ),

            -- Tailoring: Venomspew and Swarmtender
            reward(
                "Pattern: Venomspew Gloves",
                "Tailoring",
                75000,
                275580,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Swarmtender's Gloves",
                "Tailoring",
                75000,
                275583,
                { source = "vendor" }
            ),

            -- Leatherworking: new Forever recipes
            reward(
                "Pattern: Bileblister Claws",
                "Leatherworking",
                nil,
                275586,
                { source = "unknown" }
            ),

            reward(
                "Pattern: Hivethrasher's Claws",
                "Leatherworking",
                nil,
                275589,
                { source = "unknown" }
            ),

            reward(
                "Pattern: Scalegut Clenchers",
                "Leatherworking",
                nil,
                275592,
                { source = "unknown" }
            ),

            reward(
                "Pattern: Broodwatcher's Clenchers",
                "Leatherworking",
                nil,
                275595,
                { source = "unknown" }
            ),

            -- Blacksmithing: Goregasher and Clutchlord
            reward(
                "Plans: Goregasher Grips",
                "Blacksmithing",
                75000,
                275598,
                { source = "vendor" }
            ),

            reward(
                "Plans: Clutchlord's Grips",
                "Blacksmithing",
                75000,
                275601,
                { source = "vendor" }
            ),

            -- Classic recipes
            reward(
                "Pattern: Cenarion Herb Bag",
                "Tailoring",
                22500,
                22310,
                { source = "vendor" }
            ),

            -- New enchanting formulas
            reward(
                "Formula: Scroll: Wrath of the Swarm",
                "Enchanting",
                105263,
                234271,
                {
                    source = "vendor",
                    notes = "Also listed as a rare drop in Ahn'Qiraj Temple. Item details are provisional.",
                }
            ),

            reward(
                "Formula: Enchanted Repellent",
                "Enchanting",
                52631,
                234272,
                {
                    source = "vendor",
                    notes = "Item details are provisional.",
                }
            ),

            reward(
                "Formula: Enchant Cloak - Greater Fire Resistance",
                "Enchanting",
                100000,
                20732,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Sylvan Shoulders",
                "Tailoring",
                52941,
                22772,
                { source = "vendor" }
            ),
        },

        honored = {
            -- Tailoring: Venomspew
            reward(
                "Pattern: Venomspew Cord",
                "Tailoring",
                75000,
                275581,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Venomspew Footpads",
                "Tailoring",
                75000,
                275582,
                { source = "vendor" }
            ),

            -- Tailoring: Swarmtender
            reward(
                "Pattern: Swarmtender's Cord",
                "Tailoring",
                75000,
                275584,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Swarmtender's Footpads",
                "Tailoring",
                75000,
                275585,
                { source = "vendor" }
            ),

            -- Leatherworking: Bileblister
            reward(
                "Pattern: Bileblister Girdle",
                "Leatherworking",
                nil,
                275587,
                { source = "unknown" }
            ),

            reward(
                "Pattern: Bileblister Boots",
                "Leatherworking",
                nil,
                275588,
                { source = "unknown" }
            ),

            -- Leatherworking: Hivethrasher
            reward(
                "Pattern: Hivethrasher's Girdle",
                "Leatherworking",
                nil,
                275590,
                { source = "unknown" }
            ),

            reward(
                "Pattern: Hivethrasher's Boots",
                "Leatherworking",
                nil,
                275591,
                { source = "unknown" }
            ),

            -- Leatherworking: Scalegut
            reward(
                "Pattern: Scalegut Belt",
                "Leatherworking",
                nil,
                275593,
                { source = "unknown" }
            ),

            reward(
                "Pattern: Scalegut Treaders",
                "Leatherworking",
                nil,
                275594,
                { source = "unknown" }
            ),

            -- Leatherworking: Broodwatcher
            reward(
                "Pattern: Broodwatcher's Belt",
                "Leatherworking",
                nil,
                275596,
                { source = "unknown" }
            ),

            reward(
                "Pattern: Broodwatcher's Treaders",
                "Leatherworking",
                nil,
                275597,
                { source = "unknown" }
            ),

            -- Blacksmithing: Goregasher
            reward(
                "Plans: Goregasher Support",
                "Blacksmithing",
                75000,
                275599,
                { source = "vendor" }
            ),

            reward(
                "Plans: Goregasher Stompers",
                "Blacksmithing",
                75000,
                275600,
                { source = "vendor" }
            ),

            -- Blacksmithing: Clutchlord
            reward(
                "Plans: Clutchlord's Support",
                "Blacksmithing",
                75000,
                275602,
                { source = "vendor" }
            ),

            reward(
                "Plans: Clutchlord's Stompers",
                "Blacksmithing",
                75000,
                275603,
                { source = "vendor" }
            ),

            -- Classic recipes
            reward(
                "Formula: Enchant Cloak - Greater Nature Resistance",
                "Enchanting",
                100000,
                20733,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Sylvan Crown",
                "Tailoring",
                52941,
                22773,
                { source = "vendor" }
            ),
        },

        revered = {
            reward(
                "Pattern: Satchel of Cenarius",
                "Tailoring",
                56250,
                22312,
                { source = "vendor" }
            ),

            reward(
                "Plans: Jagged Obsidian Shield",
                "Blacksmithing",
                44444,
                22219,
                {
                    source = "vendor",
                    notes = "Sold by Lieutenant General Andorov in Ruins of Ahn'Qiraj. Availability depends on the AQ content phase.",
                }
            ),

            reward(
                "Pattern: Gaea's Embrace",
                "Tailoring",
                95294,
                22683,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Sylvan Vest",
                "Tailoring",
                52941,
                22774,
                { source = "vendor" }
            ),
        },

        exalted = {
            reward(
                "Plans: Obsidian Mail Tunic",
                "Blacksmithing",
                71111,
                22221,
                {
                    source = "vendor",
                    notes = "Sold by Lieutenant General Andorov in Ruins of Ahn'Qiraj. Availability depends on the AQ content phase.",
                }
            ),
        },
    },
})
