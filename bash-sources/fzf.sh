#!/usr/bin/env bash


THIS_PROG="$BASH_SOURCE"


function install_batcat {
    sudo apt install -yq bat
}
sd::lazy_install_hook --interactive batcat install_batcat

function install_fzf {
    # for rg
    #  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/ripgrep_15.2.0-1_amd64.deb │ sudo dpkg -i ripgrep_15.2.0-1_amd64.deb
    # for fzf
    #  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    # ~/.fzf/install
    echo "should detemine the latest vesion, curl, and git it ..."

    sd::log::command sudo apt install -yq fzf
    echo "reloading fzf settings ..."
    . "$THIS_PROG"
}
sd::lazy_install_hook --interactive fzf install_fzf

function init_fzf {
    export FZF_DEFAULT_COMMAND='rg --hidden --no-ignore -l ""'
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --preview 'batcat --style=numbers --color=always --line-range :500 {}'"
    export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} --bind 'ctrl-o:execute($EDITOR -p {+})+abort,ctrl-y:execute-silent(echo {} | xclip -sel clip)+abort'"

    if sd::bin_exists fzf ; then
        alias fzf="fzf --multi"

        builtin set -o histexpand
        builtin bind -x '"\C-x1": __fzf_history'
        builtin bind '"\C-r": "\C-x1\e^\er"'
    else
        unalias fzf >/dev/null 2>&1
    fi
}
sd::func::jit fzf init_fzf

# Another CTRL-R script to insert the selected command from history into the command line/region
__fzf_history ()
{
    builtin history -a;
    builtin history -c;
    builtin history -r;
    builtin typeset \
        READLINE_LINE_NEW="$(
            HISTTIMEFORMAT= builtin history |
            command fzf +s --tac +m -n2..,.. --tiebreak=index --toggle-sort=ctrl-r |
            command sed '
                /^ *[0-9]/ {
                    s/ *\([0-9]*\) .*/!\1/;
                    b end;
                };
                d;
                : end
            '
        )";

        if
                [[ -n $READLINE_LINE_NEW ]]
        then
                builtin bind '"\er": redraw-current-line'
                builtin bind '"\e^": magic-space'
                READLINE_LINE=${READLINE_LINE:+${READLINE_LINE:0:READLINE_POINT}}${READLINE_LINE_NEW}${READLINE_LINE:+${READLINE_LINE:READLINE_POINT}}
                READLINE_POINT=$(( READLINE_POINT + ${#READLINE_LINE_NEW} ))
        else
                builtin bind '"\er":'
                builtin bind '"\e^":'
        fi
}

fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    local tmp_opts="${FZF_DEFAULT_OPTS}"
    local tmp_opts="${tmp_opts} --preview 'batcat --style=numbers --color=always --line-range $1:-10 --line-range $1:+10 --highlight-line $1 {}' --bind 'enter:become(code {})' --bind 'ctrl-o:execute(vim {})' --bind 'ctrl-f:preview-page-down,ctrl-b:preview-page-up' "

    rg --files-with-matches --no-messages "$1" | FZF_DEFAULT_OPTS=$tmp_opts fzf
}
