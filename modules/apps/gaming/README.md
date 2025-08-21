# 🎮 Gaming
This module controls a variety of gaming platforms and launchers, with many options to decide which.

## External Links
- [Steam - Official Webpage](https://store.steampowered.com/)
- [Heroic Launcher - Official Webpage](https://heroicgameslauncher.com/)
- [Modrinth Minecraft Launcher - Official Webpage](https://modrinth.com/app)
- [ATLauncher Minecraft Launcher - Official Webpage](https://atlauncher.com/downloads)
- [PrismMC Minecraft Launcher - Official Webpage](https://prismlauncher.org/)

## Options
Options can be accessed from the `zen.apps.gaming` config path.

| Name                          | Type      | Default | Scope      | Description                                           |
|-------------------------------|-----------|---------|------------|-------------------------------------------------------|
| `enable`                      | `boolean` | `false` | NixOS Host | Whether to allow installation of ANY gaming platforms |
| `steam.enable`                | `boolean` | `true`  | NixOS Host | Whether to install the Steam launcher                 |
| `heroic.enable`               | `boolean` | `false` | NixOS Host | Whether to install the Heroic Games Launcher          |
| `minecraft.modrinth.enable`   | `boolean` | `false` | NixOS Host | Whether to install the Modrinth MC Launcher           |
| `minecraft.atlauncher.enable` | `boolean` | `false` | NixOS Host | Whether to install the ATL MC Launcher                |
| `minecraft.prism.enable`      | `boolean` | `false` | NixOS Host | Whether to install the Prism MC Launcher              |

> ℹ️ Note
> Enabling `gaming.steam.enable`, assuming `gaming.enable` is also true, will configure Steam at NixOS system-level, and include some required libraries for common games, such as `gperftools` for Team Fortress 2.
