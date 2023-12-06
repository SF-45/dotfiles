function cfpb --wraps='~/.config/polybar/config.ini' --wraps='vim ~/.config/polybar/config.ini' --wraps='nvim -O ~/.config/polybar/config.ini ~/.config/polybar/config.ini' --wraps='nvim -O ~/.config/polybar/config.ini ~/.config/polybar/module.ini' --wraps='nvim -O ~/.config/polybar/config.ini ~/.config/polybar/modules.ini' --description 'alias cfpb nvim -O ~/.config/polybar/config.ini ~/.config/polybar/modules.ini'
  nvim -O ~/.config/polybar/config.ini ~/.config/polybar/modules.ini $argv
        
end
