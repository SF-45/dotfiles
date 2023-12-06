function suspend.enable --wraps='systemctl unmask suspend.target' --wraps='systemctl unmask --runtime suspend.target' --description 'alias suspend.enable=systemctl unmask --runtime suspend.target'
  systemctl unmask --runtime suspend.target $argv
        
end
