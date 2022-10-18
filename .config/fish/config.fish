set fish_greeting

set -x EDITOR nvim
set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_DEFAULT_COMMAND 'git ls-tree -r --name-only HEAD 2> /dev/null; or fd --type f --hidden --follow --exclude .git 2> /dev/null'
set -x FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -x GPG_TTY (tty)
set -x GREP_COLOR "1;37;45"
set -x JRUBYOPT "-Xcext.enabled=true"
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8
set -x RBENV_ROOT /usr/local/var/rbenv
set -x RBXOPT -X19
set -x TDD 0

# Paths
test -d /usr/local/share/npm/bin; and set PATH /usr/local/share/npm/bin $PATH
test -d /usr/local/racket/bin; and set PATH /usr/local/racket/bin $PATH
test -d /usr/local/heroku/bin; and set PATH /usr/local/heroku/bin $PATH
test -d /usr/local/sbin; and set PATH /usr/local/sbin $PATH
test -d /usr/local/bin; and set PATH /usr/local/bin $PATH
test -d ~/Library/Python/2.7/bin; and set PATH ~/Library/Python/2.7/bin $PATH
test -d /usr/local/var/rbenv; and set PATH /usr/local/var/rbenv $PATH
test -d $HOME/.rbenv/shims; and set PATH $HOME/.rbenv/shims $PATH
test -d $HOME/.rbenv/bin; and set PATH $HOME/.rbenv/bin $PATH


# Navigation
function ..
    cd ..
end
function ...
    cd ../..
end
function ....
    cd ../../..
end
function .....
    cd ../../../..
end
function l
    tree --dirsfirst -aFCNL 1 $argv
end
function ll
    tree --dirsfirst -ChFupDaLg 1 $argv
end

# Vim
function vp
    nvim -p $argv
end
function v
    nvim $argv
end

# NPM
function ni
    npm install $argv
end
function nis
    npm install --save $argv
end
function nus
    npm uninstall --save $argv
end
function nisd
    npm install --save-dev $argv
end
function nusd
    npm uninstall --save-dev $argv
end
function nr
    npm run $argv
end
function nt
    npm test
end
function ntw
    npm run test:watch
end
function ntc
    npm run cron:test
end
function ntcw
    npm run cron:test:watch
end
function nd
    npm run dev
end

# Git
function g
    git $argv
end
function gl
    git pull
end
function gp
    git push $argv
end
function gm
    git merge $argv
end
function gst
    git status
end
function gd
    git diff $argv
end
function gaa
    git add .
end
function gcm
    git commit -m $argv
end
function gsta
    git stash
end
function gsp
    git stash pop
end
function glg
    git log
end
function glgg
    git log --graph --decorate --oneline (git rev-list -g --all)
end
function gco
    git checkout $argv
end
function gb
    git branch $argv
end
function grv
    git remote -v
end
function grb
    git rebase $argv
end
function grbc
    git rebase --continue
end
function grbs
    git rebase --skip
end
function grba
    git rebase --abort
end
function grhh
    git reset HEAD --hard
end

# Postgres
function pgup
    pg_ctl -D /usr/local/var/postgres start
end
function pgdown
    pg_ctl -D /usr/local/var/postgres stop -s -m fast
end

# Cocoapods
function pi
    pod install $argv
end
function pir
    pod install --repo-update
end

# Utilities
function a
    command rg --ignore=.git --ignore=log --ignore=tags --ignore=tmp --ignore=vendor --ignore=spec/vcr $argv
end
function b
    bundle exec $argv
end
function d
    du -h -d=1 $argv
end
function df
    command df -h $argv
end
function digga
    command dig +nocmd $argv[1] any +multiline +noall +answer
end
function f
    foreman run bundle exec $argv
end
function g
    git $argv
end
function grep
    command grep --color=auto $argv
end
function httpdump
    sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E "Host\: .*|GET \/.*"
end
function ip
    curl -s http://checkip.dyndns.com/ | sed 's/[^0-9\.]//g'
end
function localip
    ipconfig getifaddr en0
end
function lookbusy
    cat /dev/urandom | hexdump -C | grep --color "ca fe"
end
function mp
    nvim $argv
end
function rkt
    racket -il xrepl $argv
end
function t
    command tree -C $argv
end
function tmux
    command tmux -2 $argv
end
function tunnel
    ssh -D 8080 -C -N $argv
end
function view
    nvim -R $argv
end

# Fuzzy find & vim
function vp
    if test (count $argv) -gt 0
        command nvim $argv
    else
        fzf -m | xargs nvim
    end
end

# View files/dirs
function c
    if test (count $argv) -eq 0
        tree --dirsfirst -aFCNL 1 ./
        return
    end

    for i in $argv
        set_color yellow
        if test (count $argv) -gt 1
            echo "$i:" 1>&2
        end
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

function l
    c $argv
end

# Completions
function make_completion --argument-names alias command
    echo "
    function __alias_completion_$alias
        set -l cmd (commandline -o)
        set -e cmd[1]
        complete -C\"$command \$cmd\"
    end
    " | source
    complete -c $alias -a "(__alias_completion_$alias)"
end

make_completion b 'bundle exec'
make_completion f 'foreman run'
make_completion g git
make_completion mp nvim
make_completion vp nvim

# fisher
set fisher_home ~/.local/share/fisherman
if test -f $fisher_home/config.fish
    set fisher_config ~/.config/fisherman
    source $fisher_home/config.fish
end

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Load rbenv automatically
if hash rbenv 2>/dev/null
    status --is-interactive; and source (rbenv init -|psub)
end

# nvm
if hash bass 2>/dev/null
    function nvm
        bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
    end
    nvm >/dev/null
end

# hub
if hash hub 2>/dev/null
    eval (hub alias -s)
end

# dev
if test -f /opt/dev/dev.fish
    source /opt/dev/dev.fish
end

# opam
if hash opam 2>/dev/null
    eval (opam config env)
end

# iterm2
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish
