#!/bin/bash

#########################################
# .bashrc								#
# Author: Randy Rhoads 22 Jan 2010		#
# Copyright (c) Force Operation X 2009	#
#########################################
date '+%Y/%m/%d %H:%M:%S';
echo "initializing .bashrc....."
#########################################
# Complete settings						#
#########################################

#########################################
# prompt setting						#
#########################################
# PS1="¥[¥033[35m¥]¥t¥[¥033[m¥]-¥[¥033[36m¥]¥u¥[¥033[m¥]@¥[¥033[1;32m¥]¥s:¥[¥033[33;1m¥]¥w¥[¥033[m¥]¥n$ "
#########################################
# PATH settings							#
#########################################
export PATH=/usr/bin:/opt/local/bin:opt/local/sbin:/opt/local/bin:$PATH
export MANPATH=/opt/local/man:$MANPATH
#########################################
# View settings							#
#########################################
export PAGER=less
export LESS='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb¥%..]'
# export MORE='-X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb¥%..]'
#########################################
# ls color setting						#
#########################################
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-color
set -o noclobber
#########################################
# grep search							#
#########################################
export GREP_COLOR='1;37;41'
#########################################
# alias command							#
#########################################
# util, view
alias ..='cd ../'
alias cl='clear'
alias ls='ls -GF'
alias ll='ls -al'
alias la='ls -alrt'
alias dir='ls'
alias vi='vim'
alias view='vim'
alias mvim='open -a /Applications/Editor/MacVim.app'
alias rmi='rm -i'
alias cpi='cp -i'
alias mvi='mv -i'
alias fileinfo='GetFileInfo'
alias df='df -h'
# one letter command
alias a='alias'
alias b='batch'
alias c='cal'
alias d='du -sx /'
alias e='echo'
alias f='find'
alias g='grep -in'
alias h='history 50 | less'
alias j='jobs'
alias k='kill'
alias l='ls -aF'
alias m='man'
alias n='netstat'
alias o='open'
alias p='ping www.google.com'
alias r='rm -i'
alias s='screen'
alias t='telnet'
alias u='uniq'
alias v='vim'
alias w='wc'
alias x='exit'
alias y='yes'
# develop
# process
alias ka='killall'
alias kf='killall Finder'
alias kk='killall Kotoeri'
alias kd='killall Dock'
alias ks='killall SystemUIServer'
# system
alias top='top -orsize'
alias ver='sw_vers'
alias wr='whereis $1'

# disk utility
alias disklist='diskutil list'
alias diskinfo='diskutil info'
alias diskm='diskutil mount'
alias disku='diskutil unmount'
alias diske='diskutil eject'
# network
alias netstati='netstat -f inet'
alias netstatu='netstat -f unix'
alias curl='curl -O'
alias pingt='ping www.google.com'
export CVS_RSH=ssh
# compress/archive
alias tarx='tar -xvf'
alias tarc='tar -cvf'
# OS X peculiar commands
alias setfile='SetFile'
alias spotlight='mdfind'
alias as='osascript'
# executable file

# shell script
alias kaa='~/src/sh/system_sh/ka_process.sh'
alias rmt='~/src/sh/function_sh/RemoveTrash.sh'
alias ggrks='~/src/sh/function_sh/google.sh'
alias google='~/src/sh/function_sh/google.sh'
# open applications
alias qs='open /Applications/QuickSilver.app'
alias mi='open -a mi'
alias co='open -a CotEditor'
alias xcode='open -a Xcode'
alias ibuild='open -a Interface¥ Builder'
alias x11='open -a X11'
alias xls='open -a /Applications/Office/Microsoft¥ Office¥ 2008/Microsoft¥ Excel.app'
alias ppt='open -a /Applications/Office/Microsoft¥ Office¥ 2008/Microsoft¥ Powerpoint.app'
alias word='open -a /Applications/Office/Microsoft¥ Office¥ 2008/Microsoft¥ Word.app'
alias quicktime='open -a /Applications/QuickTime¥ Player.app'
#########################################
# others								#
#########################################

#########################################
# custom action function				#
#########################################
function bu {
	cp		~/.bashrc		~/SysInfo/;
	cp		~/.vimrc		~/SysInfo/;
	cp		~/.inputrc		~/SysInfo/;
	cp		~/.profile		~/SysInfo/;
	cp		~/.bash_profile	~/SysInfo/;
	cp		/etc/fstab		~/SysInfo/;
	cp		~/.vimperatorrc	~/SysInfo/;
	cp -r	~/.vim			~/SysInfo/;
	cp -r	~/.vimperator	~/SysInfo/;
}
function i {
	if [ "$1" ]; then
		history 100 | grep "$@";
	else
		history 30;
	fi;
}
function mkdmg {
	hdiutil create -srcfolder $1;
}
function dmgm {
	hdiutil mount $1;
}
function dmgu {
	hdiutil unmount $1;
}
function trash {
	open ~/.Trash;
}
function iphone {
	cd ~/Development/iPhone/;
}
function app {
	cd /Applications/;
}
function doc {
	cd ~/Documents/;
}
function dt {
	cd ~/Desktop/;
}
function dl {
	cd ~/Downloads/;
}
function shdir {
	cd ~/src/sh/;
}
function src {
	cd ~/src/;
}
function pic {
	cd ~/Pictures/;
}
function memo {
	cd ~/Documents/memo/;
}
function devdir {
	cd /Developer/Applications/;
}
function gmsrc {
	cd ~/src/JavaScript/project/Greasemonkey/NicovideoMenu/;
}
function gmdir {
	cd ~/Library/Application¥ Support/Firefox/profiles/35shr0f8.default/gm_scripts/;
}
function z {
	lsof -P -i -n | cut -f 1 -d " " | uniq;
}
function appstatus {
	ls | cat >> ~/AppResult.txt;
}
function vol {
	cd /Volumes/;
}
function cdir {
	cd ~/src/c/;
}
function dl {
	cd ~/Downloads/;
}
function cppdir {
	cd ~/src/cpp/;
}
function javadir {
	cd ~/src/Java/;
}
function jsdir {
	cd ~/src/JavaScript/;
}



PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
