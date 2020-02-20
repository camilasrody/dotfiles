#!/bin/bash

# fail hard
set -o pipefail
# fail on first error
# set -e # Disable by default
# fail no variables
set -u
IFS=$'\n\t'
CURRENT_LOG_FILE=$(ls -rt ~/logs/ | tail -n1)
BEAUTIFUL_LOG_FILE="${CURRENT_LOG_FILE}.png"

source ~/.shellvars
source ~/.shellpaths

# function finish {
#     # re-link system's python
#     brew link --overwrite --dry-run python@2
# }
# trap finish EXIT

# # Use python3 by default
# rm -f /usr/local/bin/python 2>&1 >/dev/null; ln -s $(which python3) /usr/local/bin/python

# Update App Store apps
# sudo softwareupdate -i -a
# mas upgrade 2>&1 >/dev/null;			code=$?; [[ code -ne 0 ]] && echo "mas upgrade; exit code was ${code}\n"

# Update Homebrew (Cask) & packages
brew update 2>&1 >/dev/null;			code=$?; [[ code -ne 0 ]] && echo "brew update; exit code was ${code}\n"
# brew upgrade 2>&1 >/dev/null;			code=$?; [[ code -ne 0 ]] && echo "brew upgrade; exit code was ${code}\n"

# Update npm & packages
# yarn update -g
# npm update -g

# Update Ruby & gems
# sudo gem update --system --verbose 2>&1 >/dev/null;	code=$?; [[ code -ne 0 ]] && echo "gem update; exit code was ${code}\n"
# sudo gem update

# Update Python
# pip3 install --upgrade setuptools 2>&1 >/dev/null;	code=$?; [[ code -ne 0 ]] && echo "pip setuptools update; exit code was ${code}\n"
# pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U 2>&1 >/dev/null;	code=$?; [[ code -ne 0 ]] && echo "pip3 update; exit code was ${code}\n"

# Update Others packages
tldr --update 2>&1 >/dev/null;			code=$?; [[ code -ne 0 ]] && echo "tldr update; exit code was ${code}\n"

casks_outdated=`brew cask outdated --greedy --verbose | grep -v '(latest)' | cut -d' ' -f1`
delete=(webstorm phpstorm intellij-idea pycharm metasploit)
for del in ${delete[@]}
do
   casks_outdated=("${casks_outdated[@]/$del}")
done
for cask_outdated in ${casks_outdated[@]}
do
   # brew cask upgrade `echo $cask_outdated` 2>&1 >/dev/null;		code=$?; [[ code -ne 0 ]] && echo "brew upgrade cask outdated: ${cask_outdated}; exit code was ${code}\n"
   brew cask upgrade `echo $cask_outdated`
   code=$?; [[ code -ne 0 ]] && echo "brew upgrade cask outdated: ${cask_outdated}; exit code was ${code}\n"
done

# cleans up cached downloads (with --outdated, only cleans old downloads)
brew cleanup 2>&1 >/dev/null;			code=$?; [[ code -ne 0 ]] && echo "brew cleanup; exit code was ${code}\n"
# checks for configuration issues
brew doctor 2>&1 >/dev/null;			code=$?; [[ code -ne 0 ]] && echo "brew doctor; exit code was ${code}"

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias mac.update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; mas upgrade; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup'

# Clear quicklook macos cache
qlmanage -r cache

# Upgrade Oh-my-zsh
upgrade_oh_my_zsh

# Remote Notification
TEXT=$(printf "\
==============\n \
HOSTNAME: "`hostname`"\n\
WAN IP: "`dig +short myip.opendns.com @resolver1.opendns.com`"\n\
\n\n\
Update History Log:\n\
`cat ~/logs/$CURRENT_LOG_FILE`\
")
# npx --quiet telemify "${TEXT}\n"

# Altenative way to send
# JSON_CONFIG="$(cat ~/.config/telemify/config.json)"
# CHAT_ID="$(echo $JSON_CONFIG | jq --raw-output .chat_id)"

# TELEGRAM_BOT_TOKEN="$(echo $JSON_CONFIG | jq --raw-output .token)" \
# npx --quiet tgb --method sendMessage --d.chat_id ${CHAT_ID} --d.text "${TEXT}\n"

npx -q carbon-now-cli --target "~/logs/${BEAUTIFUL_LOG_FILE}\n" --headless --preset blog-master-present "~/logs/${CURRENT_LOG_FILE}"

# Local Notification
osascript -e 'display notification "" with title "System Updated"'


exit 0
