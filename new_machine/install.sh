#!/bin/zsh

log() {
    echo
    echo "💬 $1..."
}

echo
echo '# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #'
echo '                 BEGIN INSTALLATION'
echo '# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #'
echo

log 'Installing Homebrew'
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# # NOTE:
# # https://github.com/homebrew/install#uninstall-homebrew
# # You can uninstall Homebrew with:
# # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
# # Or non-interactively with:
# # NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

log 'Adding Homebrew to PATH'
eval "$(/opt/homebrew/bin/brew shellenv)"

log 'Installing Git'
brew install git

DOTFILES_TARGET="${HOME}/.dotfiles"
if [ -d $DOTFILES_TARGET ]; then
    DOTFILES_TARGET+="-$(date +%y-%m-%d-%H%M%S)"
    log "${HOME}/.dotfiles already exists, cloning to $DOTFILES_TARGET"
else
    log "Cloning damionvega/dotfiles.git to $DOTFILES_TARGET"
fi

git clone https://github.com/damionvega/dotfiles.git $DOTFILES_TARGET

TARGET="$HOME"
log "Copying config directories inside $DOTFILES_TARGET to $TARGET"
rsync -av --exclude={'.git','*.md'} $DOTFILES_TARGET/ $TARGET

log 'Installing brew formulae'
brew install $(cat $DOTFILES_TARGET/brew-list)

log 'Installing brew casks'
brew install --cask $(cat $DOTFILES_TARGET/brew-cask-list)

log 'Setting iTerm2 preferences source'
ITERM_PREFS_DIR="${HOME}/Library/Mobile Documents/com~apple~CloudDocs/_djv/iTerm2"
defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string $ITERM_PREFS_DIR
defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true

log 'Installing schemes via iTerm2-Color-Schemes'
git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git
iTerm2-Color-Schemes/tools/import-scheme.sh 'Gruvbox Dark' 'Gruvbox Light' MaterialDesignColors synthwave-everything UltraViolent
rm -rf iTerm2-Color-Schemes

log 'Installing Ruby via rbenv'
# Current (2022-10-16) default on M2 MacBook Air:
# ruby 2.6.8p205 (2021-07-07 revision 67951) [universal.arm64e-darwin21]
rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv global $(rbenv install -l | grep -v - | tail -1)

log 'Installing Apple Command Line Tools'
xcode-select --install

log 'Changing MacOS user preferences'
source "$DOTFILES_TARGET/prefs.sh"

log 'Setting up Fish'
$(which fish) "$DOTFILES_TARGET/new_machine/setup.fish"

log 'Making Fish default shell'
chsh -s $(which fish)

echo
echo '# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #'
echo '               INSTALLATION SUMMARY'
echo '# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #'

log "✅ Ruby version: $(ruby -v)"
echo

if (( $+commands[node] )); then
    echo "✅ Node.js version: $(node -v)"
else
    echo '❌ Node.js was not installed. Check nvm.fish & Node.js was installed correctly: https://github.com/jorgebucaran/nvm.fish'
    echo 'Commands ran in fish shell:'
    echo '# Install jorgebucaran/nvm.fish'
    echo 'fisher install jorgebucaran/nvm.fish'
    echo '# Install latest Node.js LTS'
    echo 'nvm install lts'
    echo 'nvm use lts'
fi

log '✅ Homebrew installations:'
brew list

log "✅ iTerm2 custom preferences location: $ITERM_PREFS_DIR"
echo 'Restart iTerm2 and confirm preferences are loaded upon start:'
echo 'General → Preferences → [x] Load preferences from a custom folder or URL'

log "✅ Fish version: $(fish -v)"
echo "Fish should be the default shell when you start a new terminal session."
echo "If not, try again with `chsh -s $(which fish)`"
echo "See $DOTFILES_TARGET/new_machine/setup.fish for more details on how to install Fish"
echo
echo '# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #'
echo '       🏁 Finished! Enjoy your new machine! 🏁'
echo '# # # # # # # # # # # # # # # # # # # # # # # # # # # # # #'
echo
