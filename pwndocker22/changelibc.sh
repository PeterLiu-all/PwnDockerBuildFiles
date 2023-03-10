#!/bin/bash

if [[ "$*" =~ "--help" ]] || [[ "$*" =~ "-h" ]];
then
    echo "【用法】$(basename $0) 程序文件名 ld名字 libc路径"
    echo "ld名字和libc路径如果不想改变可以用0、$、?、:四个分隔符代替"
    echo "如果不输入ld名字和libc路径，程序会在中途暂停并询问，如果直接回车就代表不改变该项"
    echo "注意ld名字是路径+名字，而libc路径是路径，不要加上libc的名字（如./libc/libc.so.6，不要写./libc/libc.so.6，写./libc）"
    echo "By PeterLiu"
    exit 0
fi
filename=$1
while [ -z $filename ];
do
    echo -n "请输入程序文件的路径："
    read filename
done
ldname=`ldd $filename | grep ld | awk -F '=>' '{print $2}' | awk -F '(' '{print $1}' | awk '$1=$1'`
libcname=`ldd $filename | grep libc | awk -F '=>' '{print $2}' | awk -F '(' '{print $1}' | awk '$1=$1'`
tmp=""
if [ -z "$2" ];
then
    echo -n "请输入ld的路径+名字（直接回车以跳过）："
    read tmp
    if [ -n tmp ];
    then
        patchelf --set-interpreter $tmp $filename
    else
        echo "不改变原有libc！"
    fi
else
    if [ "$2" == "0" ] || [ "$2" == "$" ] || [ "$2" == "?" ] || [ "$2" == ":" ];
    then
        echo "不改变原有ld！"
    else
        patchelf --set-interpreter $2 $filename
    fi
fi

if [ -z "$3" ];
then
    echo -n "请输入libc的路径，没有名字（直接回车以跳过）："
    read tmp
    if [ -n tmp ];
    then
        patchelf --set-rpath $tmp $filename
    else
        echo "不改变原有libc！"
    fi
else
    if [ "$3" == "0" ] || [ "$3" == "$" ] || [ "$3" == "?" ] || [ "$3" == ":" ];
    then
        echo "不改变原有libc！"
    else
        patchelf --set-rpath $3 $filename
    fi
fi

ldd $filename
