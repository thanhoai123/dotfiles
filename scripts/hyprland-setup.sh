#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════
#  Cài Hyprland song song với GNOME trên Fedora 45
#  Surface Laptop 4 AMD — GNOME được GIỮ NGUYÊN làm phương án dự phòng
#
#    sudo bash ~/hyprland-setup.sh              # cài
#    sudo bash ~/hyprland-setup.sh --uninstall  # gỡ sạch, trả về như cũ
#
#  Config đã được viết sẵn ở ~/.config/{hypr,waybar,wofi,mako,alacritty}
# ═══════════════════════════════════════════════════════════════════════
set -euo pipefail

[[ $EUID -eq 0 ]] || { echo "Chạy bằng sudo: sudo bash $0"; exit 1; }
REAL_USER="${SUDO_USER:-$(logname 2>/dev/null || echo thanhoai123)}"

COPR="pm4rcin/Hyprland"
COPR_FILE="/etc/yum.repos.d/_copr:copr.fedorainfracloud.org:pm4rcin:Hyprland.repo"

# Repo Tailscale trên máy này có lỗi khoá GPG -> tắt tạm để dnf không treo hỏi
DNF_OPTS=(--disablerepo=tailscale-stable)

# Các package COPR TRÙNG tên với package Fedora đang cài.
# COPR có bản cao hơn (matugen 4.2.0 > 3.1.0, quickshell 0.3.2 > 0.2.1) nên
# nếu không chặn, `dnf upgrade` sẽ âm thầm thay build Fedora bằng build COPR.
EXCLUDE="cliphist matugen qt6ct quickshell"

# ── Hyprland stack: CHỈ có trong COPR ────────────────────────────────
PKGS_COPR=(
  hyprland                      # compositor
  hyprlock                      # màn hình khoá
  hypridle                      # tự khoá / tắt màn
  hyprpaper                     # ảnh nền
  hyprpolkitagent               # hộp thoại xin mật khẩu
  hyprshot                      # chụp ảnh màn hình
  hyprpicker                    # lấy mã màu
  hyprsunset                    # lọc ánh sáng xanh
  xdg-desktop-portal-hyprland   # chia sẻ màn hình / hộp thoại file
  nwg-look                      # công cụ đổi theme GTK
)

# ── Phần còn lại: repo Fedora chính thức ─────────────────────────────
PKGS_FEDORA=(
  alacritty waybar wofi mako wlogout
  brightnessctl playerctl pavucontrol
  network-manager-applet blueman
  wl-clipboard grim slurp btop
  papirus-icon-theme
  jetbrains-mono-fonts google-noto-sans-cjk-fonts
  google-noto-color-emoji-fonts fontawesome-fonts-all
)
# Lưu ý: cliphist đã có sẵn từ repo Fedora, không cần cài lại.
# google-noto-sans-cjk-fonts = để đọc/gõ tiếng Nhật (công việc BrSE của bạn).

# ═══════════════════════════════════════════════════════════════════════
if [[ "${1:-}" == "--uninstall" ]]; then
  echo "══> GỠ Hyprland, trả máy về GNOME thuần"
  dnf -y "${DNF_OPTS[@]}" remove "${PKGS_COPR[@]}" 2>/dev/null || true
  dnf -y copr disable "$COPR" 2>/dev/null || true
  rm -f "$COPR_FILE"
  echo
  echo "Đã gỡ. GNOME không bị ảnh hưởng."
  echo "Config vẫn còn ở ~/.config/{hypr,waybar,wofi,mako,alacritty} — xoá tay nếu muốn."
  echo "Font Nerd Font ở ~/.local/share/fonts/JetBrainsMonoNerdFont — xoá tay nếu muốn."
  exit 0
fi

