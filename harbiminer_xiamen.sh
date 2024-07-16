#!/bin/bash

# 检查是否以root用户运行脚本
if [ "$(id -u)" != "0" ]; then
    echo "此脚本需要以root用户权限运行。"
    echo "请尝试使用 'sudo -i' 命令切换到root用户，然后再次运行此脚本。"
    exit 1
fi

# 获取 CPU 核心总数
cpu_cores=$(grep -c ^processor /proc/cpuinfo)

# 计算 90% 的核心数
cpu_cores_90=$(echo "$cpu_cores * 0.9" | bc)

# 取整，舍弃小数部分
cpu_cores_90=$(printf "%.0f" $cpu_cores_90)

echo "CPU 核心总数: $cpu_cores"
echo "90% 的 CPU 核心数: $cpu_cores_90"

nohup /root/harbi/harbiminer --miningaddr=harbi:qr4wu7cyx26zgjyyj6jw2nlz9vlxlyxufs8rwuy4ty9v9ftp23dxzy7r3gep3 --rpcserver=192.168.0.52:24110 --workers=$cpu_cores_90 >/root/harbi/harbiminer-`date +%Y-%m-%d`.log  2>&1 &

echo "[`date '+%Y-%m-%d %H:%M:%s'`] harbiminer started"