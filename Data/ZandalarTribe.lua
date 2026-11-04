local addon = ReputationRenown

local placeholderIcon = addon.PLACEHOLDER_ICON
local reward = addon.CreateReward

addon:RegisterFaction({
    id = "zandalar",
    factionId = 270,

    name = "Zandalar Tribe",
    description = "The Zandalar trolls have come to Yojamba Isle to recruit champions against Hakkar the Soulflayer and his followers in Zul'Gurub.",

    -- Visual configuration
    theme = {
        background = { 0.045, 0.075, 0.065, 0.98 },
        surface = { 0.085, 0.13, 0.105, 1 },
        accent = { 0.85, 0.70, 0.32, 1 },
        border = { 0.38, 0.42, 0.24, 1 },

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
    -- All listed recipes have Rin'wosho the Trader as a known vendor.
    -- Location: Yojamba Isle, Stranglethorn Vale (15.0, 16.0).
    --
    -- Some rewards may be unavailable during earlier content phases.

    rewards = {
        friendly = {
            reward(
                "Recipe: Greater Dreamless Sleep",
                "Alchemy",
                56250,
                20012,
                { source = "vendor" }
            ),

            reward(
                "Formula: Brilliant Mana Oil",
                "Enchanting",
                45000,
                20757,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Bloodvine Boots",
                "Tailoring",
                56250,
                19766,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Primal Batskin Bracers",
                "Leatherworking",
                56250,
                19771,
                { source = "vendor" }
            ),

            reward(
                "Plans: Bloodsoul Gauntlets",
                "Blacksmithing",
                56250,
                19778,
                { source = "vendor" }
            ),

            reward(
                "Plans: Darksoul Shoulders",
                "Blacksmithing",
                52941,
                19781,
                { source = "vendor" }
            ),

            reward(
                "Schematic: Bloodvine Lens",
                "Engineering",
                56250,
                20001,
                { source = "vendor" }
            ),
        },

        honored = {
            reward(
                "Recipe: Major Troll's Blood Elixir",
                "Alchemy",
                52941,
                20014,
                { source = "vendor" }
            ),

            reward(
                "Formula: Brilliant Wizard Oil",
                "Enchanting",
                45000,
                20756,
                { source = "vendor" }
            ),

            -- New WoW Forever enchanting formula
            reward(
                "Formula: Magnificent Trollshine",
                "Enchanting",
                42352,
                232610,
                {
                    source = "vendor",
                    notes = "WoW Forever recipe. Teaches Magnificent Trollshine.",
                }
            ),

            reward(
                "Pattern: Bloodvine Leggings",
                "Tailoring",
                52941,
                19765,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Primal Batskin Gloves",
                "Leatherworking",
                52941,
                19770,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Blood Tiger Shoulders",
                "Leatherworking",
                56250,
                19773,
                { source = "vendor" }
            ),

            reward(
                "Plans: Bloodsoul Shoulders",
                "Blacksmithing",
                52941,
                19777,
                { source = "vendor" }
            ),

            reward(
                "Plans: Darksoul Leggings",
                "Blacksmithing",
                52941,
                19780,
                { source = "vendor" }
            ),

            reward(
                "Schematic: Bloodvine Goggles",
                "Engineering",
                135000,
                20000,
                { source = "vendor" }
            ),
        },

        revered = {
            reward(
                "Recipe: Mageblood Elixir",
                "Alchemy",
                56250,
                20011,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Bloodvine Vest",
                "Tailoring",
                52941,
                19764,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Primal Batskin Jerkin",
                "Leatherworking",
                56250,
                19769,
                { source = "vendor" }
            ),

            reward(
                "Pattern: Blood Tiger Breastplate",
                "Leatherworking",
                56250,
                19772,
                { source = "vendor" }
            ),

            reward(
                "Plans: Bloodsoul Breastplate",
                "Blacksmithing",
                56250,
                19776,
                { source = "vendor" }
            ),

            reward(
                "Plans: Darksoul Breastplate",
                "Blacksmithing",
                56250,
                19779,
                { source = "vendor" }
            ),
        },

        exalted = {
            reward(
                "Recipe: Living Action Potion",
                "Alchemy",
                56250,
                20013,
                { source = "vendor" }
            ),
        },
    },
})
