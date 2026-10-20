# Change to the top-level directory of the current Git working tree:
function croot --description 'Change to the current Git repository root'
    if not command git rev-parse --show-toplevel >/dev/null 2>&1
        printf '%s\n' 'croot: not inside a Git repository.' >&2
        return 1
    end

    set -l root (command git rev-parse --show-toplevel)
    cd -- "$root"
end
