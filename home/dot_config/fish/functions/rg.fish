function rg --description 'alias rg rg --heading --line-number --column --smart-case --trim -p' --wraps rg
  command rg --no-heading --with-filename --line-number --column --smart-case --trim $argv
end
