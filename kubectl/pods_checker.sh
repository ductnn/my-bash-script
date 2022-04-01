#!/usr/bin/env bash

# color
red="\033[1;31m"
green="\033[1;32m"
rescolor="\e[0m"

listPods=$(kubectl get po | awk 'NR>1{print $1}')

arr=()
while IFS=\n read pod
do
    arr+=($pod)
done <<< $listPods

ok=0
sml=0
echo -e "\nChecking ...\n"
for i in ${arr[@]}
do 
    echo -ne "$i ... " 
    status=$(kubectl get po $i | grep $i | awk '{print $3}')
        if [[ ! $status =~ ^Running$|^Completed$  ]]  ; then
            echo -e "\e[1;31mDuma !"$rescolor""
            let sml=sml+1
        else
            echo -e "\e[32m OK "$rescolor""
            let ok=ok+1
        fi
done

echo -e "\nSTATS:\n"
echo "+---------------+---------------+"
printf  "|$green%-15s$rescolor|$red%-15s$rescolor|\n" "Healthy Pods" "Unhealthy Pods"
echo "+---------------+---------------+"
printf  "|%-15s|%-15s|\n" "$ok" "$sml"
echo "+---------------+---------------+"
echo -e "\n"
