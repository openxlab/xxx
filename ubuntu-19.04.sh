
iso_name=ubuntu-19.04-desktop-amd64.iso
vm_name=ubuntu
sudo qemu-img create -f qcow2 /var/lib/libvirt/images/${vm_name}.qcow2 24G
virt-install --connect qemu:///system --name ${vm_name} \
  --virt-type=kvm --memory 16384 --vcpus sockets=2,cores=4,threads=1 \
  --network network=br-ex,model=virtio \
  --network network=br-ex,model=virtio \
  --disk path=/var/lib/libvirt/images/${iso_name},device=cdrom \
  --disk path=/var/lib/libvirt/images/${vm_name}.qcow2,format=qcow2,device=disk,bus=virtio \
  --accelerate --hvm --cpu IvyBridge,+vmx \
  --os-type linux --os-variant ubuntu19.04 \
  --boot cdrom --noautoconsole


nmtui
sudo nmcli connection modify "有线连接 1" +ipv4.addresses "10.42.166.173/24"
sudo nmcli connection modify "有线连接 1" +ipv4.routes "10.43.133.0/24 10.42.166.1"

echo "labx ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/labx
sudo chmod 0440 /etc/sudoers.d/labx

echo 'Acquire::http::Proxy "http://192.168.100.1:80";' | sudo tee /etc/apt/apt.conf
sudo apt update
sudo apt upgrade -y
sudo apt install openssh-server -y

sudo apt install xrdp gnome-tweak-tool -y
export http_proxy="http://192.168.100.1:80"
export https_proxy="http://192.168.100.1:80"
sudo add-apt-repository ppa:guacamole/stable
sudo apt install guacamole xrdp-pulseaudio-installer -y

sudo sed -i 's/SendEnv/# SendEnv/' /etc/ssh/ssh_config
sudo sed -i 's/allowed_users=console/allowed_users=anybody/' /etc/X11/Xwrapper.config
sudo bash -c "cat >/etc/polkit-1/localauthority/50-local.d/45-allow.colord.pkla" <<EOF
[Allow Colord all Users]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device;org.freedesktop.color-manager.create-profile;org.freedesktop.color-manager.delete-device;org.freedesktop.color-manager.delete-profile;org.freedesktop.color-manager.modify-device;org.freedesktop.color-manager.modify-profile
ResultAny=no
ResultInactive=no
ResultActive=yes
EOF
sudo sed -i.org "4 a #fixGDM-by-Griffon\ngnome-shell-extension-tool -e ubuntu-appindicators@ubuntu.com\ngnome-shell-extension-tool -e ubuntu-dock@ubuntu.com\n\nif [ -f ~/.xrdp-fix-theme.txt ]; then\necho 'no action required'\nelse\ngsettings set org.gnome.desktop.interface gtk-theme 'Yaru'\ngsettings set org.gnome.desktop.interface icon-theme 'Yaru'\necho 'check file for xrdp theme fix' >~/.xrdp-fix-theme.txt\nfi\n" /etc/xrdp/startwm.sh

curl -x http://192.168.100.1:80 -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
google-chrome --incognito --proxy-server="http://192.168.100.1:80"

sudo apt-cache madison filezilla
sudo apt install filezilla -y

curl -x http://192.168.100.1:80 -k -O https://download.virtualbox.org/virtualbox/6.0.6/virtualbox-6.0_6.0.6-130049~Ubuntu~bionic_amd64.deb
curl -x http://192.168.100.1:80 -k -O https://download.virtualbox.org/virtualbox/6.0.6/Oracle_VM_VirtualBox_Extension_Pack-6.0.6.vbox-extpack
sudo apt install 

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
sudo add-apt-repository "deb https://download.virtualbox.org/virtualbox/debian disco contrib"
curl -x http://192.168.100.1:80 -O https://www.virtualbox.org/download/oracle_vbox_2016.asc
curl -x http://192.168.100.1:80 -O https://www.virtualbox.org/download/oracle_vbox.asc
sudo apt-key add oracle_vbox_2016.asc
sudo apt-key add oracle_vbox.asc
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo apt-key del oracle_vbox_2016.asc
sudo apt-key del oracle_vbox.asc
sudo apt-key list
sudo apt-get update
sudo apt-get install virtualbox-6.0 -y

