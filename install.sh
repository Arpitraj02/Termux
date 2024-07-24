#!/bin/bash

# Function to install Ubuntu
install_ubuntu() {
    echo "Installing Ubuntu..."
    pkg update -y && pkg upgrade -y
    pkg install wget proot tar -y
    mkdir -p ~/ubuntu
    cd ~/ubuntu
    wget https://partner-images.canonical.com/core/bionic/current/ubuntu-bionic-core-cloudimg-armhf-root.tar.gz
    proot --link2symlink tar -xf ubuntu-bionic-core-cloudimg-armhf-root.tar.gz
    cat > start-ubuntu.sh <<- EOM
#!/bin/bash
unset LD_PRELOAD
proot --link2symlink -0 -r ~/ubuntu -b /dev/ -b /proc/ -b /sys/ -b /data/data/com.termux/files/home -w /root /usr/bin/env -i HOME=/root TERM=\$TERM PS1='\\w # ' /bin/bash --login
EOM
    chmod +x start-ubuntu.sh
    echo "Ubuntu installation complete. You can start Ubuntu with the ./start-ubuntu.sh script."
}

# Function to install Debian
install_debian() {
    echo "Installing Debian..."
    pkg update -y && pkg upgrade -y
    pkg install wget proot tar -y
    mkdir -p ~/debian
    cd ~/debian
    wget https://raw.githubusercontent.com/sp4rkie/debian-on-termux/master/debian_on_termux.sh
    bash debian_on_termux.sh
    cat > start-debian.sh <<- EOM
#!/bin/bash
unset LD_PRELOAD
proot --link2symlink -0 -r ~/debian -b /dev/ -b /proc/ -b /sys/ -b /data/data/com.termux/files/home -w /root /usr/bin/env -i HOME=/root TERM=\$TERM PS1='\\w # ' /bin/bash --login
EOM
    chmod +x start-debian.sh
    echo "Debian installation complete. You can start Debian with the ./start-debian.sh script."
}

# Function to install Arch Linux
install_arch() {
    echo "Installing Arch Linux..."
    pkg update -y && pkg upgrade -y
    pkg install wget proot tar -y
    mkdir -p ~/arch
    cd ~/arch
    wget https://raw.githubusercontent.com/sdrausty/termux-archlinux/master/setupTermuxArch.sh
    bash setupTermuxArch.sh
    cat > start-arch.sh <<- EOM
#!/bin/bash
unset LD_PRELOAD
proot --link2symlink -0 -r ~/arch -b /dev/ -b /proc/ -b /sys/ -b /data/data/com.termux/files/home -w /root /usr/bin/env -i HOME=/root TERM=\$TERM PS1='\\w # ' /bin/bash --login
EOM
    chmod +x start-arch.sh
    echo "Arch Linux installation complete. You can start Arch Linux with the ./start-arch.sh script."
}

# ASCII Art
cat << "EOF"
 _                       _   __  __                     
| |    ___   __ _  __ _| | |  \/  | ___  _ __   __ _ 
| |   / _ \ / _` |/ _` | | | |\/| |/ _ \| '_ \ / _` |
| |__| (_) | (_| | (_| | | | |  | | (_) | | | | (_| |
|_____\___/ \__, |\__,_|_| |_|  |_|\___/|_| |_|\__, |
            |___/                             |___/ 
EOF

echo ""
echo "Welcome to the Linux Distro Installer for Termux"
echo "----------------------------------------------"
echo "Please choose a distribution to install:"
echo "1) Ubuntu"
echo "2) Debian"
echo "3) Arch Linux"
echo "4) Exit"

# Read user choice
read -p "Enter your choice [1-4]: " choice

case $choice in
    1)
        install_ubuntu
        ;;
    2)
        install_debian
        ;;
    3)
        install_arch
        ;;
    4)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice. Please run the script again and choose a valid option."
        exit 1
        ;;
esac
