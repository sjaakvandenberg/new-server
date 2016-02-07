#!/bin/env bash
# Output functions
function info() {
  printf "[ \e[48;5;232m\e[38;5;32m··\e[0m\e[0m ] $1\n"
}

function user() {
  printf "[ \e[48;5;232m\e[38;5;220m??\e[0m\e[0m ] $1"
}

function okay() {
  printf "[ \e[48;5;232m\e[38;5;70mOK\e[0m\e[0m ] $1\n"
}

function remove() {
  printf "[ \e[48;5;232m\e[38;5;124mRM\e[0m\e[0m ] $1\n"
}

function link() {
  printf "[ \e[48;5;232m\e[38;5;32mLN\e[0m\e[0m ] $1\n"
}

function move() {
  printf "[ \e[48;5;232m\e[38;5;32mMV\e[0m\e[0m ] $1\n"
}

# Ask what to do
function choice() {
  local action=
  info "Clone repository, wipe your current dotfiles or move them? [c\w\m\q]"
  while read -s -n 1 action && [[ $action != q ]]; do
    case $action in
      c) clone_dotfiles;;
      C) clone_dotfiles;;
      w) wipe_dotfiles;;
      W) wipe_dotfiles;;
      m) move_dotfiles;;
      M) move_dotfiles;;
      q) exit;;
      Q) exit;;
      *) ;;
    esac
  done
}

# Ask where to store dotfiles
function get_location() {
  user "Dotfiles directory: $HOME/"
  read directory_input
  directory=$HOME/$directory_input
}

# Clone dotfiles
function clone_dotfiles() {
  local action=
  if [ "$(ls -A $directory)" ]; then
    info "$directory already exists. Remove? [y/N]"
    read -s -n 1 action
    case $action in
      y) rm -rf "$directory"; okay "Removed $directory.";;
      Y) rm -rf "$directory"; okay "Removed $directory.";;
      *) choice ;;
    esac
  fi
  user "GitHub username: "
  read github_username
  user "GitHub repository: "
  read github_repository
  info "Cloning dotfiles..."
  git clone "https://github.com/$github_username/$github_repository.git" "$directory"
  info "Dotfiles cloned to $directory."
  create_config
  choice
}

# Output dotfiles
function read_config() {
  cat $directory/.dotfiles | egrep -v "(^#.*|^$|^.dotfiles$)"
}

# Check directory and configuration file
function create_config() {
  # Check existence of directory and configuration file
  if [ -d $directory ]; then
    # $directory exists
    if [ -f "$directory/.dotfiles" ]; then
      # Read list of dotfiles
      info "Dotfiles found:"
      read_config | while read dotfile; do
        info "$dotfile"
      done
    else
      # Create configuration file
      echo -e "# dotfiles, relative to the $HOME directory\n.dotfiles" > $directory/.dotfiles
      info "Created $directory/.dotfiles"
      info "Add the dotfiles you want to use to the configuration file."
    fi
  else
    mkdir -p $directory # Create directory
    echo -e "# dotfiles, relative to the $HOME directory\n.dotfiles" > $directory/.dotfiles # Create configuration file
    info "Created $directory/.dotfiles"
  fi
}

function sanitize() {
  echo $1 \
  | sed "s/\(.*\)/\L\1/g" \
  | sed "s/\.conf\$//g" \
  | sed "s/\(\w*\)\/config\$/\.\1/g" \
  | sed "s/config.\(\w*\)\$/.\1/g" \
  | sed "s/rc\$//g" \
  | sed "s/.*\///g"
}

function wipe_dotfiles() {
  read_config | while read dotfile; do
    sanitized_dotfile=$(sanitize $dotfile)
    rm -rf "$HOME/$dotfile"
    remove "$HOME/$dotfile"
    ln -s "$directory/$sanitized_dotfile" "$HOME/$dotfile"
    link "$directory/$sanitized_dotfile -> $HOME/$dotfile"
  done
  okay "Wipe and link completed."
  exit
}

function move_dotfiles() {
  read_config | while read dotfile; do
    sanitized_dotfile=$(sanitize $dotfile)
    mv "$HOME/$dotfile" "$directory/$sanitized_dotfile"
    move "$HOME/$dotfile >> $directory/$sanitized_dotfile"
    ln -s "$directory/$sanitized_dotfile" "$HOME/$dotfile"
    link "$directory/$sanitized_dotfile -> $HOME/$dotfile"
  done
  okay "Move and link completed."
  exit
}

function main() {
  get_location
  create_config
  choice
}

main