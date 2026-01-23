#!/bin/bash

# Скрипт для автоматической настройки NVIDIA для Hyprland на Arch Linux
# Запускать от root после установки nvidia-dkms linux-headers nvidia-utils nvidia-settings
# Требует GRUB bootloader

set -euo pipefail

echo "Настройка NVIDIA для Hyprland..."

# 1. Модули в mkinitcpio.conf
if ! grep -q "nvidia.*nvidia_drm" /etc/mkinitcpio.conf; then
    sed -i '/^MODULES=/ s/()$/ (nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
    echo "✓ Модули добавлены в mkinitcpio.conf"
else
    echo "Модули уже настроены"
fi

# 2. Генерация initramfs
mkinitcpio -P
echo "✓ Initramfs сгенерирован"

# 3. Параметры GRUB
if ! grep -q "nvidia_drm.modeset=1" /etc/default/grub; then
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="nvidia_drm.modeset=1 /' /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
    echo "✓ Параметры GRUB обновлены"
else
    echo "Параметры GRUB уже настроены"
fi

# 4. modprobe.d/nvidia.conf
cat > /etc/modprobe.d/nvidia.conf << EOF
options nvidia-drm modeset=1
options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3"
EOF
echo "✓ /etc/modprobe.d/nvidia.conf создан (с отключением power management)"

# 5. Обновление systemd (для модулей)
depmod -a

echo "Настройка завершена! Перезагрузитесь: reboot"
echo "Проверьте после ребута: cat /sys/module/nvidia_drm/parameters/modeset (должно быть Y)"
