#!/bin/bash

# Definir DEBIAN_FRONTEND como noninteractive para evitar janelas interativas
export DEBIAN_FRONTEND=noninteractive

# Atualizar o sistema sem interações
sudo apt-get update -y
sudo apt-get -yq upgrade

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
sudo apt-get install lxde xrdp -yq

# Definir a senha padrão numérica de 8 dígitos
SENHA="12545412"

# Configurar senha do usuário automaticamente
echo -e "$SENHA\n$SENHA" | sudo passwd ubuntu

# Habilitar o serviço XRDP para iniciar com o sistema
sudo systemctl enable xrdp

# Reiniciar o serviço XRDP para aplicar as configurações
sudo systemctl restart xrdp

# Mensagem de sucesso e exibição do IP público
echo -e "\n\nINSTALADO COM SUCESSO\n"
echo "  _____ __  __  _____  _    _ "
echo " |_   _|  \/  |/ ____|| |  | |"
echo "   | | | \  / || (___  | |__| |"
echo "   | | | |\/| |\___ \ |  __  |"
echo "  _| |_| |  | |____) || |  | |"
echo " |_____|_|  |_|_____/ |_|  |_|"
echo -e "\n\nseu usuario: ubuntu\nsenha: $SENHA\n\nAcesse a conexão remota com o IP público abaixo:\n"

# Exibir o IP público da máquina
IP_PUBLICO=$(curl -s ifconfig.me)
echo "IP público da máquina: $IP_PUBLICO"
