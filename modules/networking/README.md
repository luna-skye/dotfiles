# Networking
This module handles networking configuration within NixOS, enabling and configuring the Network Manager and related services.


## External Links
- [Networking - NixOS Wiki](https://nixos.wiki/wiki/Networking)


## Options
Options can be accessed through the `zen.networking` config path.
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `ssh.enable` | `boolean` | `true`   | NixOS Host | Whether to enable the OpenSSH service on the NixOS host |
| `allowSSH` | `boolean` | `false`   | HM User | Whether to allow SSH connections to be made to this user |
