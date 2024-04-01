#!/bin/bash
action1(){
night=("1:0.9:0.90" "1:0.9:0.85" "1:0.85:0.8" "1:0.80:0.75" "1:0.80:0.7" "1:0.75:0.65" "1:0.75:0.6" "1:0.75:0.55" "1:0.75:0.5" "1:0.75:0.4");nightb=("0.9" "0.9" "0.9" "0.8" "0.8" "0.8" "0.8" "0.7" "0.7" "0.7");day=("1:0.75:0.5" "1:0.75:0.55" "1:0.75:0.6" "1:0.75:0.65" "1:0.8:0.7" "1:0.8:0.75" "1:0.85:0.8" "1:0.9:0.85" "1:0.9:0.9" "1:1:1");dayb=("0.7" "0.7" "0.8" "0.8" "0.8" "0.8" "0.9" "0.9" "0.9" "1")
getbr(){ local v=$(xrandr --verbose | grep Brightness | cut -d ' ' -f 2 | head -n 1);echo "$v";}
apply(){ local mgam=("${!1}");local mbr=("${!2}");local condp=("${!3}")
for ((i=0;i<${#mgam[@]};i++));do cmd="";for d in "${condp[@]}";do cmd+=" --output $d --gamma ${mgam[$i]} --brightness ${mbr[$i]}";done;xrandr $cmd;done;}
vbr=$(getbr);if [ "$1" == "check" ];then if [ "$vbr" == "1.0" ];then echo 1;
elif [ "$vbr" == "0.70" ];then echo 0;fi;else condpl=($(xrandr | grep -E ' connected( primary)? [0-9]+x[0-9]+' | awk '{print $1}'))
if [ "$vbr" == "1.0" ];then apply night[@] nightb[@] condpl[@];else apply day[@] dayb[@] condpl[@];fi;fi
}

action2(){
radio="$(LC_MESSAGES=C nmcli radio all | awk 'FNR == 2 {print $2}')"
if [ "$1" == "check" ];then if [ "$radio" == "enabled" ];then echo 1;else echo 0;fi;
else if [ "$radio" == "enabled" ];then nmcli radio all off;else nmcli radio all on;fi;fi
}

action3(){
sleep 0.25;ksnapshot &
}

action4(){
touch /tmp/.enabkcontr.stp && kcontrol &
}

action5(){
wid=$(xdotool search --onlyvisible --class "networkmanager")
# eval $(xdotool getmouselocation --shell);rx=$((X + 8));ry=$((Y + 8))
eval $(xdotool getwindowgeometry --shell $wid)
xdotool mousemove $X $Y && xdotool click --window $wid 1
# xdotool mousemove $rx $ry
}

notif(){
maj=$(xdotool search --onlyvisible --class "updatemgr.exu")
if [ -n "$maj" ];then
echo "Updates werden durchgeführt..."
exit;fi
wid=$(xdotool search --onlyvisible --class "q4os-pkui")
if [ -n "$wid" ];then
echo "Updates sind verfügbar."
echo " "
echo "Sie können sie installieren, indem Sie auf"
echo "das Symbol des Update-Managers klicken"
echo "im Benachrichtigungsbereich der Taskleiste."
else
echo "Ihr System ist auf dem neuesten Stand."
fi
}

checkstates(){
action1 check
action2 check
notif
}

case "$1" in
1) action1 ;;
2) action2 ;;
3) action3 ;;
4) action4 ;;
5) action5 ;;
*) checkstates ;;
esac
exit
