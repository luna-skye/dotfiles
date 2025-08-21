function yy -d "Open Yazi with persistent directory navigation on close"
  set tmp (mktemp -t "yazi-cwd.XXXXXX")
  yazi $argv --cwd-file="$tmp"
  if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
    cd "$cwd"
  end
  rm -f -- "$tmp"
end
