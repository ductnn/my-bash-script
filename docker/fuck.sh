# some commands
docker images --format '{{.ID}} => {{.Repository}}' | grep <XXX> | awk '{print $1}' ORS=' '
