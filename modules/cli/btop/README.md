# 📊 Btop
Btop++ is a system monitor and process manager terminal program, providing readouts for CPU, RAM, Disk, Network, and Process activity, as well as sending signals such as KILL and TERM to individual processes.

It is enabled by default with many overridable options to control how it displays information.


## Options
Options can be accessed from the `zen.cli.btop` config path.

| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `updateRate` | `number` | `200`   | HM User | Default time in ms between visual updates |
| `graphSymbol.default` | `string enum [ "braille" "block" "tty" ]` | `"tty"`   | HM User | Default symbol to show for graphs |
| `graphSymbol.cpu` | `string enum [ "default" "braille" "block" "tty" ]` | `"default"`   | HM User | Symbol to show for CPU graphs |
| `graphSymbol.mem` | `string enum [ "default" "braille" "block" "tty" ]` | `"default"`   | HM User | Symbol to show for Memory graphs |
| `graphSymbol.net` | `string enum [ "default" "braille" "block" "tty" ]` | `"default"`   | HM User | Symbol to show for Network graphs |
| `graphSymbol.proc` | `string enum [ "default" "braille" "block" "tty" ]` | `"default"`   | HM User | Symbol to show for Process graphs |
| `process.sorting` | `string enum [ "pid" "program" "arguments" "thread" "user" "memory" "cpu lazy" "cpu responsive" ]` | `"cpu lazy"`   | HM User | Default sorting method for Processes |
| `process.reversed` | `boolean` | `false`   | HM User | Whether to reverse Process listing order by default |
| `process.tree` | `boolean` | `false`   | HM User | Whether to display Process list as a tree by default |
| `process.colors` | `boolean` | `true`   | HM User | Whether to enable Process colors by default |
| `process.gradient` | `boolean` | `true`   | HM User | Whether to enable Process color gradients by default |
| `process.perCore` | `boolean` | `true`   | HM User | Whether CPU usage should be categorized by core |
| `process.memBytes` | `boolean` | `true`   | HM User | Whether memory usage should be defined in bytes instead of percentage |
