# LazyVim Cheat Sheet (1 trang)

`<Space>` = phím cách. **Quên phím?** Nhấn `<Space>` và chờ 1 giây, hoặc `<Space> sk` để tìm phím theo từ khóa.

## 1. Sống sót (học trước)

| Phím | Việc |
|---|---|
| `Esc` | về Normal mode (kẹt thì cứ nhấn) |
| `i` / `a` | gõ chữ trước / sau con trỏ |
| `o` / `O` | mở dòng mới dưới / trên rồi gõ |
| `Ctrl-s` | lưu file |
| `:w` `:q` `:wq` `:q!` | lưu / thoát / lưu và thoát / thoát bỏ thay đổi |
| `<Space> qq` | thoát tất cả |
| `u` / `Ctrl-r` | undo / redo |

## 2. Di chuyển

| Phím | Việc |
|---|---|
| `h` `j` `k` `l` | trái, xuống, lên, phải |
| `w` / `b` | từ sau / từ trước |
| `0` / `$` | đầu / cuối dòng |
| `gg` / `G` | đầu / cuối file |
| `:34` Enter | tới dòng 34 |
| `Ctrl-d` / `Ctrl-u` | cuộn nửa trang xuống / lên |
| `s` + 2 ký tự | **flash**: nhảy tới bất kỳ đâu trên màn hình |
| `Ctrl-o` | quay lại vị trí trước |

## 3. Sửa chữ

| Phím | Việc |
|---|---|
| `dd` / `yy` / `p` | xóa / copy / dán dòng |
| `dw` | xóa một từ |
| `ciw` | đổi từ đang đứng |
| `ci"` | đổi nội dung trong `"..."` |
| `v` / `V` | chọn ký tự / chọn dòng (rồi `y` `d` `>` `<`) |
| `.` | lặp lại thao tác vừa làm |
| `gcc` | comment / bỏ comment dòng |

## 4. Tìm kiếm và file

| Phím | Việc |
|---|---|
| `<Space> <Space>` | tìm file theo tên |
| `<Space> /` | tìm chữ trong cả project |
| `<Space> fr` | file mở gần đây |
| `<Space> ,` | chuyển giữa các file đang mở |
| `<Space> e` | cây thư mục (trong cây: `a` tạo, `r` đổi tên, `d` xóa, `?` xem phím) |
| `/chữ` Enter, `n` / `N` | tìm trong file, tới kết quả sau / trước |
| `Shift-h` / `Shift-l` | file (buffer) trước / sau |
| `<Space> bd` | đóng file hiện tại |
| `Ctrl-h` / `Ctrl-l` | qua lại giữa cây thư mục và file |

## 5. Code (Python, Markdown...)

| Phím | Việc |
|---|---|
| `gd` | nhảy tới định nghĩa (`Ctrl-o` để quay lại) |
| `K` | xem kiểu dữ liệu / tài liệu |
| `<Space> cr` | đổi tên biến/hàm ở mọi nơi |
| `<Space> ca` | gợi ý sửa nhanh (code action) |
| `<Space> cf` | format code |
| `]d` / `[d` | tới lỗi sau / trước |
| `<Space> cd` | xem chi tiết lỗi tại dòng |
| `<Space> xx` | danh sách tất cả lỗi |
| `<Space> cv` | chọn môi trường ảo Python |
| `Ctrl-/` | bật/tắt terminal trong Neovim |

## 6. Git, công cụ, Markdown

| Phím | Việc |
|---|---|
| `<Space> gg` | mở lazygit |
| `<Space> l` | quản lý plugin (Lazy). Trong đó `U` cập nhật, `q` đóng |
| `<Space> cm` | Mason: cài LSP, formatter |
| `<Space> cp` | preview Markdown trên trình duyệt |
| `<Space> um` | bật/tắt render Markdown trong Neovim |
| `:LazyExtras` | bật thêm hỗ trợ ngôn ngữ (`x` để bật/tắt) |
| `:Tutor` | bài học Vim tương tác (30 phút) |

## 7. Mẹo nhớ nhóm phím sau `<Space>`

`f` file · `s` search · `g` git · `c` code · `x` lỗi · `b` buffer · `u` bật/tắt · `q` thoát/phiên

## Lộ trình

- **Tuần 1:** chỉ mục 1, 2, 3. Gặp gì quên thì nhấn `<Space>`.
- **Tuần 2:** thêm mục 4 và 5.
- **Sau đó:** mỗi tuần học 2–3 phím mới, ưu tiên phím bạn đang làm thủ công.
