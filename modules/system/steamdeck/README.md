# 🎮 Steam Deck
This module handles hardware compatibility and software for the Steam Deck mobile console.


## Features
- 🛠️ Uses [Jovian-NixOS]() for Steam Deck hardware support
- 🤫 Quiet, text-less kernel booting
- 🎮 Boots into Steam Big Picture Mode by default
- 🖥️ Respects your configured `zen.session.default` for "Desktop Mode"
- 🪟 Preconfigures Window Manager monitors for Steam Deck screen
- 📦 Zram for increased RAM efficicency
- 📡 Network Manager & Bluetooth Enabled
- 🔌 Decky Plugin Loader Installed


## Options
Options can be found under `zen.system.steamdeck`
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `enable` | `boolean` | `false`   | NixOS Host | Whether this system should use Steam Deck configuration |
| `username` | `string` | `"steamos"`   | NixOS Host | The user to start Steam with on launch |


## Credit
- [SteamNix](https://github.com/SteamNix/SteamNix) for some referenced configuration
- [This GH Comment](https://github.com/Jovian-Experiments/Jovian-NixOS/issues/460#issuecomment-3439375088) for making Decky declaratively reliable
