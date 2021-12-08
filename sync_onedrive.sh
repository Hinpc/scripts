#!/bin/sh

backup_file() {
    source_path=$1
    if [ -f "$source_path" ]; then
        cp $( eval echo "$source_path" ) $( eval echo "$source_path.bak" )
    fi
}

# 同步 sshconfig 到 onedrive
sshconfg_od_path="$HOME/OneDrive/my_sync/sync_config_file_by_script/ssh"
sshconfg_to_od() {

    target_file="$sshconfg_od_path/config.txt"

    backup_file $target_file

    if [ ! -d "$target_path"]; then
        mkdir -p "$target_path"
    fi

    cp $( eval echo $HOME/.ssh/config ) $( eval echo "$target_file" )
}

# 同步 sshconfig 到 本地
sshconfig_to_local() {
    target_path="$HOME/.ssh"
    target_file="$target_path/config"

    backup_file $target_file

    cp $( eval echo "$sshconfg_od_path/config.txt" ) $( eval echo "$target_file" )
}

main() {

    echo "同步方式: \n【1】本地到onedrive 【2】onedrive到本地\n"
    read -p "choice: " sync_method

    if [[ $sync_method == "1" ]]; then
        echo "\n\n\n即将同步任务：\n "
        echo "sshconfg_to_od \n "
        read -p "确认执行请输入【y】: " confirm_str
        if [[ $confirm_str == "y" ]]; then
            sshconfg_to_od
        else
            exit 1
        fi
    fi

    #===================

    if [[ $sync_method == "2" ]]; then
        echo "\n\n\n即将同步任务：\n "
        echo "sshconfig_to_local \n "
        read -p "确认执行请输入【y】: " confirm_str
        if [[ $confirm_str == "y" ]]; then
            sshconfig_to_local
        else
            exit 1
        fi
    fi
}

main
