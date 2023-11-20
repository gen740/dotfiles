# Lazy load PYENV and NODENV

export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
if [ -e $PYENV_ROOT ]; then
    if [[ $OSTYPE =~ 'darwin*' ]]; then
        export PYTHON_CONFIGURE_OPTS="--enable-framework"
    else
        export PYTHON_CONFIGURE_OPTS="--enable-shared"
    fi
    export PIPX_DEFAULT_PYTHON="$PYENV_ROOT/versions/pipx/bin/python3"

    ## Lazy loading pyenv
    _load_pyenv() {
        unset -f _load_pyenv pyenv python python3 ipython ipython3 pip 
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    }
    pyenv() {
        _load_pyenv
        pyenv $@
    }
    python() {
        _load_pyenv
        python $@
    }
    ipython() {
        _load_pyenv
        ipython $@
    }
    ipython3() {
        _load_pyenv
        ipython3 $@
    }
    python3() {
        _load_pyenv
        python3 $@
    }
    pip() {
        _load_pyenv
        pip $@
    }
fi

export NODENV_ROOT="$XDG_CONFIG_HOME/nodenv"
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
