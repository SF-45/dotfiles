function lspci.vga --wraps='lspci -k | grep -A 3 -i -e display -e vga' --description 'alias lspci.vga lspci -k | grep -A 3 -i -e display -e vga'
  lspci -k | grep -A 3 -i -e display -e vga $argv
        
end
