# Session
This module handles graphical user sessions such as Hyprland, Niri, and KDE Plasma.


## Options
Options can be accessed through the `zen.session` config path.
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `default` | `string` | `""`   | NixOS Host | The default graphical session to load into when booting |
| `monitors` | `listOf monitorType` | `[]`   | NixOS Host | Monitor definitions for layout and workspaces |


### Monitor Configuration
This module includes a custom option type, called `monitorType`, which allows you to define many aspects of a monitor for window manager specific configuration. These are defined as an attribute set with the following fields.

It is highly recommended to configure this if you intend on using a Window Manager such as Hyprland or Niri.
| Name | Type | Default | Description |
|------|------|---------|-------------|
| `name` | `string` | `""` | The monitor's name (`"DP-1"`, `"HDMI-A-1"`, etc.), can be found with `xrandr` |
| `resolution` | `string` | `"highres"` | The resolution of the monitor, as `"${width}x${height}"` |
| `offset` | `string` | `"auto"` | The offset of the monitor, for multi-monitor configurations, defined similarly to `resolution` |
| `refreshRate` | `number` or `null` | `null` | The monitor's refresh rate |
| `workspaces` | `listOf number` | `[1]` | The workspaces to associate with this monitor exclusively, used for Hyprland |
