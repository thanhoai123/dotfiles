# Hướng dẫn tmux, Neovim (LazyVim), lazygit

> `<Space>` = phím cách (leader của LazyVim). `Ctrl-b` = tiền tố của tmux: **nhấn Ctrl-b, thả ra, rồi nhấn phím tiếp theo**.
> Quên phím LazyVim thì nhấn `<Space>` và chờ 1 giây. Quên phím tmux thì `Ctrl-b ?`. Quên phím lazygit thì `?`.

---

## 1. tmux

Cấu hình hiện tại (`~/.tmux.conf`) chỉ có `set -g mouse on`, mọi thứ khác là mặc định.

### Dòng lệnh

| Lệnh | Việc |
|---|---|
| `tmux` | tạo session mới |
| `tmux new -s game` | tạo session tên `game` |
| `tmux ls` | xem các session |
| `tmux attach -t game` (hoặc `tmux a`) | vào lại session |
| `tmux kill-session -t game` | tắt một session |
| `tmux kill-server` | tắt mọi session |

### Phím (sau Ctrl-b)

| Việc | Phím |
|---|---|
| Chia ô sang **phải** | `%` |
| Chia ô xuống **dưới** | `"` |
| Chuyển ô | mũi tên, hoặc `o` (ô kế tiếp) |
| Phóng to / thu ô đang đứng | `z` |
| Đóng ô | `x` rồi `y` |
| Đổi chỗ ô | `{` hoặc `}` |
| Cửa sổ (window) mới | `c` |
| Cửa sổ kế / trước | `n` / `p` |
| Tới cửa sổ số 0..9 | `0`..`9` |
| Đổi tên cửa sổ | `,` |
| Đóng cửa sổ | `&` rồi `y` |
| Xem danh sách session/cửa sổ | `s` / `w` |
| Đổi tên session | `$` |
| Rời session (chạy nền) | `d` |
| Xem tất cả phím | `?` |
| Gõ lệnh tmux | `:` |

Cửa sổ đánh số từ **0** (mặc định).

### Chuột (đã bật)
Nhấp để chọn ô, kéo viền để đổi kích thước, cuộn bằng con lăn, nhấp tên cửa sổ ở thanh dưới để chuyển.

### Copy / paste
- Copy bằng chuột: kéo bôi đen. Dán trong tmux: `Ctrl-b ]`.
- Chữ copy bằng chuột nằm trong bộ nhớ tmux; có vào được clipboard macOS (`Cmd-V`) hay không **tùy terminal bạn dùng** (chưa kiểm tra trên máy bạn). Không được thì dùng `Ctrl-b ]`.
- Copy bằng bàn phím (chế độ mặc định kiểu emacs): `Ctrl-b [` vào chế độ copy, di chuyển bằng mũi tên, `Ctrl-Space` bắt đầu chọn, `Ctrl-w` copy và thoát, `q` thoát không copy. Dán: `Ctrl-b ]`.
- Tìm trong chế độ copy: `Ctrl-s`.

---

## 2. Neovim + LazyVim

### Mở file (ngoài terminal)

| Lệnh | Việc |
|---|---|
| `nvim tên-file` | mở một file (chưa có thì tạo khi lưu) |
| `nvim .` | mở thư mục hiện tại |
| `nvim file1 file2` | mở nhiều file |
| `nvim +34 tên-file` | mở và nhảy tới dòng 34 |

### Sống sót (học trước)

| Phím | Việc |
|---|---|
| `Esc` | về Normal mode (kẹt thì cứ nhấn) |
| `i` / `a` | gõ chữ trước / sau con trỏ |
| `o` / `O` | mở dòng mới dưới / trên rồi gõ |
| `Ctrl-s` | lưu file |
| `:w` `:q` `:wq` `:q!` | lưu / thoát / lưu và thoát / thoát bỏ thay đổi |
| `<Space> qq` | thoát tất cả |
| `u` / `Ctrl-r` | undo / redo |

Chú ý: `:q` khi file chưa lưu có thể đóng cửa sổ mà không hỏi; thoát an toàn dùng `<Space> qq`.

### Di chuyển

| Phím | Việc |
|---|---|
| `h` `j` `k` `l` | trái, xuống, lên, phải |
| `w` / `b` | từ sau / từ trước |
| `0` / `$` | đầu / cuối dòng |
| `gg` / `G` | đầu / cuối file |
| `:34` Enter | tới dòng 34 |
| `Ctrl-d` / `Ctrl-u` | cuộn nửa trang xuống / lên |
| `s` + 2 ký tự | flash: nhảy tới bất kỳ đâu trên màn hình |
| `Ctrl-o` | quay lại vị trí trước |

### Sửa chữ

| Phím | Việc |
|---|---|
| `dd` / `yy` / `p` | xóa / copy / dán dòng |
| `dw` | xóa một từ |
| `ciw` | đổi từ đang đứng |
| `ci"` | đổi nội dung trong `"..."` |
| `v` / `V` | chọn ký tự / chọn dòng (rồi `y` `d` `>` `<`) |
| `.` | lặp lại thao tác vừa làm |
| `gcc` | comment / bỏ comment dòng |

