function xpropi3 --wraps='xprop | grep -e WM_CLASS -e WM_NAME' --description 'alias xpropi3=xprop | grep -e WM_CLASS -e WM_NAME'
  xprop | grep -e WM_CLASS -e WM_NAME $argv
        
end
