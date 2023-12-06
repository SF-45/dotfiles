function suspend.disable --wraps='systemctl mask --runtime suspend.target' --description 'alias suspend.disable=systemctl mask --runtime suspend.target'
  systemctl mask --runtime suspend.target $argv
        
end
