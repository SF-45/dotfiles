function refloginconf --wraps='systemctl status systemd-logind.service' --wraps='systemctl kill -s HUP systemd-logind' --description 'alias refloginconf=systemctl kill -s HUP systemd-logind'
  systemctl kill -s HUP systemd-logind $argv
        
end
