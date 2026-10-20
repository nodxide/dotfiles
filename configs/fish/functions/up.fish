# Move up N directory levels:
#? Examples: up, up 2, up 3.
function up --description 'Move up one or more directory levels'
    if test (count $argv) -gt 1
        printf '%s\n' 'Usage: up [levels]' >&2
        return 2
    end

    set -l levels 1
    if test (count $argv) -eq 1
        set levels $argv[1]
    end

    if not string match --regex --quiet '^[1-9][0-9]*$' -- "$levels"
        printf '%s\n' 'up: levels must be a positive integer.' >&2
        return 2
    end

    set -l destination (string repeat --count "$levels" '../')
    cd -- "$destination"
end
