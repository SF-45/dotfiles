function journalctl.short --wraps='sudo journalctl -e -b -1' --description 'alias journalctl.short=sudo journalctl -e -b -1'
  sudo journalctl -e -b -1 $argv
        
end
