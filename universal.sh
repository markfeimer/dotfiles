#### MarkF bash profile ####

### Universal Section ###
#iTerm2 prettification
export CLICOLOR=1
export LSCOLORS="GxFbCbDbBbegedabagaced"
export PS1='\[\033[0;32m\]\u\[\033[0m\]@\[\033[0;32m\]\h \t  \[\033[0m\] \[\033[0;33m\][\w]:$(__git_ps1 " (%s)") \$\[\033[0m\] '
export TERM=xterm-256color

#git formatting
source ~/.dotfiles/git-prompt.sh

#aliases
alias ls="ls -GFal"

#boosh = boooounce shell
alias boosh="source ~/.bash_profile"

##
# enable clipboards on Mac
##
alias vim='echo "using macvim in terminal mode" && mvim -v'

### System Config for each machine ###
source ~/.dotfiles/localMachine.sh



