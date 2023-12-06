function l --wraps='ls -la --group-directories-first' --wraps='ls -l --group-directories-first' --wraps='ls -1a --group-directories-first' --description 'alias l=ls -1a --group-directories-first'
  ls -1a --group-directories-first $argv
        
end
