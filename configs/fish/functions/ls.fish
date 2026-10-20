# List files with Eza when available, otherwise use the system ls:
#? Directory-first sorting keeps folders easy to scan.
function ls --description 'List files with Eza or the system ls fallback'
    if type -q eza
        command eza --icons=auto --group-directories-first $argv
    else
        command ls --color=auto --group-directories-first $argv
    end
end
