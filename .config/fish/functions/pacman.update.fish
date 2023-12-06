function pacman.update --wraps='sudo pacman -Syu' --description 'alias pacman.update=sudo pacman -Syu'
  sudo pacman -Syu $argv
        
end
