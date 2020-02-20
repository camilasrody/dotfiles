# Edit this line to set your own remote
THIS_REPO=https://github.com/camilasrody/dotfiles.git

# where $BARE_DOTFILES directory is a git bare repository.
BARE_DOTFILES=$HOME/.bare-dotfiles
BARE_DOTFILES_BACKUP=$HOME/.bare-dotfiles-bkp
BARE_DOTFILES_TMP=$HOME/.bare-dotfiles-tmp

[[ ! -e .gitmodules ]] && git clone --depth 1 --branch master --separate-git-dir=$BARE_DOTFILES $THIS_REPO $BARE_DOTFILES_TMP && \
	cp $BARE_DOTFILES_TMP/.gitmodules $HOME
rm -rf $BARE_DOTFILES_TMP

[[ ! -e $BARE_DOTFILES ]] && git clone --jobs 10 --branch master --bare $THIS_REPO $BARE_DOTFILES
function dotfiles {
   /usr/bin/git --git-dir=$BARE_DOTFILES --work-tree=$HOME $@
}

# dotfiles remote add origin $THIS_REPO
# dotfiles checkout --track master/bare
# dotfiles checkout master
# dotfiles branch --set-upstream-to=origin/master master

# Reset current HEAD to the specified state
dotfiles reset --hard

# Init submodules
dotfiles submodule update --init --recursive

# Remove untracked files from the working tree
# dotfiles clean -df # Caution

dotfiles checkout
if [ $? = 0 ]; then
	echo "Checked out dotfiles.";
else
	echo "Backing up pre-existing dot files.";
	mkdir -p $BARE_DOTFILES_BACKUP
	dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $BARE_DOTFILES_BACKUP/{}
fi;
dotfiles checkout


dotfiles config --local status.showUntrackedFiles no
[[ ! -h .git ]] && ln -s $BARE_DOTFILES .git

source ~/.profile

bash ./install.sh

# password-store-installer
# rsync --recursive --verbose --exclude '.git' dotfiles-tmp/ $HOME/
# rm --recursive dotfiles-tmp
