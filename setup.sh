#!/bin/bash

# Atualizar o sistema
sudo apt-get update -y
sudo apt-get upgrade -y

# Abrir portas
sudo iptables -I INPUT -m state --state NEW -p tcp --dport 3389 -j ACCEPT
sudo iptables -I INPUT -m state --state NEW -p udp --dport 3389 -j ACCEPT
sudo iptables -I INPUT -m state --state NEW -p tcp --dport 3399 -j ACCEPT
sudo iptables -I INPUT -m state --state NEW -p udp --dport 3399 -j ACCEPT

# Configurar o swap
sudo fallocate -l 10G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

# Adicionar swap ao /etc/fstab
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Instalar LXDE e XRDP
sudo apt-get install lxde xrdp -y

# Configurar senha do usuário automaticamente
echo -e "41258\n41258" | sudo passwd ubuntu

# Habilitar o serviço XRDP para iniciar com o sistema
sudo systemctl enable xrdp

# Reiniciar o serviço XRDP para aplicar as configurações
sudo systemctl restart xrdp
