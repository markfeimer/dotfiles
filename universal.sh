#### MarkF bash profile ####

### Universal Section ###
export CLICOLOR=1

#git formatting
source ~/dotfiles/git-prompt.sh

### Common aliases ###

#boosh = boooounce shell
alias boosh="source ~/.bash_profile"
# Prompt colors
export PS1='\[\033[0;32m\]\u\[\033[0m\]@\[\033[0;32m\]\h \t  \[\033[0m\] \[\033[0;33m\][\w]:$(__git_ps1 " (%s)") \$\[\033[0m\] '
export TERM=xterm-256color


### OS specific ###

## Mac/BSD definitions
#export LSCOLORS="GxFbCbDbBbegedabagaced"
#alias ls="ls -GFal"
#for X systems
#alias toclip="xclip -selection clipboard"
# enable clipboards on Mac by using mvim
#alias vim='echo "using macvim in terminal mode" && mvim -v'

## For Linux-y definitions
alias ls="ls -Fal --color" 
export LS_COLORS="di=1;36:fi=35:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35"


### System Config for each machine ###
source ~/dotfiles/localMachine.sh



