#!/bin/bash

echo "Start Builder Patch !"
echo "Current Path: $PWD"

cd $GITHUB_WORKSPACE/$VENDOR-imagebuilder-$VERSION-x86-64.Linux-x86_64 || exit

# Remove redundant default packages
sed -i "/luci-app-cpufreq/d" include/target.mk

# Force opkg to overwrite files
sed -i "s/install \$(BUILD_PACKAGES)/install \$(BUILD_PACKAGES) --force-overwrite/" Makefile

# Not generate ISO images for it is too big
sed -i "s/CONFIG_ISO_IMAGES=y/# CONFIG_ISO_IMAGES is not set/" .config

# Not generate VHDX images
sed -i "s/CONFIG_VHDX_IMAGES=y/# CONFIG_VHDX_IMAGES is not set/" .config

sed -i "s/CONFIG_PACKAGE_luci-app-filetransfer=y/# CONFIG_PACKAGE_luci-app-filetransfer is not set/" .config
sed -i "s/CONFIG_PACKAGE_luci-app-filetransfer-zh-cn=y/# CONFIG_PACKAGE_luci-app-filetransfer-zh-cn is not set/" .config
sed -i "s/CONFIG_PACKAGE_luci-app-turboacc=y/# CONFIG_PACKAGE_luci-app-turboacc is not set/" .config
sed -i "s/CONFIG_PACKAGE_luci-app-turboacc-zh-cn=y/# CONFIG_PACKAGE_luci-app-turboacc-zh-cn is not set/" .config

# 固件大小
#sed -i "s/CONFIG_TARGET_KERNEL_PARTSIZE=32/CONFIG_TARGET_KERNEL_PARTSIZE=80/" .config
#sed -i "s/CONFIG_TARGET_ROOTFS_PARTSIZE=160/CONFIG_TARGET_ROOTFS_PARTSIZE=600/" .config
