#!/bin/bash

# get all running docker container names
containers=$(sudo docker ps | awk '{if(NR>1) print $NF}')
host=$(hostname)

# loop through all containers
for container in $containers
do
  echo ======== Container: $container ========
  # echo "  Container: $container"
  percentages=($(sudo docker exec $container /bin/sh -c "df -h | grep -vE '^Filesystem|shm|boot' | awk '{ print +\$5 }'"))
  mounts=($(sudo docker exec $container /bin/sh -c "df -h | grep -vE '^Filesystem|shm|boot' | awk '{ print \$6 }'"))

  for index in ${!mounts[*]}; do
    echo "  Mount ${mounts[index]}: ${percentages[index]}%"

    if (( ${percentages[index]} > 70 )); then
      message="[ERROR] At $host and Docker container $container the mount ${mounts[index]} is at ${percentages[index]}% of its disk space. Please check this."
      echo $message
      echo $message | mail -s "Docker container $container at $host is out of disk space" "ductn53@gmail.com"
    fi

  done
  echo ============= END =============
  echo -e "\n"
done
