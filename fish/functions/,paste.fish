# Add a new file into a repo that works as a paste
# requires env var PASTE_REPO_LOCATION
function ,paste
    set current_dir (pwd)
    set file_to_add $argv[1]
    set paste_location "$PASTE_REPO_LOCATION/paste"
    cp -f $file_to_add $paste_location
    cd $paste_location
    set local_file (basename $file_to_add)
    read -P "Description [$local_file]: " description
    if test -z "$description"
        set description $local_file
    end
    git add $local_file && git commit -m "New paste: $description"
    git push origin HEAD
    set link_to_paste (gh browse -n $local_file)
    cd $current_dir
    echo "New paste successfully created at: $link_to_paste"
end
