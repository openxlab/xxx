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
