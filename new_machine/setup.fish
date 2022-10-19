#!/opt/homebrew/bin/fish

function log
    echo
    echo "💬 $argv..."
end

set FISH_PATH (which fish)
set BREW_PATH /opt/homebrew/bin

log 'Verifying Homebrew binaries available in $PATH'

if not string match -e $BREW_PATH (echo $PATH | grep $BREW_PATH)
    log "Adding $BREW_PATH to PATH"
    set -U fish_user_paths $BREW_PATH $fish_user_paths
    fish_add_path $BREW_PATH
else
    log '$BREW_PATH already exists in $PATH:'
    echo $PATH
end

log 'Verifying Fish path exists in /etc/shells'

if not string match -e $FISH_PATH (cat /etc/shells | grep $FISH_PATH)
    log "Adding $FISH_PATH to /etc/shells"
    # echo $FISH_PATH | sudo tee -a /etc/shells
    sudo sh -c "echo $FISH_PATH >> /etc/shells"
else
    log '$FISH_PATH already exists in /etc/shells:'
    cat /etc/shells
end

log 'Installing Fisher & plugins'
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

log 'Installing jorgebucaran/nvm.fish'
fisher install jorgebucaran/nvm.fish

log 'Installing jethrokuan/z'
fisher install jethrokuan/z

log 'Installing latest Node.js LTS with jorgebucaran/nvm.fish'
nvm install lts

log 'Updating Fish completions'
fish_update_completions

exit
