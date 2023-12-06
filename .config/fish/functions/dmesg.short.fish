function dmesg.short --wraps='sudo dmesg -l warn, err' --wraps='sudo dmesg -l warn,err' --description 'alias dmesg.short=sudo dmesg -l warn,err'
  sudo dmesg -l warn,err $argv
        
end
