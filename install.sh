#!/usr/bin/env bash
# Tao lien ket (symlink) tu repo nay vao thu muc nha. File cu duoc doi ten thanh *.bak.<gio>.
# Chay:  ./install.sh        (chi tao lien ket, KHONG cai phan mem)
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
STAMP="$(date +%Y%m%d-%H%M%S)"

link() {  # link <nguon trong repo> <dich>
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "ok     $dst (da dung)"; return
  fi
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mv "$dst" "$dst.bak.$STAMP"; echo "backup $dst -> $dst.bak.$STAMP"
  fi
  ln -s "$src" "$dst"; echo "link   $dst -> $src"
}

link "$DIR/nvim"                              "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
link "$DIR/tmux/tmux.conf"                    "$HOME/.tmux.conf"
link "$DIR/markdownlint/markdownlint-cli2.yaml" "$HOME/.markdownlint-cli2.yaml"
echo "Xong. Mo nvim lan dau de LazyVim tu cai plugin."
