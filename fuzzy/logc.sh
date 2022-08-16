#!/bin/bash

logc() {
  export FZF_DEFAULT_OPTS='--height 90% --reverse --border'
  container=$(docker ps --format '{{.ID}} => {{.Names}}:{{.Image}}' | fzf-tmux --reverse --multi | awk -F '\\=>' '{print $1}')

  if [[ $container != '' ]]; then
    echo -e "\n  \033[1mDocker image:\033[0m" $container

    # if [[ $@ == '' ]]; then
	# 	read -e -p $'  \e[1mCommand: \e[0m' cmd
    # else
	# 	cmd="$@"
    # fi
    echo ''
    history -s logc "$@"
    history -s docker logs -f $container
    docker logs -f $container
    echo ''
  fi
  export FZF_DEFAULT_OPTS=""

}

logc
