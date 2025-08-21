# ⚙️ KDE Plasma
KDE Plasma is a fully-fledged desktop environment developed by KDE, offering not only a core desktop but a wide variety of applications such as file explorers, wallet managers, a settings application, and much more.

This module configures little beyond installing Plasma, as Nix doesn't offer many methods to configure it directly.


## Options
Options can be accessed through the `zen.session.plasma` config path.
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `enable` | `boolean` | `false`   | NixOS Host | Whether to install the KDE Plasma desktop environment |

