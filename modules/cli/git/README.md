# Git
Git is a software version control (SVC) system which allows files to be tracked and versioned efficiently, allowing code reversion and simplified tracking of changing.


## External Links
- [Official Webpage](https://git-scm.com/)


## Options
Options can be accessed with the `zen.cli.git` config path.

| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `userName` | `string` | `""`   | HM User | User's Git username |
| `email` | `string` | `""`   | HM User | User's Git email address |
| `initBranch` | `string` | `"main"`   | HM User | Default main branch in new projects |
| `enableDefaultIgnores` | `boolean` | `true`   | HM User | Whether to enable default ignored files |
| `ignores` | `listOf string` | `[]`   | HM User | Files to ignore in Git |
| `enableDefaultAliases` | `boolean` | `true`   | HM User | Whether to enable default Git alias shorthands |
| `aliases` | `attrs` | `{}`   | HM User | Additional alias shorthands to register in Git |

### Default Ignores
If the `zen.cli.git.enableDefaultIgnores` option is set to true, the following files will always be ignored by Git.

- `.cache/`
- `.DS_Store`
- `.idea/`
- `*.swp`
- `*.elc`
- `.direnv/`
- `node_modules`
- `result`
- `result-*`

### Default Aliases
If the `zen.cli.git.enableDefaultAliases` option is true, the following aliases can be used after the `git` command.

- `graph` - `log --all --graph --decorate --oneline`
- `hist` - `log --graph --date=relative --pretty=format:"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%Creset" --decorate --all`
- `llog` - `log --graph --date=relative --pretty=format:"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset)" --name-status`

