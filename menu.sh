# COLORS FOR TERMINAL (https://stackoverflow.com/a/28938235)
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

showMenu(){

echo -e "$Yellow----------------------------------"
echo -e "$BRed        RED7 Install Menu $Color_Off"
echo -e "$Yellow----------------------------------"
echo -e "$Blue[1]$Cyan Install Yay (essential)"
echo -e "$Blue[2]$Cyan Install Sublime Text 4"
echo -e "$Blue[3]$Cyan Install Lutris"
echo -e "$Blue[4]$Cyan Install Brave Browser"
echo -e "$Blue[5]$Cyan Install p7zip"
echo -e "$Blue[6]$Cyan Install QEMU/Virt Manager"
echo -e "$Blue[7]$Cyan Install DaVinci Resolve"
echo -e "$Blue[8]$Cyan Install OBS Studio"
echo -e "$Blue[9]$Cyan Fix Discover App"
echo -e "$Blue[10]$Cyan Install VLC Media Player"
echo -e "$Blue[11]$Cyan Install BleachBit"
echo -e "$Blue[12]$Cyan Fix Emojis"
echo -e "$Blue[13]$Cyan Exit Install Menu"
echo -e "$Yellow----------------------------------$Color_Off"

read -p "Please Select A Number: " mc
return $mc
}


while [[ "$m" != "13" ]]
do
    if [[ "$m" == "1" ]]; then
        echo -e "Installing Yay..."
        sudo pacman -S git
        cd /opt
        sudo git clone https://aur.archlinux.org/yay-git.git
        sudo chown -R $USER:$USER ./yay-git
        cd yay-git
        makepkg -si
        echo -e "Installed Yay!"
    elif [[ "$m" == "2" ]]; then
        echo -e "Installing Sublime Text 4..."
        yay -S sublime-text-4
        echo -e "Installed Sublime Text 4!"
    elif [[ "$m" == "3" ]]; then
        echo -e "Installing Lutris..."
        sudo pacman -S lutris
        echo -e "Installed Sublime Text 4!"
    elif [[ "$m" == "4" ]]; then
        echo -e "Installing Brave Browser..."
        yay -S brave-bin
        echo -e "Installed Brave Browser!"
    elif [[ "$m" == "5" ]]; then
        echo -e "Installing p7zip..."
        sudo pacman -S p7zip
        echo -e "Installed p7zip!"
    elif [[ "$m" == "6" ]]; then
        echo -e "Installing QEMU/Virt Manager..."
        sudo pacman -S qemu-base virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat libguestfs
        sudo echo 'unix_sock_group = "libvirt"' > /etc/libvirt/libvirtd.conf
        sudo echo 'unix_sock_ro_perms = "0777"' > /etc/libvirt/libvirtd.conf
        sudo echo 'unix_sock_rw_perms = "0770"' > /etc/libvirt/libvirtd.conf
        sudo systemctl start libvirtd
        sudo systemctl enable libvirtd
        sudo usermod -aG libvirt $USER
        echo -e "Installed QEMU/Virt Manager!"
    elif [[ "$m" == "7" ]]; then
        echo -e "Installing DaVinci Resolve..."
        sudo pacman -S davinci-resolve
        echo -e "Installed DaVinci Resolve!"
    elif [[ "$m" == "8" ]]; then
        echo -e "Installing OBS Studio..."
        sudo pacman -S obs-studio
        echo -e "Installed OBS Studio!"
    elif [[ "$m" == "9" ]]; then
        echo -e "Installing Package Kit for Qt 5..."
        sudo pacman -S packagekit-qt5
        echo -e "Installed Package Kit for Qt 5!"
    elif [[ "$m" == "10" ]]; then
        echo -e "Installing VLC Media Player..."
        sudo pacman -S vlc
        echo -e "Installed VLC Media Player!"
    elif [[ "$m" == "11" ]]; then
        echo -e "Installing BleachBit..."
        sudo pacman -S bleachbit
        echo -e "Installed BleachBit!"
    fi
    elif [[ "$m" == "11" ]]; then
        echo -e "Fixing emojis..."
        yes | sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra --no-confirm
        echo -e "Fixed emojis!"
    fi
    showMenu
    m=$?
done

exit 0;
