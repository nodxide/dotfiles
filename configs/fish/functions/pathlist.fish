# Print PATH entries one per line with stable line numbers:
function pathlist --description 'Print PATH entries one per line with line numbers'
    printf '%s\n' $PATH | nl -ba
end
