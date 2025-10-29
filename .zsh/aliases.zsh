alias vi=nvim
alias mux=tmuxinator alias tm=tmux

alias recent="ls -lt --color=always | head -n 10"
alias ip="ip -c"

# Docker
if command -v docker > /dev/null; then
  alias dr='docker run -it --rm'
  alias dr.='docker run -it --rm ${PWD##*/}' # Docker Run (current directory)
  alias drb='docker run -it --rm --entrypoint /bin/bash' # Docker Run Bash
  alias drb.='docker run -it --rm --entrypoint /bin/bash ${PWD##*/}' # Docker Run Bash (current directory)
  alias db='docker buildx build -t ${PWD##*/}'
  alias db.='docker buildx build -t ${PWD##*/} .'

  # Docker Compose
  alias dcu='docker compose up'
  alias dcd='docker compose down'

  # Docker start for Arch (Prevents br0 from stopping to work)
  alias dockerstart='sudo systemctl start docker && sudo iptables -I FORWARD -i br0 -o br0 -j ACCEPT'
fi

# Podman
if command -v podman > /dev/null; then
  alias pr='podman run -it --rm'
  alias pr.='podman run -it --rm ${PWD##*/}' # Podman Run (current directory)
  alias prb='podman run -it --rm --entrypoint /bin/bash' # Podman Run Bash
  alias prb.='podman run -it --rm --entrypoint /bin/bash ${PWD##*/}' # Podman Run Bash (current directory)
  alias pb='podman buildx build -t ${PWD##*/}'
  alias pb.='podman buildx build -t ${PWD##*/} .'
fi

# Kubernetes
alias k=kubectl

# Japanese Dictionary
alias jp=myougiden

# check installed packages with pacman
command -v pacman > /dev/null && alias pacinstalled="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}'"
command -v pacman > /dev/null && alias pacuninstall="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
command -v pacman > /dev/null && alias pacsearch="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"

command -v yay > /dev/null && alias yayinstalled="yay -Qq | fzf --multi --preview 'yay -Qi {1}'"
command -v yay > /dev/null && alias yayuninstall="yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro yay -Rns"
command -v yay > /dev/null && alias yaysearch="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"

# Git
alias gtree="git log --oneline --decorate --graph"

# use lsd if available
ls() {
  if command -v lsd > /dev/null; then
    command lsd $@
  else
    command ls $@
  fi
}

# status command
st() {
  if [ "$#" -eq 0 ]; then
    unset STARSHIP_STATUS
  else
    export STARSHIP_STATUS="$@ "
  fi
}

timecalc() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: timecalc <start_time> <end_time> (format: HHMM)"
    return 1
  fi

  start_time=$1
  end_time=$2

  start_hour=${start_time:0:2}
  start_minute=${start_time:2:2}
  end_hour=${end_time:0:2}
  end_minute=${end_time:2:2}

  start_total_minutes=$((10#$start_hour * 60 + 10#$start_minute))
  end_total_minutes=$((10#$end_hour * 60 + 10#$end_minute))

  if [ $end_total_minutes -lt $start_total_minutes ]; then
    end_total_minutes=$((end_total_minutes + 24 * 60))
  fi

  diff_minutes=$((end_total_minutes - start_total_minutes))
  diff_hours=$((diff_minutes / 60))
  diff_remaining_minutes=$((diff_minutes % 60))

  printf "Time Difference: %02d:%02d\n" $diff_hours $diff_remaining_minutes
}
