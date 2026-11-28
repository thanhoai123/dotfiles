# dotfiles

Cấu hình cho bộ công cụ làm việc trong terminal: **tmux + Neovim (LazyVim) + lazygit**.

## Có gì trong repo

| Thư mục | Nội dung | Được liên kết tới |
|---|---|---|
| `nvim/` | Cấu hình LazyVim (extras: Python, Markdown) | `~/.config/nvim` |
| `tmux/tmux.conf` | `set -g mouse on`, còn lại là mặc định | `~/.tmux.conf` |
| `markdownlint/` | Tắt các luật markdownlint gây ồn | `~/.markdownlint-cli2.yaml` |
| `alacritty/` | Terminal, theme Catppuccin Mocha | `~/.config/alacritty` |
| `hypr/` | Hyprland + hyprlock + hypridle + hyprpaper | `~/.config/hypr` |
| `waybar/` | Thanh trạng thái | `~/.config/waybar` |
| `wofi/` | Launcher (tìm & mở ứng dụng) | `~/.config/wofi` |
| `mako/` | Thông báo | `~/.config/mako` |
| `scripts/` | `hyprland-setup.sh` — cài Hyprland trên Fedora | |
| `docs/` | Hướng dẫn phím tắt và cheat sheet (tiếng Việt) | |

## Dùng

```bash
git clone https://github.com/thanhoai123/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` chỉ tạo liên kết (symlink), **không cài phần mềm**. Nếu đã có file cấu hình cũ, nó được đổi tên thành `*.bak.<giờ>` trước khi liên kết.

## Cần cài trước

`git`, `tmux`, `neovim` (bản mới, LazyVim yêu cầu bản gần đây), `lazygit`, `ripgrep`, `fd`, `fzf`, `tree-sitter-cli`, và một Nerd Font ở máy bạn ngồi (để icon hiển thị).

- macOS: `brew install neovim git lazygit ripgrep fd fzf tmux tree-sitter-cli`
- Ubuntu/Debian: `apt` thường cho bản Neovim cũ; nên tải bản Neovim chính thức từ trang phát hành của họ. Kiểm tra bằng `nvim --version`.

Phần tmux/Neovim được kiểm tra trên macOS (Apple Silicon). Phần Hyprland chỉ dành cho Linux
và được viết riêng cho Fedora 45 trên Surface Laptop 4 (AMD) — xem mục dưới.

## Hyprland (chỉ Linux)

`install.sh` chỉ symlink các thư mục `hypr/ waybar/ wofi/ mako/` khi `uname -s` là `Linux`;
trên macOS nó bỏ qua. `alacritty/` thì symlink ở cả hai hệ.

### Cài trên Fedora

```bash
sudo bash ~/dotfiles/scripts/hyprland-setup.sh              # cài
sudo bash ~/dotfiles/scripts/hyprland-setup.sh --uninstall  # gỡ sạch
```

Script giữ nguyên GNOME làm phương án dự phòng — chọn desktop ở màn hình đăng nhập GDM.
Fedora 45 **không** đóng gói `hyprland`, nên script bật COPR `pm4rcin/Hyprland`
(fork của `solopasha/hyprland`, repo cá nhân) và chặn 4 package trùng tên với bản Fedora
(`cliphist matugen qt6ct quickshell`) để `dnf upgrade` không âm thầm thay chúng.

Cần thêm: một Nerd Font cho icon trên Waybar. Fedora không đóng gói JetBrainsMono Nerd Font,
tải từ [ryanoasis/nerd-fonts](https://github.com/ryanoasis/nerd-fonts/releases) rồi
giải nén vào `~/.local/share/fonts/` và chạy `fc-cache -f`.

### Phím tắt

| Phím | Việc |
|---|---|
| `SUPER + Return` | Terminal |
| `SUPER + SPACE` | Tìm & mở ứng dụng |
| `SUPER + B` / `E` | Trình duyệt / quản lý file |
| `SUPER + W` | Đóng cửa sổ |
| `SUPER + 1..9` | Chuyển workspace |
| `SUPER + L` | Khoá màn hình |
| `SUPER + C` | Lịch sử clipboard |
| `Print` | Chụp vùng chọn |
| `SUPER + SHIFT + E` | Thoát Hyprland |

### Chỗ cần sửa nếu dùng trên máy khác

- `hypr/hyprland.conf` — dòng `monitor =` đang đặt cho màn 2256x1504 (Surface Laptop 4 13.5")
  với `scale 1.6`. Máy khác phải đổi.
- `hypr/hyprland.conf` — dòng `env = XDG_DATA_DIRS,...` ghi cứng `/home/thanhoai123`.
  Biến này cần thiết để launcher thấy app Flatpak, vì GDM không chắc source
  `/etc/profile.d/flatpak.sh`. Đổi đường dẫn theo user của bạn.
- `waybar/config.jsonc` — `"bat": "BAT1"` và đường dẫn `hwmon` của k10temp
  (`/sys/devices/pci0000:00/0000:00:18.3/hwmon`) là riêng của máy này.
- `hypr/hypridle.conf` — **cố ý không có `suspend`**. Surface Laptop 4 AMD bị treo khi
  s2idle; việc gập nắp giao cho logind xử lý
  (`/etc/systemd/logind.conf.d/50-surface-lid.conf`, `HandleLidSwitch=lock`).
- Gõ tiếng Việt dùng `ibus-bamboo`, khởi động bằng `exec-once` trong `hyprland.conf`
  (GNOME tự chạy ibus, Hyprland thì không). Nếu lỗi trên Wayland, chuyển sang
  `fcitx5` + `fcitx5-unikey`.

## Ghi chú

- `lazy-lock.json` ghim phiên bản plugin; chạy `:Lazy restore` trong Neovim nếu muốn đúng phiên bản đã khóa.
- Phím Ctrl+mũi tên bị macOS chiếm, nên đổi cỡ ô trong Neovim dùng `<Space> w>` `w<` `w+` `w-` `w=`.
