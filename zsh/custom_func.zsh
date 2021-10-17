#!bin/zsh

mynvim() {
  nvim $@; 
  clear;
}

if [[ -n $TMUX ]]; then
  change() {
    current_session=`tmux display-message -p '#S'`
    current_tty=`tmux list-clients -t $current_session | awk '{print $1;}' | sed 's/.$//'`
    thumbnails='$HOME/Home/Shelf/WallPaper'
    images=(`ls $thumbnails`)
    num_images=${#images[*]}
    myfilename="${thumbnails}/`echo ${images[$((RANDOM%$num_images))]}`"
    echo $myfilename > $current_tty
    base64filename=`echo ""${myfilename}"" | base64`;
    echo "\033]1337;SetBackgroundImageFile=${base64filename}\a" > $current_tty;
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
    base64filename=`echo "${myfilename}" | base64`;
    echo "\033]1337;SetBackgroundImageFile=${base64filename}\a" > $current_tty;
    unset $RANDOM
    unset current_tty
    unset current_session
  }
    blackout() {
    current_session=`tmux display-message -p '#S'`
    current_tty=`tmux list-clients -t $current_session | awk '{print $1;}' | sed 's/.$//'`
    echo "\033]1337;SetBackgroundImageFile=\a" > $current_tty;
    unset current_tty
    unset current_session
  }
  badge() {
    printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$1" > $current_tty | base64)
  }
else
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
    printf "\e]1337;SetBadgeFormat=%s\a" $(echo -n "$1" | base64)
  }
fi

cpprun() {
  g++-10 $1 -o $2 && ./$2;
}

cpprunanyway() {
  g++-10 $1 -o main && ./main
}

Atcoder() {
  dir="$HOME/Home/Labo/AtCoder"
  zparseopts -D -E -F - e:=empty 
  echo $empty[2]
  if [[ $empty[2] -eq 1 ]]; then
    echo "empty"
    cd $dir
    cp -f .PRESET_buk .PRESET
    echo "#include <iostream>\n\nint main() {\n  \n  return 0;\n}" > AtCoder.cpp
    echo "None" > TEST_SET_1
    echo "None" > TEST_SET_2
    echo "None" > TEST_SET_3
    nvim -S .PRESET -c "set filetype=cpp | NERDTreeToggle |wincmd l |4"
  else
    cd $dir
    cp -f .PRESET_buk .PRESET
    nvim -S .PRESET -c "set filetype=cpp | NERDTreeToggle |wincmd l |0"
  fi
  unset empty
}

AtCodeCheck() {
  g++-9 AtCoder.cpp -o Answer.out && 
    (
      if [[ `cat TEST_SET_1` != 'None' ]]; then
        echo "############################### TEST_SET_1 ###############################"
        cat TEST_SET_1 | ./Answer.out
      fi
      if [[ `cat TEST_SET_2` != 'None' ]]; then
        echo "############################### TEST_SET_2 ###############################"
        cat TEST_SET_2 | ./Answer.out
      fi
      if [[ `cat TEST_SET_3` != 'None' ]]; then
        echo "############################### TEST_SET_3 ###############################"
        cat TEST_SET_3 | ./Answer.out
      fi
    )
  }

mutal_sync() {
  fswatch -o $1 $2 | xargs -I{} unison -batch $1 $2
}

hcd() {
  dirname=`fd -c never . ~/Home/ -aHI --type d --exclude .git --exclude Labo/Qt --exclude build --exclude _build \
    --exclude .build --exclude mbed-os --exclude .cache --exclude node_modules \
    --exclude cmake_build --exclude bin --exclude keyboards --exclude tests --exclude boost-for-raspi \
    --exclude typings --exclude external --exclude .deps \
    --exclude python3.8 \
    --exclude Quiver.qvlibrary | fzf-tmux`
  if [[ $dirname == ""  ]]; then
  else
    pushd $dirname > /dev/null
  fi
}

fcd() {
  dirname=`fd -c never . --type d --exclude .git | fzf-tmux`
  if [[ $dirname == ""  ]]; then
  else
    pushd $dirname > /dev/null
  fi
  unset dirname
}

fvi() {
  filename=`fd . --type f --exclude ".git" --exclude "build*" --exclude "*.o" --exclude "*.a" --exclude "*.so" | fzf-tmux`
  if [[ $filename == ""  ]]; then
  else
    nvim $filename
  fi
  unset filename
}

rosinit() {
  source ~/ros2_foxy/ros2-osx/setup.zsh &> /dev/null
}

# Custom Bindings
zle -N hcd
zle -N fvi
bindkey '^A' hcd
bindkey '^O' fvi
