export RCFILE=$HOME/.profile

# Where are we?

# detect interactive shell
case "$-" in
  *i*) INTERACTIVE=yes ;;
  *) unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
  -*) LOGIN=yes ;;
  *) unset LOGIN ;;
esac


#----------------------------------------------------------
# PATH
#----------------------------------------------------------

export PATH="/usr/local/bin:$PATH"

# Add ~/bin to path if it exists.
test -d "$HOME/bin" && export PATH="$HOME/bin:$PATH"


#----------------------------------------------------------
# LOCALE
#----------------------------------------------------------

export LANG=en_AU
export LC_CTYPE=UTF-8
export LC_ALL=en_AU.UTF-8


#----------------------------------------------------------
# PAGER / EDITOR
#----------------------------------------------------------

# Use `less` as the default pager.
export PAGER="less -FirSwX"
export MANPAGER="$PAGER"

# Ack
ACK_PAGER="$PAGER"
ACK_PAGER_COLOR="$PAGER"

# Vim is forever.
export EDITOR=vim
export SVN_EDITOR=vim


#----------------------------------------------------------
# MISC ENVIRONMENT CONFIGURATION
#----------------------------------------------------------

# Use vim bindings for command line (ie, press ESC to leave 'insert' mode).
set -o vi

# Bash history store
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000

# ignore backups, CVS directories, python bytecode, vim swap files
FIGNORE=".swp:.DS_Store"

# Don't store searches made in `less` in ~/.lesshst
export LESSHISTFILE=-

# Don't need to know 'You have new mail in ...'
unset MAILCHECK

# Disable core dumps.
ulimit -S -c 0

# Default umask.
umask 0022


#----------------------------------------------------------
# EXTERNAL ENVIRONMENT CONFIGURATION
#----------------------------------------------------------

# Load git bash completion
if [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
  source /usr/local/etc/bash_completion.d/git-completion.bash
fi

# Load RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Load personal command aliases
[[ -s "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Load personal shell functions
[[ -s "$HOME/.functions" ]] && source "$HOME/.functions"


#----------------------------------------------------------
# PROMPT
#----------------------------------------------------------

# Set a fancy prompt (non-color, unless we know we "want" color)
#
case "$TERM" in
xterm-color)
  declare -f __git_ps1 > /dev/null
  if [ $? -eq 0 ]; then
    PS1='\[\033[01;33m\][\t]\[\033[00m\] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w \[\033[1;35m\]$(__git_ps1 "%s")\[\033[00m\]\n\$ '
  else
    PS1='\[\033[01;33m\][\t]\[\033[00m\] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n$ '
  fi
  ;;
*)
  PS1='\u@\h:\w\n\$ '
  ;;
esac


# Say hello!
test -n "$INTERACTIVE" -a -n "$LOGIN" && {
  uname -npsr
  uptime
}