curl -x http://192.168.100.1:80 -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/"
sudo apt install sublime-text
curl -x http://192.168.100.1:80 -fsSL -O https://raw.githubusercontent.com/cipherhater/CipherHater/master/sublime_patch.sh
sudo chmod +x ./sublime_patch.sh
sudo ./sublime_patch.sh
cat <<-EOF |sudo tee -a /etc/hosts
0.0.0.0 www.sublimemerge.com
0.0.0.0 sublimemerge.com
0.0.0.0 www.sublimetext.com
0.0.0.0 sublimetext.com
0.0.0.0 sublimehq.com
0.0.0.0 telemetry.sublimehq.com
0.0.0.0 license.sublimehq.com
0.0.0.0 download.sublimetext.com
0.0.0.0 download.sublimemerge.com
EOF

— BEGIN LICENSE —–
Free World User
00 User License
HK3B-100025
1D77F72E 390CDD93 4DCBA022 FAF60790
61AA12C0 A37081C5 D0316412 4584D136
94D7F7D4 95BC8C1C 527DA828 560BB037
D1EDDD8C AE7B379F 50C9D69D B35179EF
2FE898C4 8E4277A8 555CE714 E1FB0E43
D5D52613 C3D12E98 BC49967F 7652EED2
9D2D2E61 67610860 6D338B72 5CF95C69
E36B85CC 84991F19 7575D828 470A92AB
—— END LICENSE ——

sudo ufw insert 1 deny out to 45.55.255.55/32 comment 'Sublime out Host-1'
sudo ufw insert 2 deny in to 45.55.255.55/32 comment 'Sublime in Host-1'
sudo ufw insert 3 deny out to 45.55.41.223/32 comment 'Sublime out Host-2'
sudo ufw insert 4 deny in to 45.55.41.223/32 comment 'Sublime in Host-2'
sudo ufw insert 5 deny out to 209.20.83.249/32 comment 'Sublime out Host-3'
sudo ufw insert 6 deny in to 209.20.83.249/32 comment 'Sublime in Host-3'
sudo ufw insert 7 deny out to 104.236.0.104/32 comment 'Sublime out Host-4'
sudo ufw insert 8 deny in to 104.236.0.104/32 comment 'Sublime in Host-4'
sudo apt install iptables-persistent
sudo dpkg-reconfigure iptables-persistent
sudo ufw status numbered verbose


curl -x http://192.168.100.1:80 -O http://ftp.barfooze.de/pub/sabotage/tarballs/proxychains-ng-4.14.tar.xz
xz -d proxychains-ng-4.14.tar.xz
tar xvf proxychains-ng-4.14.tar
cd proxychains-ng-4.14/
./configure
make
sudo make install
sudo make install-config
sudo sed -i 's/^socks4.*/http  10.3.76.12  80/' /usr/local/etc/proxychains.conf

proxychains4  -q /bin/bash

chmod 400 ubuntu.pem
proxychains4 ssh -i ubuntu.pem ubuntu@54.193.123.217

sudo apt install default-jdk -y
sudo apt install icedtea-netx -y
javac -version



==Server====================================================
sudo bash -c "cat > /etc/netplan/01-netcfg.yaml" <<EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    ens12f0:
      dhcp4: false
    ens12f1:
      dhcp4: false
  bridges:
    br-ex:
      interfaces: [ens12f0]
      addresses:
        - 192.168.100.109/24
        - 10.42.166.189/24
      gateway4: 192.168.100.1
      routes:
        - to: 10.43.133.0/24
          via: 10.42.166.1
          metric: 100
      nameservers:
        addresses:
          - "192.168.100.253"
      parameters:
        forward-delay: 0
    br-bmc:
      interfaces: [ens12f1]
      addresses: [ 192.168.70.19/24 ]
EOF

sudo netplan apply
sudo ip route add 10.43.133.0/24 via 10.42.166.1 dev br-ex

sudo rm /etc/resolv.conf
sudo ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf

echo "labx ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/labx
sudo chmod 0440 /etc/sudoers.d/labx

echo 'Acquire::http::Proxy "http://192.168.100.1:80";' | sudo tee /etc/apt/apt.conf
sudo apt update
sudo apt upgrade -y


sudo cat /proc/cpuinfo | egrep "vmx|svm"
cat /sys/module/kvm_intel/parameters/nested
echo 'net.ipv4.ip_forward=1' | sudo tee -a /etc/sysctl.conf
cat /proc/sys/net/ipv4/ip_forward

