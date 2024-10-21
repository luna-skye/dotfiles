# 👤 Users - Home Module
This module handles options and configuration for basic user config, such as user name, user system registration, user groups.

Though exposing system level options, this home module only handles configuration of home scoped options, see the system module at `config/system/users/` to see their implementation.

<!-- TODO TASKS

 TODO: Include links to occurences of scope bleed
 NOTE: Consider moving `bead.user.dirs` to `bead.home.dirs`, if `bead.home` makes sense as a module
 TEST: All config options in this module

-->


## Exposed Options

| **OPTION**      | **DESCRIPTION**                                                                              | **TYPE**        | **DEFAULT**                     | **SCOPE BLEED**        |
|-----------------|----------------------------------------------------------------------------------------------|-----------------|---------------------------------|------------------------|
| name            | The user's name, used in registering the user in home-manager, the system, and other things. | string          | `"user"`                        |                        |
| isNormalUser    | Whether the user is registered as a normal user in NixOS.                                    | boolean         | `true`                          | `sys/users/`           |
| extraGroups     | Which extra groups to register the user under in NixOS.                                      | list            | `[ "network-manager" "wheel" ]` | `sys/users/`           |
| dirs            | Declaration of 


