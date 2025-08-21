# 🐟 Fish
Fish stands for "Friendly Interactive SHell", which is a user-friendly command-line shell for Unix, offering features like autocompletion, autosuggestion, and syntax highlighting.

This module enables and configures it as the default user shell, with no enable/disable option, but includes options for abbreviations and aliases.


## External Links
- [Official Webpage](https://fishshell.com/)


## Options
Options can be accessed through the `zen.cli.shell.fish` config path.
| Name         | Type     | Default | Scope   | Description                               |
|--------------|----------|---------|---------|-------------------------------------------|
| `enableDefaultAbbrs` | `boolean` | `true`   | HM User | Whether to enable the pre-configured abbreviations |
| `abbrs` | `attrs` | `{}`   | HM User | Additional abbreviations to register for Fish |
| `enableDefaultAliases` | `boolean` | `true`   | HM User | Whether to enable the pre-configured aliases |
| `aliases` | `attrs` | `{}`   | HM User | Additional aliases to register for Fish |

### Default Abbreviations
Abbreviations can be expanded by simply typing the abbreviation, then hitting `Space` or `Enter`. These are the pre-configured abbreviations.
| Abbreviation | Expanded |
|-------|----------|
| `.files` | `cd ~/dotfiles` |
| `h` | `history` |
| `x` | `exit` |
| `c` | `clear` |
| `lns` | `ln -s` |
| `mkdirp` | `mkdir -p` |
| `cpr` | `cp -R` |
| `chx` | `chmod +x` |
| `chr` | `chmod -R` |
| `g` | `git` |
| `gs` | `git status` |
| `ga` | `git add` |
| `gaa` | `git add all` |
| `gc` | `git commit` |
| `gco` | `git checkout` |
| `gp` | `git push` |
| `gpl` | `git pull` |
| `gcl` | `git clone` |
| `gf` | `git fetch` |
| `gr` | `git remote` |
| `grb` | `git rebase` |
| `gb` | `git branch` |
| `gd` | `git diff` |
| `gl` | `git log` |
| `t` | `tmux` |
| `tl` | `tmux ls` |
| `ta` | `tmux attach -t` |
| `tk` | `tmux kill-session -t` |
| `ff` | `clear && fastfetch` |

### Default Aliases
If `zen.cli.shell.fish.enableDefaultAliases` is true, then these aliases are available.
| Alias | Executes |
|-------|----------|
| `gitviz` | `gource -f --frameless --highlight-dirs -s 90 --filename-time 15 --no-vsync --padding 1 --key --background 080814 --hash-seed 18 --user-image-dir ~/.avatars` |
| `tree` | `eza --tree --icons` |
| `l` | `eza -h --git --icons --color=auto --group-directories-first -s extension` |
| `ls` | `eza -l --icons --color=auto --group-directories-first` |
| `l.` | `eza -l -d .* --icons --color=auto --group-directories-first` |
| `ytmp3` | `yt-dlp -x --continue --prefer-ffmpeg --embed-thumbnail --audio-format mp3 --audio-quality 0 --add-meta-data --metadata-from-title"%(artist)s - %{title}s" -o "%(title)s.%(ext)s"` |
| `ytmp4` | `yt-dlp -x --continue --prefer-ffmpeg --embed-thumbnail --format "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" -o "%(title)s.%(ext)s"` |
| `ytogg` | `yt-dlp -x --continue --prefer-ffmpeg --remux-video ogg --audio-quality 0 -o "%(title)s.%(ext)s"` |


## Included Functions
The configuration links any files within the `./functions` directory to Fish's expected directory for functions. Below is an explanation of the functions currently included.

### `yy`
Use the `yy` function to start Yazi while maintaining persistent directory navigation, meaning that when Yazi is exited, it'll `cd` you into whatever directory Yazi was in before exiting.
