# color
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[0;33m"
blue="\033[0;34m"
bwhite="\033[1;37m"

no_color="\033[0m"

declare -a __questions=("SURE ???"
                "REALLY ???"
                "DEO ROLLBACK DUOC DAU"
                "DIT ME MAY CHAC K ???"
                "BINH TINH BAN EI"
                )


# max deep = 3
if [ "$SFRM_MAX" = "" ]; then
    __deep=3
else
    __deep=${SFRM_MAX}
fi


# exit
__exit() {
    if [ "$1" = "n" -o "$1" = "N" ]; then
        echo "${green}You are safe now !!!${no_color}"
        exit 1
    else
        return
    fi
}


# print questions
__challenge() {
    counter=${__deep}
    until [ ${counter} -lt 1 ]; do
        index=$(($RANDOM % ${#__questions[@]}))
        echo "${green}>${no_color} ${red}${__questions[$index]}${no_color} ${yellow}[y/N]:${no_color}"
        read ans

        __exit "$ans"

        let counter-=1
    done
}


echo "\n"
__challenge
rm $@
echo "\n"
echo "${blue}DIT CU MAY XONG R DAY !!!${no_color}"
