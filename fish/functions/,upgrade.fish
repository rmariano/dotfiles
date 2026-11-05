# Upgrade OS packages
function ,upgrade
    brew update
    brew upgrade -y
    softwareupdate -ia
end
