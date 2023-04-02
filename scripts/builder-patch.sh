#!/bin/bash

echo "Start Builder Patch !"
echo "Current Path: $PWD"

cd $GITHUB_WORKSPACE/$VENDOR-imagebuilder-$VERSION-x86-64.Linux-x86_64 || exit

## 酷友社开发的Openwrt插件：DDNSTO远程穿透、易有云存储端、iStore、QuickStart便捷首页
svn co https://github.com/xiangfeidexiaohuo/openwrt-packages/trunk/linkease package/linkease

# Remove redundant default packages
sed -i "/luci-app-cpufreq/d" include/target.mk
sed -i "/luci-app-filetransfer/d" include/target.mk
sed -i "/luci-app-turboacc/d" include/target.mk
sed -i "/automount/d" target/linux/x86/Makefile

#修改密码
sed -i 's/root::0:0:99999:7:::/root:$1$RsaPwq.4$jAo1CF8KJW5fZjY4uSd7f1:19449:0:99999:7:::/g' package/base-files/files/etc/shadow

# Force opkg to overwrite files
sed -i "s/install \$(BUILD_PACKAGES)/install \$(BUILD_PACKAGES) --force-overwrite/" Makefile

# Not generate ISO images for it is too big
sed -i "s/CONFIG_ISO_IMAGES=y/# CONFIG_ISO_IMAGES is not set/" .config

# Not generate VHDX images
sed -i "s/CONFIG_VHDX_IMAGES=y/# CONFIG_VHDX_IMAGES is not set/" .config

# 固件大小
#sed -i "s/CONFIG_TARGET_KERNEL_PARTSIZE=32/CONFIG_TARGET_KERNEL_PARTSIZE=80/" .config
#sed -i "s/CONFIG_TARGET_ROOTFS_PARTSIZE=160/CONFIG_TARGET_ROOTFS_PARTSIZE=600/" .config
