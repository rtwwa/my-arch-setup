#!/bin/bash
set -e

echo "[*] Обновление системы"
sudo pacman -Syu --noconfirm

echo "[*] Установка основных пакетов"
xargs -a packages.txt sudo pacman -S --noconfirm

echo "[*] Проверка yay"
if ! command -v yay &> /dev/null; then
  echo "[*] Установка yay"
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
fi

echo "[*] Установка AUR пакетов"
xargs -a aur-packages.txt yay -S --noconfirm

echo "[*] Копирование конфигов"
cp -r ./configs/hypr ~/.config/hypr