# Recursive tree view. With Eza, pass options such as --level=2:
function lt --description 'Display a directory tree'
    if type -q eza
        command eza --icons=auto --group-directories-first --tree $argv
    else if type -q tree
        command tree -C $argv
    else
        printf '%s\n' 'lt: install eza or tree to display directory trees.' >&2
        return 127
    end
end
