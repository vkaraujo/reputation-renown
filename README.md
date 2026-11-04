# Reputation Renown

A modern, Renown-inspired interface for World of Warcraft: Forever reputations.

Reputation Renown enhances the original reputation interface with a visual
progression system, making it easier to explore faction rewards and track
your reputation progress.

## Features

- Modern, Renown-inspired reputation interface.
- Displays reputation levels and their associated rewards.
- Browse rewards from supported factions.
- View item information using in-game tooltips.
- Integrates with the existing World of Warcraft reputation system.
- Preserves the original reputation list.

## Supported Factions

The following factions are currently included in the reward catalog:

- Argent Dawn
- Cenarion Circle
- Thorium Brotherhood
- Timbermaw Hold
- Zandalar Tribe

Additional factions may be added in future updates.

## Compatibility

Designed for **World of Warcraft: Forever**.

Compatibility with other versions of World of Warcraft is not guaranteed.

## Installation

### Manual Installation

1. Download the latest ZIP from [GitHub Releases](../../releases).
2. Extract the archive.
3. Copy the `ReputationRenown` folder into your WoW Forever
   `Interface/AddOns` directory.
4. Restart World of Warcraft.
5. Enable Reputation Renown in the AddOns menu, if necessary.

The resulting directory structure should look like this:

```text
Interface/
└── AddOns/
    └── ReputationRenown/
        ├── ReputationRenown.toc
        ├── Assets/
        ├── Core/
        ├── Data/
        └── UI/
```

### CurseForge

CurseForge distribution is planned for a future release.

## Usage

Open the in-game reputation interface and select a supported faction
to explore its reputation progression and available rewards.

## Bug Reports and Feature Requests

Found a bug or have a suggestion?

Please use [GitHub Issues](../../issues) to report problems or suggest
new features.

When reporting a bug, include your addon version, game version,
and steps to reproduce the problem.

## Development

Reputation Renown is developed in Lua using the World of Warcraft
addon API.

The project separates interface components, reputation handling,
and faction reward catalogs into dedicated modules.

Catalog validation scripts are available in the `scripts/` directory.

## Contributing

Bug reports, suggestions, and pull requests are welcome.

## Support Development

Reputation Renown is free to use.

If you enjoy the addon and would like to support its development,
donation options may be added in the future.

## License

This project is licensed under the MIT License.
See [LICENSE](LICENSE) for details.

## Disclaimer

Reputation Renown is an independent, community-developed addon.

It is not affiliated with, endorsed by, or sponsored by Blizzard
Entertainment.

World of Warcraft and related names are trademarks of their
respective owners.
