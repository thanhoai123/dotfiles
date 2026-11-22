# dotfiles

Cấu hình cho bộ công cụ làm việc trong terminal: **tmux + Neovim (LazyVim) + lazygit**.

## Có gì trong repo

| Thư mục | Nội dung | Được liên kết tới |
|---|---|---|
| `nvim/` | Cấu hình LazyVim (extras: Python, Markdown) | `~/.config/nvim` |
| `tmux/tmux.conf` | `set -g mouse on`, còn lại là mặc định | `~/.tmux.conf` |
| `markdownlint/` | Tắt các luật markdownlint gây ồn | `~/.markdownlint-cli2.yaml` |
| `zsh/aliases.zsh` | Lệnh tắt `md` (đọc Markdown bằng glow) | nạp qua một dòng thêm vào `~/.zshrc` |
| `docs/` | Hướng dẫn phím tắt và cheat sheet (tiếng Việt) | |

## Dùng

```bash
git clone https://github.com/thanhoai123/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` tạo liên kết (symlink) và thêm một dòng nạp `zsh/aliases.zsh` vào `~/.zshrc` (chỉ thêm một lần). Nó **không cài phần mềm**. Nếu đã có file cấu hình cũ, nó được đổi tên thành `*.bak.<giờ>` trước khi liên kết.

## Cần cài trước

`git`, `tmux`, `glow` (cho lệnh `md`), `neovim` (bản mới, LazyVim yêu cầu bản gần đây), `lazygit`, `ripgrep`, `fd`, `fzf`, `tree-sitter-cli`, và một Nerd Font ở máy bạn ngồi (để icon hiển thị).

- macOS: `brew install neovim git lazygit ripgrep fd fzf tmux tree-sitter-cli glow`
- Ubuntu/Debian: `apt` thường cho bản Neovim cũ; nên tải bản Neovim chính thức từ trang phát hành của họ. Kiểm tra bằng `nvim --version`.

Cấu hình này mới được kiểm tra trên macOS (Apple Silicon). Chưa kiểm tra trên Linux hay server.

## Ghi chú

- `lazy-lock.json` ghim phiên bản plugin; chạy `:Lazy restore` trong Neovim nếu muốn đúng phiên bản đã khóa.
- Phím Ctrl+mũi tên bị macOS chiếm, nên đổi cỡ ô trong Neovim dùng `<Space> w>` `w<` `w+` `w-` `w=`.
