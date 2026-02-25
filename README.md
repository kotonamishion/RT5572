# RT5572
RT5572USB_WiFi在immortalwrt上的驱动
目前在用的immortalwrt系统是24.10.4.
一共要安装三个驱动包
内核驱动 (Kernel Module):kmod-rt2800-usb
固件文件 (Firmware):rt2800-usb-firmware
协议栈 (WPA/Encryption):必装： wpad-basic-mbedtls（或者 wpad-mesh-mbedtls）
原因：没有它，你的网卡能识别但永远无法成功连接带密码的 WiFi。


1. 驱动包的命名规律
OpenWrt 的包管理非常规范，无论是 ARM (R3s) 还是 x86，包名都是通用的：

驱动核心： kmod-rt2800-usb (负责让内核认出硬件)

固件文件： rt2800-usb-firmware (负责初始化硬件芯片)

协议支持： wpad-basic-mbedtls (负责 WPA2/WPA3 加密认证)

2. 关于 wpad 的选择
在 x86 这种性能比较强的设备上，如果你有更高级的需求，可以选择“增强版”：

wpad-basic-mbedtls：轻量级，适合大多数场景（你现在用的这个）。

wpad-mesh-mbedtls：如果你打算在 x86 上做 802.11s Mesh 组网，装这个。

wpad (全功能版)：支持企业级认证 (EAP/RADIUS)，如果你是在办公环境连接需要账号密码登录的 WiFi，选这个。

注意： 同一时间只能安装一个 wpad 变体。如果要换，记得先 opkg remove 掉旧的。

lsusb 命令查看你的usb wifi属于什么芯片。如果提示没安装。安装命令: opkg update && opkg install usbutils
