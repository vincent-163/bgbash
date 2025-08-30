mkterm() {
    NAME="$1"
    if [ -z "$NAME" ]; then
        NAME=$(head -c 4 /dev/urandom | xxd -p)
        NAME="/tmp/terminal-$(date '+%Y-%m-%d_%H:%M:%S')-$NAME"
    fi
    (
        touch "$NAME".in
        tail -n 0 -f "$NAME.in" | script -q -f -O "$NAME".out -T "$NAME.time" >/dev/null 2>&1
        rm "$NAME".in
    ) &
    echo "Terminal created, input by appending $NAME.in, read output by tail $NAME.out"
}

termpaste() {
    (printf '\e[200~'; tr '\n' '\r'; printf '\e[201~') >> "${1:-/dev/stdout}"
}

termview() {
    tail -n +2 -f "$1.out"
}

termwait() {
    while :; do s=$(wc -c <"$1.out"); sleep "${2:-5}"; [ "$s" = "$(wc -c <"$1.out")" ] && return; done;
}

termattach() (
    if [ ! -f "$1".in ]; then
        echo "Terminal $1 not running"; exit 1
    fi
    socat -,raw,echo=0,escape=0x1d SYSTEM:"printf socat-process-\$\$\\\\\\\\n\\\\\\\\r; tail -n +2 -f $(printf %q "$1.out") </dev/null 2>/dev/null & cat >> $(printf %q "$1.in")"
)
