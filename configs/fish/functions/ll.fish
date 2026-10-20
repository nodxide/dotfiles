# Long listing with metadata and Git status (when Eza is installed):
function ll --description 'Detailed file listing with metadata and Git status'
    if type -q eza
        command eza --icons=auto --group-directories-first --long --header --git $argv
    else
        command ls --color=auto --group-directories-first -lh $argv
    end
end
