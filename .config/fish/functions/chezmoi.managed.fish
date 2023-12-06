function chezmoi.managed --wraps='chezmoi managed | fzf' --description 'alias chezmoi.managed=chezmoi managed | fzf'
  chezmoi managed | fzf $argv
        
end
