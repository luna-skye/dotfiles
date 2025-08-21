# 💧 Hyprland
Hyprland is a tiling window manager which offers sleek animations and a minimalist design.
As a window manager, it doesn't come with a full graphical environment for notifications, task bar, application launcher, etc., and subscribes to the bring-your-own-service philosophy, so it's encouraged to enable other services such as `dunst`, `tofi`, and `swww`.


## External Links
- [Official Webpage](https://hyprland.org/)


## Options
Options can be accessed through the `zen.session.hyprland` config path.
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `enable` | `boolean` | `false`   | NixOS Host | Whether to install the Hyprland window manager |
| `monitors` | `listOf monitorType` | `[]`   | NixOS Host | Monitor definitions for layout and workspaces |
| `defaultExecOne` | `boolean` | `true`   | NixOS Host | Whether to apply default execOnce commands on boot |
| `defaultLayerRules` | `boolean` | `true`   | NixOS Host | Whether to apply default layerRules |
| `defaultWindowRules` | `boolean` | `true`   | NixOS Host | Whether to apply default windowRules |
| `execOnce` | `listOf string` | `[]`   | NixOS Host | Additional execOnce commands to include |
| `layerRules` | `listOf string` | `[]`   | NixOS Host | Additional layerRules to include |
| `windowRules` | `listOf string` | `[]`   | NixOS Host | Additional windowRules to include |


### Monitor Configuration
This module includes a custom option type, called `monitorType`, which allows you to define many aspects of a monitor for Hyprland specific configuration. These are defined as an attribute set with the following fields.
| Name | Type | Default | Description |
|------|------|---------|-------------|
| `name` | `string` | `""` | The monitor's name (`"DP-1"`, `"HDMI-A-1"`, etc.), can be found with `hyprctl monitors` |
| `resolution` | `string` | `"highres"` | The resolution of the monitor, as `"${width}x${height}"` |
| `offset` | `string` | `"auto"` | The offset of the monitor, for multi-monitor configurations, defined similarly to `resolution` |
| `refreshRate` | `number` or `null` | `null` | The monitor's refresh rate |
| `workspaces` | `listOf number` | `[1]` | The workspaces to associate with this monitor exclusively |

If the above `zen.session.hyprland.monitors` option is not set, then a single monitor of those defined defaults will be used.

### Keybind Options
Alongside to the base options within the NixOS host scope, there are Home-Manager user scope options for keybinds available through the `zen.session.hyprland.keybinds` config path, allowing individual users to personal keybinds.

Workspaces can be switched by using the `MOD` key alongside the 10 numerical buttons along the keyboard.
All pre-configured keybinds can be disabled by setting `zen.session.hyprland.keybinds.enableDefault` to `false`.

The following is nested in the `zen.session.hyprland.keybinds.keys` option and controls which keys are used for specific actions.
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `mod` | `string` | `"SUPER"`   | HM User | Modifier key used for most Hyprland keybinds |
| `directions.left` | `string` | `"h"`   | HM User | Key for left navigation |
| `directions.right` | `string` | `"l"`   | HM User | Key for right navigation |
| `directions.up` | `string` | `"j"`   | HM User | Key for up navigation |
| `directions.down` | `string` | `"k"`   | HM User | Key for down navigation |
| `toggleWindowFullscreen` | `string` | `"F"`   | HM User | Key to toggle fullscreen on active window |
| `toggleWindowFloating` | `string` | `"V"`   | HM User | Key to toggle floating of active window |
| `centerWindow` | `string` | `"C"`   | HM User | Key to center active window |
| `closeWindow` | `string` | `"X"`   | HM User | Key to close active window |
| `applicationMenu` | `string` | `"SPACE"`   | HM User | Key to open application launcher menu |
| `openConfigMenu` | `string` | `"PERIOD"`   | HM User | Key to open dotfiles config menu |
| `openBrowser` | `string` | `"B"`   | HM User | Key to open configured browser |
| `openTerminal` | `string` | `"T"`   | HM User | Key to open the configured terminal emulator |
| `openFileExplorer` | `string` | `"E"`   | HM User | Key to open the configured file explorer |
| `pickColor` | `string` | `"P"`   | HM User | Key to start HyprPicker color picker |
| `takeScreenshot` | `string` | `"Print"`   | HM User | Key to take screenshots |

The actions that these keybinds result in can be configured in within the `zen.session.hyprland.keybinds.actions` attrset option.
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `applicationMenu` | `string` | `"tofi-drun \| xargs hyprctl dispatch exec --"`   | HM User | Executed when launching the application menu |
| `openBrowser` | `string` | `"firefox"`   | HM User | Executed when launching the browser |
| `openTerminal` | `string` | `"kitty"`   | HM User | Executed when launching the terminal |
| `openFileExplorer` | `string` | `"dolphin"`   | HM User | Executed when launching the file explorer |
| `pickColor` | `string` | `"hyprpicker -a -f hex"`   | HM User | Executed when picking a color |
| `takeScreenshot` | `string` | Check `./keybinds.nix` | HM User | Executed when taking screenshot |
| `takeFullScreenshot` | `string` | Check `./keybinds.nix` | HM User | Executed when taking screenshot with `CTRL` key |
| `takeWindowScreenshot` | `string` | Check `./keybinds.nix` | HM User | Executed when taking screenshot with `MOD` and `CTRL` key |

Extra custom keybinds can be configured through the `zen.session.hyprland.keybinds.extra` config path, even if default keybinds are disabled.
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `bind` | `listOf string` | `[]`   | HM User | Additional normal keybinds |
| `bindm` | `listOf string` | `[]`   | HM User | Additional mouse keybinds |
| `binde` | `listOf string` | `[]`   | HM User | Additional event keybinds |
| `bindl` | `listOf string` | `[]`   | HM User | Additional locked keybinds |


### Default ExecOnce
By default, many things are automatically included in the `execOnce` option for Hyprland.

- It sets up `cliphist` to watch `wl-paste` for copied text and images
- Starts the network-manager applet
- Sets cursor for XWayland to fix games like Minecraft missing the cursor
- Runs the `dunst` daemon if `zen.services.dunst.enable` is `true`
- Runs the `swww-daemon` if `zen.services.swww.enable` is `true`

### Default Layer Rules
- Blurs GTK Layer Shell (excluding fully transparent pixels)
- Blurs application launcher layer
- Blurs notifications layer
- Disables animation for bar

### Default Window Rules
- No shadow on floating windows
- Float, pin, keep aspect ratio, and make opaque any "Picture-in-Picture" views
- Make Blender, Godot, Floorp, Firefox, and Chrome all opaque
- Fixes to Ardour DAW focus issues
- Centers and resizes many popup Godot windows
