# Lazy load PYENV and NODENV

if [ -d "$XDG_CONFIG_HOME/nodenv" ]; then
    export NODENV_ROOT="$XDG_CONFIG_HOME/nodenv"
    export PATH="${NODENV_ROOT}/shims:${PATH}"
    if [ -e $NODENV_ROOT ]; then
        _load_nodenv() {
            unset -f _load_nodenv nodenv npm node
            eval "$(nodenv init -)"
        }
        nodenv() {
            _load_nodenv
            nodenv $@
        }
        npm() {
            _load_nodenv
            npm $@
        }
        node() {
            _load_nodenv
            node $@
        }
    fi
fi