### File, tìm kiếm, buffer

| Phím | Việc |
|---|---|
| `<Space> <Space>` | tìm file theo tên |
| `<Space> /` | tìm chữ trong cả project |
| `<Space> fr` | file mở gần đây |
| `<Space> ,` | chuyển giữa các file đang mở |
| `<Space> e` | cây thư mục |
| `/chữ` Enter, `n` / `N` | tìm trong file, kết quả sau / trước |
| `Shift-h` / `Shift-l` | file (buffer) trước / sau |
| `<Space> bd` | đóng file hiện tại |
| `Ctrl-h` / `Ctrl-l` | qua lại giữa cây thư mục và file |

Trong cây thư mục (`<Space> e`): `a` tạo file (kết thúc bằng `/` là tạo thư mục), `r` đổi tên, `d` xóa, `?` xem tất cả phím. Hiện file ẩn (`.env`, `.git`) bằng `H` trong cây thư mục (phím đổi theo phiên bản; `?` để xác nhận).

### Chia ô trong Neovim (window)

| Phím | Việc |
|---|---|
| `<Space> \|` | chia dọc |
| `<Space> -` | chia ngang |
| `Ctrl-h/j/k/l` | chuyển ô |
| `<Space> wd` | đóng ô |
| `<Space> w>` / `w<` / `w+` / `w-` / `w=` | rộng / hẹp / cao / thấp / cân bằng (cấu hình riêng của bạn) |

### Code (Python, Markdown...)

| Phím | Việc |
|---|---|
| `gd` | nhảy tới định nghĩa (`Ctrl-o` quay lại) |
| `K` | xem tài liệu / kiểu dữ liệu |
| `<Space> cr` | đổi tên biến/hàm ở mọi nơi |
| `<Space> ca` | gợi ý sửa nhanh |
| `<Space> cf` | format code |
| `]d` / `[d` | lỗi sau / trước |
| `<Space> cd` | chi tiết lỗi tại dòng |
| `<Space> xx` | danh sách tất cả lỗi |
| `<Space> cv` | chọn môi trường ảo Python |
| `Ctrl-/` | bật/tắt terminal trong Neovim |
| `<Space> cp` | preview Markdown trên trình duyệt |
| `<Space> um` | bật/tắt render Markdown trong Neovim |

### Công cụ

| Phím / lệnh | Việc |
|---|---|
| `<Space> l` | quản lý plugin (Lazy); `U` cập nhật, `q` đóng |
| `<Space> cm` | Mason: cài LSP, formatter |
| `:LazyExtras` | bật thêm hỗ trợ ngôn ngữ (`x` bật/tắt) |
| `:Tutor` | bài học Vim tương tác |
| `<Space> sk` | tìm phím theo từ khóa |

Nhóm phím sau `<Space>`: `f` file · `s` search · `g` git · `c` code · `x` lỗi · `b` buffer · `u` bật/tắt · `q` thoát/phiên.

---

## 3. lazygit

Mở: gõ `lazygit` trong terminal, hoặc `<Space> gg` trong LazyVim. Thoát: `q`.

Giao diện gồm các khung; chuyển bằng phím số hoặc `h`/`l`: `1` Status · `2` Files · `3` Branches · `4` Commits · `5` Stash.

### Quy trình cơ bản: lưu và đẩy code lên

1. Vào khung **Files** (`2`).
2. `Space` chọn (stage) từng file, hoặc `a` chọn tất cả.
3. `c` viết thông điệp commit, `Enter` để xác nhận.
4. `P` (chữ P **hoa**) để **push** lên origin.

### Phím thường dùng

| Phím | Việc |
|---|---|
| `Space` | stage / bỏ stage file |
| `a` | stage / bỏ stage tất cả |
| `c` | commit |
| `P` | **push** (đẩy lên) |
| `p` | **pull** (kéo về) |
| `f` | fetch |
| `Enter` | xem chi tiết file / commit |
| `d` | bỏ thay đổi của file (hỏi xác nhận) |
| `z` | hoàn tác (undo) |
| `n` | tạo nhánh mới (ở khung Branches) |
| `Space` (ở Branches) | chuyển sang nhánh đó |
| `/` | tìm / lọc |
| `?` | xem tất cả phím của khung đang đứng |
| `q` | thoát |

Phím lazygit ở trên lấy từ mặc định thông dụng; lần đầu dùng hãy nhấn `?` để xác nhận. Lần push đầu tiên của nhánh mới có thể hỏi đặt "upstream", cứ xác nhận theo hướng dẫn trên màn hình.

---

## 4. Bố cục làm việc gợi ý (project game)

```text
tmux new -s game          # tạo session
Ctrl-b %                  # chia phải
Ctrl-b "                  # chia ô phải xuống dưới
```

- Ô trái: `nvim .`
- Ô phải trên: `claude`
- Ô phải dưới: `node server/server.mjs`
- Cần git: `<Space> gg` trong Neovim.
- Xong việc: `Ctrl-b d` rời session; hôm sau `tmux a -t game`.
