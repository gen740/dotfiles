change() {
    current_session=`tmux display-message -p '#S'`
    current_tty=`tmux list-clients -t $current_session | awk '{print $1;}' | sed 's/.$//'`
    thumbnails='$HOME/Home/Shelf/WallPaper'
    images=(`ls $thumbnails`)
    num_images=${#images[*]}
    myfilename="${thumbnails}/`echo ${images[$((RANDOM%$num_images))]}`"
    # echo $myfilename;
    base64filename=`echo "${myfilename}" | base64`;
    echo "\033]1337;SetBackgroundImageFile=${base64filename}\a";
    unset $RANDOM
    unset current_tty
    unset current_session
}

change_f() {
    current_session=`tmux display-message -p '#S'`
    current_tty=`tmux list-clients -t $current_session | awk '{print $1;}' | sed 's/.$//'`
    thumbnails='$HOME/Home/Shelf/WallPaper_Favorite'
    images=(`ls $thumbnails`)
    num_images=${#images[*]}
    myfilename="${thumbnails}/`echo ${images[$((RANDOM%$num_images))]}`"
    # echo $myfilename;
    base64filename=`echo "${myfilename}" | base64`;
    echo "\033]1337;SetBackgroundImageFile=${base64filename}\a";
    unset $RANDOM
    unset current_tty
    unset current_session
}

blackout() {
    current_session=`tmux display-message -p '#S'`
    current_tty=`tmux list-clients -t $current_session | awk '{print $1;}' | sed 's/.$//'`
    echo "\033]1337;SetBackgroundImageFile=\a";
    unset current_tty
    unset current_session
}

badge() {
    current_session=`tmux display-message -p '#S'`
    if [[ ! -n $TMUX ]]; then
        current_tty=`tty`
    else
        current_tty=`tmux list-clients -t $current_session | awk '{print $1;}' | sed 's/.$//'`
    fi
    printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$1" | base64) > $current_tty
    unset current_tty
    unset current_session
}

hh() {
    dirname=`fd -c never . ~/Home/ -aHI --type d --exclude .git --exclude Labo/Qt --exclude build --exclude _build \
        --exclude .build --exclude mbed-os --exclude .cache --exclude node_modules \
        --exclude cmake_build --exclude bin --exclude keyboards --exclude tests --exclude boost-for-raspi \
        --exclude typings --exclude external --exclude .deps \
        --exclude python3.8 | fzf-tmux`
    if [[ $dirname == ""  ]]; then
    else
        pushd $dirname > /dev/null
    fi
    unset dirname
}

ff() {
    dirname=`fd -c never . --type d --exclude .git $1 | fzf-tmux`
    if [[ $dirname == ""  ]]; then
    else
        pushd $dirname > /dev/null
    fi
    unset dirname
}

# Custom Bindings
# zle -N hcd
# zle -N fvi
# bindkey '^A' hcd
# bindkey '^O' fvi