echo "══> 1/6  Kiểm tra trước khi cài"
. /etc/os-release
[[ "${VERSION_ID:-}" == "45" ]] || echo "  ⚠️  Script viết cho Fedora 45, máy đang là $VERSION_ID"
echo "  Fedora $VERSION_ID  |  kernel $(uname -r)"
echo "  GPU: $(lspci | grep -iE 'vga|3d' | sed 's/.*: //' | head -1)"

echo
echo "══> 2/6  Bật COPR $COPR"
echo "  ⚠️  Đây là repo của cá nhân (fork từ solopasha/hyprland)."
echo "     Fedora 45 KHÔNG đóng gói hyprland, nên đây là cách duy nhất"
echo "     ngoài việc tự build từ source."
dnf -y copr enable "$COPR"

# Chặn 4 package trùng
if [[ -f "$COPR_FILE" ]] && ! grep -q "^excludepkgs=" "$COPR_FILE"; then
  echo "excludepkgs=$EXCLUDE" >> "$COPR_FILE"
  echo "  ✓ Đã chặn khỏi COPR: $EXCLUDE"
fi

echo
echo "══> 3/6  Cài Hyprland stack từ COPR"
dnf -y "${DNF_OPTS[@]}" install "${PKGS_COPR[@]}"

echo
echo "══> 4/6  Cài công cụ desktop từ repo Fedora"
dnf -y "${DNF_OPTS[@]}" install "${PKGS_FEDORA[@]}"

echo
echo "══> 5/6  Bật service cho người dùng $REAL_USER"
runuser -l "$REAL_USER" -c 'systemctl --user enable hyprpolkitagent.service' 2>/dev/null \
  && echo "  ✓ hyprpolkitagent" || echo "  ⚠️  bật hyprpolkitagent thất bại — hyprland.conf vẫn tự start nó"

echo
echo "══> 6/6  Kiểm tra kết quả"
ok=0; fail=0
for b in Hyprland hyprlock hypridle hyprpaper hyprshot waybar wofi mako alacritty; do
  if command -v "$b" >/dev/null 2>&1; then printf "  ✓ %s\n" "$b"; ok=$((ok+1))
  else printf "  ❌ %s KHÔNG THẤY\n" "$b"; fail=$((fail+1)); fi
done
echo
if [[ -f /usr/share/wayland-sessions/hyprland.desktop ]]; then
  echo "  ✓ GDM sẽ hiện mục 'Hyprland' ở màn hình đăng nhập"
else
  echo "  ❌ Thiếu /usr/share/wayland-sessions/hyprland.desktop"
fi
echo "  Phiên sẵn có: $(ls /usr/share/wayland-sessions/ | tr '\n' ' ')"

echo
echo "═══════════════════════════════════════════════════════════════"
if [[ $fail -eq 0 ]]; then
  echo " ✅ XONG ($ok/$((ok+fail)) thành phần)"
else
  echo " ⚠️  XONG nhưng thiếu $fail thành phần — xem log phía trên"
fi
cat <<'TXT'

 BƯỚC TIẾP THEO
   1. Đăng xuất (KHÔNG cần khởi động lại)
   2. Ở màn hình đăng nhập GDM, bấm bánh răng ⚙ góc dưới phải
   3. Chọn "Hyprland" -> đăng nhập

 PHÍM TẮT CƠ BẢN
   SUPER + Return     mở terminal
   SUPER + SPACE      tìm & mở ứng dụng
   SUPER + B / E      trình duyệt / quản lý file
   SUPER + W          đóng cửa sổ
   SUPER + 1..9       chuyển workspace
   SUPER + L          khoá màn hình
   SUPER + C          lịch sử clipboard
   Print              chụp vùng chọn
   SUPER + SHIFT + E  thoát Hyprland (về GDM)

 NẾU HỎNG: ở GDM chọn lại "GNOME" — GNOME còn nguyên, không mất gì.
 GỠ SẠCH:  sudo bash ~/hyprland-setup.sh --uninstall

TXT
echo "═══════════════════════════════════════════════════════════════"
