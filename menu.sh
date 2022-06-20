showMenu(){

echo "-----------------"
echo "RED7 Install Menu"
echo "-----------------"
echo "[1] Install Yay (essential)"
echo "[2] Install Sublime Text 4"
echo "[3] Install Lutris"
echo "[4] Install Brave Browser"
echo "[5] Install p7zip"
echo "[6] Exit Install Menu"
echo "-----------------"

read -p "Please Select A Number: " mc
return $mc
}


while [[ "$m" != "6" ]]
do
    if [[ "$m" == "1" ]]; then
        echo "Installing Yay..."
        cd /opt
        sudo git clone https://aur.archlinux.org/yay-git.git
        sudo chown -R $USER:$USER ./yay-git
        cd yay-git
        makepkg -si
        echo "Installed Yay!"
    elif [[ "$m" == "2" ]]; then
        echo "Installing Sublime Text 4..."
        yay -S sublime-text-4
        echo "Installed Sublime Text 4!"
    elif [[ "$m" == "3" ]]; then
        echo "Installing Lutris..."
        sudo pacman -S lutris
        echo "Installed Sublime Text 4!"
    elif [[ "$m" == "4" ]]; then
        echo "Installing Brave Browser..."
        yay -S brave-bin
        echo "Installed Brave Browser!"
    elif [[ "$m" == "5" ]]; then
        echo "Installing p7zip..."
        sudo pacman -S p7zip
        echo "Installed p7zip!"
    fi
    showMenu
    m=$?
done

exit 0;