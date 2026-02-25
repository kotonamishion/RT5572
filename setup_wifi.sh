#!/bin/sh
# OpenWrt USB WiFi 一键环境配置脚本 (2026版)

echo "--- 1. 开始更新软件源 ---"
opkg update

echo "--- 2. 安装基础依赖与工具 (lsusb/iwinfo/wpad) ---"
# wpad-basic-mbedtls 是解决“未关联”的核心
opkg install lsusb iwinfo wpad-basic-mbedtls

echo "--- 3. 安装主流驱动包 (包含 RT5572, MT7612U, MT7921U) ---"
# 这里涵盖了你现在的 RT5572 和我推荐给你的 MTK 系列
DRIVERS="kmod-rt2800-usb rt2800-usb-firmware \
         kmod-mt76x2u mt76x2u-firmware \
         kmod-mt7921u mt7921u-firmware"

for pkg in $DRIVERS; do
    echo "正在安装: $pkg ..."
    opkg install $pkg
done

echo "--- 4. 激活无线网卡配置 ---"
# 自动将配置文件中的 disabled 设为 0 (启用)
if [ -f /etc/config/wireless ]; then
    sed -i "s/option disabled '1'/option disabled '0'/g" /etc/config/wireless
    wifi
    echo "无线服务已重启。"
else
    echo "未发现无线配置文件，请尝试插拔网卡或运行 'wifi detect > /etc/config/wireless'。"
fi

echo "--- 配置完成！ ---"
echo "你可以运行 'lsusb' 查看硬件，运行 'iwinfo' 查看信号。"
