#!/usr/bin/env bash

if [[ "$(uname -s)" != "Linux" ]]; then
  echo "Not running on Linux. Aborting!"
  exit 1
fi

source ./lib_sh/echos.sh
source ./lib_sh/requirers.sh

bot "Hi! I'm going to install tooling and tweak your system settings."

# curl -LO larbs.xyz/larbs.sh
# sudo bash larbs.sh

# bot "TTS (text-to-speech) voices"
# read -t 7 -r -p "Would you like to install voices? (y|N) [or wait 7 seconds for default=N] " response; echo ;
# response=${response:-N}
# if [[ $response =~ (yes|y|Y) ]];then
#   npx --quiet voices -m
#   ok
# fi

[[ ! -e ~/.oh-my-zsh ]] || git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh && \
	chsh -s $(which zsh)

# 2. Optionally, backup your existing ~/.zshrc file:
# cp ~/.zshrc ~/.zshrc.orig

# 3. Create a new zsh configuration file
# You can create a new zsh config file by copying the template that we have included for you.
# cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# 4. Change your default shell
# chsh -s $(which zsh)

# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# running "Installing zsh custom plugins"
# mkdir -p $ZSH_CUSTOM/plugins/

# if [[ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]]; then
#   git clone https://github.com/supercrabtree/k.git "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
# fi

# if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
#   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
# fi

# if [[ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]]; then
#   git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
# fi

# if [[ ! -d "${ZSH_CUSTOM}/themes/powerlevel9k" ]]; then
#   git clone https://github.com/bhilburn/powerlevel9k.git "${ZSH_CUSTOM}/themes/powerlevel9k"
# fi
# ok

# bot "Installing vim plugins"
# vim +PluginInstall +qall ## > /dev/null 2>&1
# ok

###############################################################################
bot "Developer default settings"
###############################################################################
[[ ! -e $HOME/.password-store ]] || git clone "${PASSWORD_STORE_REMOTE_URL}.git" $HOME/.password-store
# netlify --telemetry-disable
# Installation of is.sh. A fancy alternative for old good test command.
# yarn global add carbon-now-cli
# yarn global add is.sh
touch $HOME/.hushlogin
mkdir -p $MY_TEMP

mkdir -p $HOME/pi/.bin/

# Fix mariadb start bug
# mkdir -p /usr/local/etc/my.cnf.d

# Disable docker Crash Reporting
# touch ~/.docker/machine/no-error-report

###############################################################################
bot "Developer workspace"
###############################################################################

# if [[ ! -e $HOME/.password-store ]]; then
# bot "Tip: Use gpg-suite to {manage,generate,import} GPG easy there."

#   read -t 7 -r -p "Would you like to setup gpg keys? (y|N) [or wait 7 seconds for default=N] " response; echo ;
#   response=${response:-N}
#   if [[ $response =~ (yes|y|Y) ]];then
#     # Setup create/restore keys
#     password-store-installer
#   fi
# fi

# git config --global credential.helper osxkeychain

# running "Adding nightly cron software updates"
# crontab ~/.crontab

# running "Updating composer keys public keys"
# releases_key=$(curl -Ls https://composer.github.io/releases.pub)
# snapshots_key="$(curl -Ls https://composer.github.io/snapshots.pub)"
# expect << EOF
#   spawn composer self-update --update-keys
#   sleep 1
#   expect "Enter Dev / Snapshot Public Key (including lines with -----):"
#   send -- "$releases_key"
#   send "\r"
#   expect "Enter Tags Public Key (including lines with -----):"
#   send -- "${snapshots_key}\r"
#   send "\r"
#   expect eof
# EOF
# ok

running "Create dev folder in home directory"
mkdir -p ~/dev;ok

running "Create blog folder in home directory"
mkdir -p ~/blog;ok

running "Create logs folder in home directory"
mkdir -p ~/logs;ok

sudo apt-get install build-essential curl file git

sh -c "$(curl -fsSL [https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh])"

test -d \~/.linuxbrew && eval $(\~/.linuxbrew/bin/brew shellenv)
test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
test -r \~/.bash\_profile && echo "eval \\$($(brew --prefix)/bin/brew shellenv)" >>\~/.bash\_profile
echo "eval \\$($(brew --prefix)/bin/brew shellenv)" >>\~/.shellpaths

###############################################################################
bot "The End"
###############################################################################
# npx --quiet okimdone
bot "Woot! All done."
sleep 2

###############################################################################
# Kill affected applications                                                  #
###############################################################################
bot "Done. Note that some of these changes require a logout/restart to take effect. I will kill affected applications (so they can reboot)...."

read -n 1 -s -r -p "Press any key to continue"
