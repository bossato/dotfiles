# .bash_profile

if [ -f ~/.bashrc ] ; then
  . ~/.bashrc
fi

git_branch() {
  echo $(git branch --no-color 2>/dev/null | sed -ne "s/^\* \(.*\)$/\1/p")
}

export PATH
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

PS1='\[\033[36m\]\u\[\033[0m\]\[\033[32m\]\w\[\033[0m\]:\[\033[35m\]$(git_branch)\[\033[0m\] $ '


alias ls='ls -G'
alias ll='ls -Gl'

eval "$(rbenv init -)"
