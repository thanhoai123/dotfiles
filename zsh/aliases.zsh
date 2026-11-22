# Lenh tat dung chung. Duoc nap tu ~/.zshrc boi install.sh.
#
# md <file.md>: doc Markdown dep trong terminal (can cai glow). Cuon j/k, q de thoat.
# Glow tu doan mau nen terminal nhung hay doan sai (chu bi mo tren nen trang),
# nen o day chon san: Terminal.app (nen trang) -> light, con lai -> auto.
# Ep kieu bang bien moi truong:  MD_STYLE=dark md file.md   hoac   export MD_STYLE=light
if command -v glow >/dev/null 2>&1; then
  md() {
    local style="${MD_STYLE:-}" term="${TERM_PROGRAM:-}"
    if [ -z "$style" ]; then
      # Trong tmux, TERM_PROGRAM la "tmux"; lay ten terminal ben ngoai tu moi truong chung cua tmux
      [ "$term" = "tmux" ] && term="$(tmux show-environment -g TERM_PROGRAM 2>/dev/null | cut -d= -f2)"
      case "$term" in
        Apple_Terminal) style=light ;;
        *) style=auto ;;
      esac
    fi
    glow -p -s "$style" "$@"
  }
fi
