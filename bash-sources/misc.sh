function cd {
    pushd "$@" >/dev/null
}

function back {
    popd >/dev/null
}

function h {
    pushd ~ >/dev/null
}

function markd {
    pushd . >/dev/null
}

function md {
    mkdir -p "$1" ; cd "$1";
}
