# dotfiles
My dotfiles.

Package Manager:
I'm using the `paru` package manager, which can be obtained [here](https://github.com/Morganamilo/paru).

PACKAGE NAME(S)                     | PURPOSE
------------------------------------|-----------------------------------------
xorg-server xorg-xinit              | Display server and initialization
i3-wm                               | Window manager
neovim                              | Text editor
git                                 | Version Control
noto-fonts                          | Fonts
network-manager-applet              | Network management
zsh (zsh-autosuggestions)           | Shell
adwaita-dark                        | GUI theme
alacritty                           | Terminal
ttf-meslo-nerd-font-powerlevel10k   | Terminal font
polybar                             | Window manager bar
ttf-font-awesome-5                  | Font for icons on polybar
playerctl                           | Control media players
xbindkeys                           | Keybindings
picom                               | Compositing
redshift                            | Manage screen light temperature
backlight-control                   | Set screen light
xorg-xrandr (arandr autorandr)      | Configure screen's properties
rofi                                | Command launching and others
touchegg (touche)                   | Movement commands
dunst                               | Notification daemon
pulseaudio pulseaudio-alsa          | Sound server
flameshot                           | Screenshots
pulsemixer (pulseaudio-control)     | Sound CLI management
pulseaudio-bluetooth                | Sound for bluetooth
bluez bluez-utils (blueman)         | Bluetooth management
fprintd                             | Fingerprint reading
brave(-bin)                         | Web bowser
evince                              | Pdf viewer
libreoffice                         | General file editing
feh                                 | Image viewer
mpv                                 | Media player
thunderbird                         | Email client
git-credential-manager              | Git credential management        
openssh                             | ---                              
ripgrep                             | ---                              
fd                                  | ---                              
discord                             | ---                              
spotify                             | ---                              
todoist-appimage                    | ---                              
alsa-utils                          | ---                              

## Extra Configuration

### Zsh

Execute

```
sh -c "$(curl -fsSl https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

to, respectively, install `oh-my-zsh`, `powerlevel10k` and the `zsh-autosuggestions` plugin.

### Neovim

Execute 

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

to install `vim-plug` as a plugin manager for neovim.

Note that `fd` and `ripgrep` are dependencies for `telescope`, `ttf-meslo-nerd-font-powerlevel10k` is for `vim-devicons`.

### Mouse

Visit [this article](https://wiki.archlinux.org/title/Libinput#Configuration) to configure the trackpad.

### Sound

The packages `sof-firmware` and `alsa-ucm-conf` are needed to make sound work (at least on Thinkpad X1 Carbon Gen 4).

### Only prompt for default user password on boot

See [this link](https://wiki.archlinux.org/title/getty#Prompt_only_the_password_for_a_default_user_in_virtual_console_login)

### Fingerprint reading

See [this link](https://wiki.archlinux.org/title/Fprint)
