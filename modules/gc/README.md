# Garbage Collection
This module handles garbage collection within NixOS, limiting previous generation count, and triggering automatic `/nix/store` cleanup.


## External Links
- [Garbage Collection - NixOS Wiki]()


## Options
Options can be accessed through the `zen.gc` config path.
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `enableAuto` | `boolean` | `true`   | NixOS Host | Whether to enable automatic garbage collection |
| `autoFrequency` | `string` | `"weekly"`   | NixOS Host | Frequency in which garbage collection is automatically ran |
| `autoDeleteAfter` | `string` | `"1w"`   | NixOS Host | Maximum age allowed before deletion |