sudo apt install -y qemu-kvm libvirt-clients libvirt-daemon-system virtinst bridge-utils virt-manager libguestfs-tools libosinfo-bin
sudo apt install -y openvswitch-switch
###sudo adduser $USER libvirt
sudo adduser $USER libvirt-qemu
sudo kvm-ok
sudo reboot

sudo virt-host-validate
sudo osinfo-query os

brctl show
virsh net-list
virsh net-destroy default
virsh net-undefine default

virsh net-define /dev/stdin <<EOF
<network>
  <name>br-ex</name>
  <bridge name="br-ex" />
  <forward mode="bridge"/>
</network>
EOF
virsh net-autostart br-ex
virsh net-start br-ex

virsh net-define /dev/stdin <<EOF
<network>
  <name>br-bmc</name>
  <bridge name="br-bmc" />
  <forward mode="bridge"/>
</network>
EOF
virsh net-autostart br-bmc
virsh net-start br-bmc

sudo ovs-vsctl add-br br-ovc
virsh net-define /dev/stdin <<EOF
<network>
   <name>br-ovcplane</name>
   <forward mode='bridge'/>
   <bridge name="br-ovc" />
   <virtualport type='openvswitch'/>
   <portgroup name='ovc'>
     <vlan trunk='yes'>
       <tag id='100' nativeMode='untagged'/>
       <tag id='10'/>
       <tag id='20'/>
       <tag id='30'/>
       <tag id='40'/>
       <tag id='50'/>
       <tag id='60'/>
     </vlan>
   </portgroup>
</network>
EOF
virsh net-autostart br-ovcplane
virsh net-start br-ovcplane
ovs-vsctl add-port br-ovc NIC1

sudo apt install -y ntpdate ntp
sudo ntpdate 10.30.1.105
sudo sed -i 's/0.ubuntu.pool.ntp.org/10.30.1.105/' /etc/ntp.conf
sudo sed -i '/1.ubuntu.pool.ntp.org/d' /etc/ntp.conf
sudo sed -i '/2.ubuntu.pool.ntp.org/d' /etc/ntp.conf
sudo sed -i '/3.ubuntu.pool.ntp.org/d' /etc/ntp.conf
sudo systemctl restart ntp
sudo ntpq -p
sudo timedatectl

curl -O http://192.168.100.99:8080/vmw/ubuntu-18.04.2-server-amd64.iso


iso_name=ubuntu-18.04.2-server-amd64.iso
vm_name=ubuntus-18.04
sudo qemu-img create -f qcow2 /var/lib/libvirt/images/${vm_name}.qcow2 4G
virt-install --connect qemu:///system --name ${vm_name} \
  --virt-type=kvm --memory 16384 --vcpus sockets=2,cores=4,threads=1 \
  --network network=br-ex,model=virtio \
  --network network=br-ex,model=virtio \
  --disk path=/var/lib/libvirt/images/${vm_name}.qcow2,format=qcow2,device=disk,bus=virtio \
  --cdrom /var/lib/libvirt/images/${iso_name} \
  --accelerate --hvm --cpu IvyBridge,+vmx \
  --os-type linux --os-variant ubuntu18.04 \
  --boot menu=on --noautoconsole

vm_image=ubuntus-18.04.qcow2
vm_name=ubuntus-18.04
export LIBGUESTFS_DEBUG=1 LIBGUESTFS_TRACE=1
sudo qemu-img create -f qcow2 /var/lib/libvirt/images/${vm_name}.qcow2 100G
sudo virt-resize --expand /dev/sda1 ${vm_image} /var/lib/libvirt/images/${vm_name}.qcow2
sudo virt-customize -a /var/lib/libvirt/images/${vm_name}.qcow2 \
  --run-command 'lvextend -l +100%FREE /dev/ubuntu-vg/root' \
  --run-command 'xfs_growfs /'
virt-install --connect qemu:///system --name ${vm_name} --import \
  --virt-type=kvm --memory 16384 --vcpus sockets=2,cores=4,threads=1 \
  --network network=br-ex,model=virtio \
  --network network=br-ex,model=virtio \
  --disk path=/var/lib/libvirt/images/${vm_name}.qcow2,format=qcow2,device=disk,bus=virtio \
  --accelerate --hvm --cpu IvyBridge,+vmx \
  --os-type linux --os-variant ubuntu18.04 \
  --boot menu=on --noautoconsole

sudo virt-filesystems --partitions --long -a ubuntus-18.04.qcow2
