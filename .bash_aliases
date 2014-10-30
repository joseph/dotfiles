# List files with human sizes and colours.
alias ls="command ls $LS_COMMON"
alias ll="ls -l"

# Show process list as a hierarchical tree
alias psf="ps -aef --forest"

# Find files by name.
alias fn='find . -name'

# Short history.
alias hi='history | tail -20'

# Disk use with human sizes, only reporting on files/directories at this level.
alias du1='du -h --max-depth=1'

# Insert some whitespace into the scroll buffer.
alias gap='printf "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" && clear'

# Ack how I like her.
alias ack='ack -a --smart-case --follow'

# Less how I like her.
alias lcat='less -FirSwX'

# Subversion diff ignoring whitespace.
alias svndiff='svn diff -x -uw --diff-cmd colordiff'

# Delete all .svn cruft under the current directory and its subdirectories -
# this is a dangerous alias!
alias svnerase='find . -name .svn -print0 | xargs -0 rm -rf'

# Start up the ssh agent
alias sshagent='ssh-agent /bin/bash --init-file ~/.bash_profile'

# Open a markdown file in Marked (MacOSX)
alias marked="open -a Marked"

alias gitdeltags="git tag -l | xargs git tag -d"
