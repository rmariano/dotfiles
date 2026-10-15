### Show diff in a web
function ,git-diff
    set current_branch (git rev-parse --abbrev-ref HEAD)
    set against $argv[1]
    git diff $against | diff2html -i stdin -t "Diff $current_branch..$against" --summary open
end
