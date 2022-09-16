# This shell script should be used with https://github.com/gen740/Templates
local templatedir=$HOME/.template

# init(){
#   if [[ $1 = "cmake" ]]; then
#     cp -r $templatedir/cmake/* .
#     # git submodule add https://github.com/sakra/cotire.git .cotire
#   elif [[ $1 = "cmake_cotire" ]]; then
#     cp -r $templatedir/cmake_cotire/* .
#     git submodule add https://github.com/sakra/cotire.git .cotire
#   elif [[ $1 = "gitignore" ]]; then
#     cp -r $templatedir/gitignore .gitignore
#   elif [[ $1 = "python" ]]; then
#     if [[ $2 = "" ]]; then
#       echo "please give me a second variable"
#     fi
#     cp -r $templatedir/python/* $2
#   elif [[ $1 = "latex" ]]; then
#     if [[ $2 = "" ]]; then
#       echo "please give me a second variable"
#     fi
#     cp -r $templatedir/Latex $2
#   elif [[ $1 = "typescript" ]]; then
#     if [[ $2 = "" ]]; then
#       echo "please give me a second variable"
#     fi
#     cp -r $templatedir/typescript $2
#   else
#     echo "No Such Template {$1}"
#   fi
#   echo "done"
# }
