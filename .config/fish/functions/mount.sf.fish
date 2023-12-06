function mount.sf --wraps='sudo mount --mkdir -o uid=sf,gid=users,fmask=113,dmask=002' --description 'alias mount.sf sudo mount --mkdir -o uid=sf,gid=users,fmask=113,dmask=002'
  sudo mount --mkdir -o uid=sf,gid=users,fmask=113,dmask=002 $argv
        
end
