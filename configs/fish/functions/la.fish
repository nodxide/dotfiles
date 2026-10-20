# List hidden files but omit the special . and .. entries:
function la --description 'List files including hidden entries'
    if type -q eza
        command eza --icons=auto --group-directories-first --almost-all $argv
    else
        command ls --color=auto --group-directories-first -A $argv
    end
end
