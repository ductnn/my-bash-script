#!/bin/bash

ipc() {
  export FZF_DEFAULT_OPTS='--height 90% --reverse --border'
  container=$(docker ps --format '{{.ID}} => {{.Names}}:{{.Image}}' | fzf-tmux --reverse --multi | awk -F '\\=>' '{print $1}')

  if [[ $container != '' ]]; then
    network=$(docker inspect $container -f '{{.NetworkSettings.Networks}}' | awk -F 'map\\[|:' '{print $2}')
    echo -e "\n  \033[1mDocker container:\033[0m" $container
    history -s ipc
    history -s docker inspect -f "{{.NetworkSettings.Networks.${network}.IPAddress}}" $container
    echo -e "  \033[1mNetwork:\033[0m" $network
    echo -e "  \033[1mIP Address:\033[0m" $(docker inspect -f "{{.NetworkSettings.Networks.${network}.IPAddress}}" $container) "\n"
  fi
  export FZF_DEFAULT_OPTS=""

}

ipc
