# dotfiles :octocat:

This repository contains a collection of scripts, tools and configurations that help me to be more productive in my everyday job as a software web developer. The repository will grow over time, as I publish more scripts.

Automated strategy to re-create my `.` files environment in case my device fails.

## Compatibility

POSIX configuration files designed to be cross-platform between macOS and GNU/Linux.

|               | **AMD** | **NVIDIA** | **Intel** | 
| :-----------: | :-----: | :--------: | :-------: |
| **Windows**   | :x: | :x: | :x: |
| **GNU/Linux** | Soon:tm: | Soon:tm: | Soon:tm: |
| **OSX**       | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |

I intend for my managed dotfiles to be portable between GNU/Linux and macOS systems.

## 🚀 Installation setup and Replication

You don't need to install or configure anything upfront! This works with a brand-new macOS machine.

All steps use configuration convention (sensitive defaults) and everything should be performed automatically without having to press any buttons until the end. However, you can still interact at any time.

I suppose for those that _just want the dotfiles_ getting set up is as easy as:

```sh
curl -Lks https://raw.githubusercontent.com/thomasgroch/dotfiles/master/bootstrap.sh | /bin/bash

# or POSIX compatible lazy install
download=false ; if type curl >/dev/null 2>/dev/null ; then download='curl -Lks' ; elif type wget >/dev/null ; then download='wget -O -' ; else ; echo "No way to download dotfiles; please install curl or wget with your package manager" ; fi ; eval "$download https://raw.githubusercontent.com/thomasgroch/dotfiles/master/bootstrap.sh" | /bin/bash
```

** \\[._.]/ Done! **

No extra tooling, no symlinks, files are tracked on a version control system, you can use different branches for different computers, you can replicate you configuration easily on new installation.

* When it finishes, open iTerm and press `Command + ,` to open preferences. Under Profiles > Colors, select "Load Presets" and choose the `Solarized Dark Patch` scheme. If it isn't there for some reason, import it from `~/.dotfiles/configs` -- you may also need to select the `Hack` font and check the box for non-ascii font and set to `Roboto Mono For Powerline` (I've had mixed results for automating these settings--love a pull request that improves this)
* I've also found that you need to reboot before fast key repeat will be enabled

> Note: running install.sh is idempotent. You can run it again and again as you add new features or software to the scripts! I'll regularly add new configurations so keep an eye on this repo as it grows and optimizes.


## 🏠 Usage

Any file within the home folder can be versioned with commands like:

```sh
dotfiles status
dotfiles add .gitconfig
dotfiles commit -m 'Add gitconfig'
dotfiles push
```

# Update your forked repository

If you plan on working on this project for anything more than a very quick fix. Use the following commands to add the 'upsteam' (original project location) as a remote branch so that you can get my updates into your branch.

```sh
git remote add --track master upstream https://github.com/thomasgroch/dotfiles.git
```

This will add the original project as a remote named 'upstream'.

To get the code, type:

```sh
git fetch upstream
git checkout master ## Make sure that you're on your master branch
```

Then, to merge it into your own project, type:

```sh
git merge upstream/master
```

Now you'll have an up-to-date version of the upstream code in your current branch.

Or just use the shortcut `dotfiles_update` defined on [.shellaliases](../master/.shellaliases#L150)

# References

- [Change macOS user preferences via command line](https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/)

- https://github.com/bvaughn/progress-estimator

- [Git hooks made easy](https://github.com/typicode/husky)

- [setup local dev tampermonkey](https://stackoverflow.com/questions/49509874/how-to-update-tampermonkey-script-to-a-local-file-programatically)

# Credits

I've rewritten my dotfiles many times, and each time I've been influenced by someone new. These people include:

- Adam Eivy
- Alan Yee
- Maki Tolentino
- Henson, Garth
- Michael Chambers
- JBallin
- KyuWoo Choi
- [Tom Ryder](https://sanctum.geek.nz/)

# License

Os arquivos e scripts neste repositório são licenciados sob a Licença MIT, que é uma licença muito permissiva que permite usar, modificar, copiar, distribuir, vender, doar, etc. o software. Em outras palavras, faça o que quiser com ele. O único requisito da licença MIT é que a licença e o aviso de direitos autorais sejam fornecidos com o software.


# Contributions
Contributions are always welcome in the form of pull requests with explanatory comments.

Please refer to the [Contributor Covenant](https://github.com/thomasgroch/dotfiles/blob/master/CODE_OF_CONDUCT.md)

# Loathing, Mehs and Praise
1. Loathing should be directed into pull requests that make it better. woot.
2. Bugs with the setup should be put as GitHub issues.
3. Mehs should be > /dev/null
4. Praise should be directed to [![@antic](https://img.shields.io/twitter/follow/antic.svg?style=social&label=@antic)](https://twitter.com/antic)


# ⚠️ Warning / Liability
> Warning:
The creator of this repo is not responsible if your machine ends up in a state you are not happy with. If you are concerned, look at the code to review everything this will do to your machine :)

Unless you're sitting next to me, I wouldn't really recommend a complete
installation of these dotfiles. They might get to that polished, pristine state
at some point, but right now they're not there.

They're getting closer though.

If you insist, you can see the steps that I run through when setting up a new
[macOS laptop](osx-setup.sh) or [server](ubuntu-setup.sh). They read like
scripts, but __please don't run them like scripts__. I've never needed them to
be robust enough to be run attended; I always just copy and paste each command
one at a time in case something has changed between the last time I set up a
device and now.

__However__, my dotfiles make a heavy-handed assumption that you're using zsh +
OS X + Homebrew + iTerm2 most of the time, which is agreeable for me but maybe
unagreeable for you. This is why I wouldn't recommend just cloning the repo and
running with it. If you're looking for a solution like that, there are plenty of
excellent resources online at <https://dotfiles.github.io>.

Commands are first read from /etc/zshenv; this cannot be overridden. … Commands are then read from $ZDOTDIR/.zshenv. If the shell is a login shell, commands are read from /etc/zprofile and then $ZDOTDIR/.zprofile. Then, if the shell is interactive, commands are read from /etc/zshrc and then $ZDOT-DIR/.zshrc. Finally, if the shell is a login shell, /etc/zlogin and $ZDOTDIR/.zlogin are read.

When a login shell exits, the files $ZDOTDIR/.zlogout and then /etc/zlogout are read.

> It's always a good idea to review arbitrary code from the internet before running it on your machine with sudo power!
> You are responsible for everything this script does to your machine (see [LICENSE](LICENSE))
