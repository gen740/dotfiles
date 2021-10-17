init(){
    if [[ $1 = "cmake" ]]; then
        cp -r ~/.template/cmake/* .
        git submodule add https://github.com/sakra/cotire.git .cotire
    elif [[ $1 = "gitignore" ]]; then
        cp -r ~/.template/gitignore .gitignore
    elif [[ $1 = "python" ]]; then
        if [[ $2 = "" ]]; then
            echo "please give me a second variable"
        fi
        cp -r ~/.template/python $2
    elif [[ $1 = "latex" ]]; then
        if [[ $2 = "" ]]; then
            echo "please give me a second variable"
        fi
        cp -r ~/.template/Latex $2
    else
        echo "No Such Template {$1}"
    fi
    echo "done"
}
