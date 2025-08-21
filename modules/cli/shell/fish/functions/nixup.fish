function nixup -d "Pulls dotfiles and rebuilds immediately"
  cd ~/dotfiles
  just pull
  just build
end
