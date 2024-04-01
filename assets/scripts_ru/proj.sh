#!/bin/bash
if [ "$1" == "txt" ]; then
echo "Проект
Только на ПК
Дублирование
Расширение
Только второй экран"
exit
fi
p_disp=$(xrandr | grep -E '\b[[:alnum:]]+-[[:digit:]]+ connected primary' | awk '{print $1}')
s_disp=$(xrandr | grep -E '\b[[:alnum:]]+-[[:digit:]]+ connected [^p]' | awk '{print $1}')
if [ -n "$s_disp" ];then
if [ "$1" == "pconly" ];then xrandr --output $p_disp --auto --primary --output $s_disp --off;fi
if [ "$1" == "duplicate" ];then xrandr --output $p_disp --auto --primary --output $s_disp --auto --same-as eDP-1;fi
if [ "$1" == "expand" ];then xrandr --output $p_disp --auto --primary --output $s_disp --auto --left-of eDP-1;fi
if [ "$1" == "2ndonly" ];then xrandr --output $p_disp --off --output $s_disp --auto;fi
fi