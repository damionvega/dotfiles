set fish_greeting

set -x EDITOR nvim
set -x GREP_COLOR "1;37;45"
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x GPG_TTY tty

# Config
set cfg ~/.config/fish/config.fish
function vc ; nvim $cfg; end
function sc ; source $cfg; echo "Fish config reloaded!"; end

# Paths
fish_add_path /usr/local/sbin
fish_add_path /usr/local/bin
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/postgresql@12/bin
fish_add_path ~/.rbenv/shims
fish_add_path ~/.rbenv/bin

# Navigation
function ..   ; cd .. ; end
function ...  ; cd ../.. ; end
function .... ; cd ../../.. ; end
function l    ; tree --dirsfirst -aFCNL 1 $argv ; end
function ll   ; tree --dirsfirst -ChFupDaLg 1 $argv ; end

# Vim
function v  ; nvim $argv ; end
function vp ; nvim -p $argv ; end

# NVM → Node.js
if not type -q node
  nvm use lts
end

# NPM
function ni   ; npm install $argv ; end
function nis  ; npm install --save $argv ; end
function nus  ; npm uninstall --save $argv ; end
function nisd ; npm install --save-dev $argv ; end
function nusd ; npm uninstall --save-dev $argv ; end
function nr   ; npm run $argv ; end
function nt   ; npm test ; end
function ntw  ; npm run test:watch ; end
function ntc  ; npm run cron:test ; end
function ntcw ; npm run cron:test:watch ; end
function nd   ; npm run dev ; end

# Yarn
function y    ; yarn $argv ; end
function yt   ; yarn test ; end
function ytw  ; yarn test:watch ; end
function ytwa ; yarn test:watch:all ; end
function ya   ; yarn add $argv ; end
function yr   ; yarn remove $argv ; end
function yad  ; yarn add $argv --dev ; end
function yrd  ; yarn remove $argv --dev ; end
function yi   ; yarn ios ; end

# Git
function g    ; git $argv ; end
function gl   ; git pull ; end
function gp   ; git push $argv ; end
function gm   ; git merge $argv ; end
function gst  ; git status ; end
function gd   ; git diff $argv ; end
function gaa  ; git add . ; end
function gcm  ; git commit -m $argv ; end
function gsta ; git stash ; end
function gsp  ; git stash pop ; end
function glg  ; git log ; end
function glgg ; git log --graph --decorate --oneline (git rev-list -g --all) ; end
function gco  ; git checkout $argv ; end
function gb   ; git branch $argv ; end
function grv  ; git remote -v ; end
function grb  ; git rebase $argv ; end
function grbc ; git rebase --continue ; end
function grbs ; git rebase --skip ; end
function grba ; git rebase --abort ; end
function grhh ; git reset HEAD --hard ; end

# Postgres
function pgup   ; pg_ctl -D /usr/local/var/postgres start ; end
function pgdown ; pg_ctl -D /usr/local/var/postgres stop -s -m fast ; end

# Cocoapods
function pi  ; pod install $argv ; end
function pir ; pod install --repo-update ; end

# Utilities
function a        ; command rg --ignore=.git --ignore=log --ignore=tags --ignore=tmp --ignore=vendor --ignore=spec/vcr $argv ; end
function b        ; bundle exec $argv ; end
function d        ; du -h -d=1 $argv ; end
function df       ; command df -h $argv ; end
function digga    ; command dig +nocmd $argv[1] any +multiline +noall +answer; end
function grep     ; command grep --color=auto $argv ; end
function httpdump ; sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*" ; end
function ip       ; curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g' ; end
function localip  ; ipconfig getifaddr en0 ; end
function lookbusy ; cat /dev/urandom | hexdump -C | grep --color "ca fe" ; end
function t        ; command tree -C $argv ; end
function tmux     ; command tmux -2 $argv ; end
function tunnel   ; ssh -D 8080 -C -N $argv ; end

# View files/dirs
function c
  if test (count $argv) -eq 0
    tree --dirsfirst -aFCNL 1 ./
    return
  end

  for i in $argv
    set_color yellow
    if test (count $argv) -gt 1; echo "$i:" 1>&2; end
    set_color normal

    if test -e $i; and test -r $i
      if test -d $i
        tree --dirsfirst -aFCNL 1 $i
      else if file -b --mime-type $i | string match -q -r '^image\/'
        imgcat $i
      else
        bat --paging never $i
      end
    else
      set_color red
      echo "Cannot open: $i" 1>&2
    end

    set_color normal
  end
end

function l; c $argv; end


#--------------------------------------------------------------------------------
# Apps 
#--------------------------------------------------------------------------------

function oapp
    osascript -e "open app \"$argv\""
end

function qapp
    osascript -e "quit app \"$argv\""
end

# Homebrew
/opt/homebrew/bin/brew shellenv | source
if type -q brew
  if test -d (brew --prefix)"/share/fish/completions"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
  end

  if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
  end
end

# iTerm2
if test -e {$HOME}/.iterm2_shell_integration.fish 
  source {$HOME}/.iterm2_shell_integration.fish
end

# Espanso
alias ess "espanso start"
alias esr "espanso restart"
alias ese "espanso edit"

# Moom
set icloudDir "~/Library/Mobile\ Documents/com~apple~CloudDocs"
alias imoom "\
  qapp Moom;\
  sleep 1;
  defaults import com.manytricks.Moom $icloudDir/_djv/Moom.plist;\
  sleep 1;
  oapp Moom"
alias emoom "defaults export com.manytricks.Moom $icloudDir/_djv/Moom.plist"

# SnowSQL
alias snowsql "/Applications/SnowSQL.app/Contents/MacOS/snowsql"
