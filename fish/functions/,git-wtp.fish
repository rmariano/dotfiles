### Remove the given git worktrees
function ,git-wtp
    if test (count $argv) -eq 0
        echo "Usage: ,git-wtp <worktree-path>..." >&2
        return 1
    end

    for path in $argv
        echo "Removing worktree at $path"
        git worktree remove $path
    end
end
