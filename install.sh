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
# Nap zsh/aliases.zsh tu ~/.zshrc (chi them 1 lan, khong ghi de gi)
ZRC="$HOME/.zshrc"
SRC_LINE="[ -f \"$DIR/zsh/aliases.zsh\" ] && source \"$DIR/zsh/aliases.zsh\"  # dotfiles"
if ! grep -qF "$DIR/zsh/aliases.zsh" "$ZRC" 2>/dev/null; then
  printf '\n%s\n' "$SRC_LINE" >> "$ZRC"; echo "zshrc  them dong nap zsh/aliases.zsh vao $ZRC"
else
  echo "ok     $ZRC (da co dong nap aliases)"
fi
echo "Xong. Mo nvim lan dau de LazyVim tu cai plugin."
