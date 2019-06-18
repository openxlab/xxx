sudo apt update
sudo apt list --upgradable
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt install -y python-pip
pip --version


sudo pip install shadowsocks
sudo sed -i 's/cleanup/reset/' /usr/local/lib/python2.7/dist-packages/shadowsocks/crypto/openssl.py
sudo /usr/bin/python /usr/local/bin/ssserver -s 0.0.0.0 -p 9443 -k sss2019 -m aes-256-cfb --user nobody -d start &


sudo echo "net.core.default_qdisc=fq" | sudo tee --append /etc/sysctl.conf
sudo echo "net.ipv4.tcp_congestion_control=bbr" | sudo tee --append /etc/sysctl.conf
sudo sysctl -p
sudo sysctl net.ipv4.tcp_available_congestion_control
sudo lsmod | grep bbr

curl -sL -O https://github.com/Wind4/vlmcsd/releases/download/svn1112/binaries.tar.gz
tar -xvf binaries.tar.gz
chmod u+x ./binaries/Linux/intel/static/vlmcsd-x64-musl-static
./binaries/Linux/intel/static/vlmcsd-x64-musl-static

sudo apt-get install -y unzip
curl -L -s -O https://github.com/v2ray/v2ray-core/releases/download/v4.9.0/v2ray-linux-64.zip
mkdir -p ~/v2ray
sudo unzip v2ray-linux-64.zip -d ~/v2ray
sudo chmod +x ~/v2ray/v2ray
sudo chmod +x ~/v2ray/v2ctl
sudo cp ~/v2ray/vpoint_vmess_freedom.json ~/v2ray/vmess_config.json
sudo sed -i "s/10086/10886/g" ~/v2ray/vmess_config.json
UUID=$(cat /proc/sys/kernel/random/uuid)
sudo sed -i "s/23ad6b10-8d1a-40f7-8ad0-e3e35cd38297/${UUID}/g" ~/v2ray/vmess_config.json
export PATH=$PATH:~/v2ray
sudo ~/v2ray/v2ray -config ~/v2ray/vmess_config.json &
