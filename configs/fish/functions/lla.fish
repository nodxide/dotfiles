# Long listing including hidden entries; Eza also displays Git status:
function lla --description 'Detailed listing including hidden entries and Git status'
    if type -q eza
        command eza --icons=auto --group-directories-first --almost-all --long --header --git $argv
    else
        command ls --color=auto --group-directories-first -lAh $argv
    end
end
