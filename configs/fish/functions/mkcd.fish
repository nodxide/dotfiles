# Create a directory (including missing parents) and enter it:
#? Quote paths containing spaces: mkcd "new project"
function mkcd --description 'Create a directory and enter it'
    if test (count $argv) -ne 1
        printf '%s\n' 'Usage: mkcd <directory>' >&2
        return 2
    end

    command mkdir -p -- "$argv[1]"
    and cd -- "$argv[1]"
end
