# Nhận dạng nguyên âm không phụ thuộc người nói dùng đặc trưng phổ FFT


Input: 
tín hiệu tiếng nói (chứa 01 nguyên âm và khoảng lặng) của tập kiểm thử (thư mục NguyenAmKiemThu-16k gồm 21 người, 105 file test).

Output: 
-	Kết quả nhận dạng (dự đoán) nhãn nguyên âm của mỗi file test (/a/, …,/u/), Đúng/Sai (dựa vào nhãn tên file).
-	Xuất 05 vector đặc trưng biểu diễn 05 nguyên âm trên cùng 01 đồ thị.
-	Bảng thống kê độ chính xác nhận dạng tổng hợp (%) theo số chiều của vector đặc trưng (là số điểm lấy mẫu trên miền tần số N_FFT với 03 giá trị 512, 1024, 2048).
-	Ma trận nhầm lẫn (confusion matrix) của trường hợp có độ chính xác tổng hợp cao nhất trong 3 giá trị N_FFT trên: ma trận này thống kê số lần nhận dạng đúng/sai của mỗi cặp nguyên âm (có highlight nguyên âm đc nhận dạng đúng và bị nhận dạng sai nhiều nhất) theo format sau:

<img src="https://github.com/NT912/NhanDangNguyenAmKhongPhuThuocNguoiNoi-DungDacTrungPhoFFT/blob/main/img/maTranNhamLan.png">

Dữ liệu sử dụng để thiết lập và hiệu chỉnh các thông số của thuật toán: 
tín hiệu tiếng nói (mỗi tín hiệu chứa 01 nguyên âm ở giữa và 2 khoảng lặng ở 2 đầu) của tập huấn luyện (thư mục NguyenAmHuanLuyen gồm 21 người, 105 file huấn luyện).

Yêu cầu:
Cài đặt BT nhận dạng theo mô hình tương tự như BT tìm kiếm âm thanh (trong TLTK [4]) gồm 3 thuật toán sau:
1.	Phân đoạn tín hiệu thành nguyên âm và khoảng lặng (slide Chapter6_SPEECH SIGNAL PROCESSING).
2.	Trích xuất vector đặc trưng phổ của 05 nguyên âm dựa trên tập huấn luyện (gồm 21 người, 105 file huấn luyện):
a.	Đánh dấu vùng có đặc trưng phổ ổn định đặc trưng cho nguyên âm: chia vùng chứa nguyên âm tìm được ở bước 1 thành 3 đoạn có độ dài bằng nhau và lấy đoạn nằm giữa (giả sử gồm M khung).
b.	Trích xuất vector FFT của 1 khung tín hiệu với số chiều là N_FFT (=512, 1024, 2048) dùng các hàm thư viện.
c.	Tính vector đặc trưng cho 1 nguyên âm của 1 người nói = Trung bình cộng của M vector FFT của M khung thuộc vùng ổn định.
d.	Tính vector đặc trưng cho 1 nguyên âm của nhiều người nói = Trung bình cộng của các vector đặc trưng cho 1 nguyên âm của 21 người nói (trong tập huấn luyện).
3.	So khớp vector FFT của tín hiệu nguyên âm đầu vào (thuộc tập kiểm thử) với 5 vector đặc trưng đã trích xuất của 5 nguyên âm (dựa trên tập huấn luyện) để đưa ra kết quả nhận dạng nguyên âm bằng cách tính 5 khoảng cách Euclidean giữa 2 vector và đưa ra quyết định nhận dạng dựa trên k/c nhỏ nhất (hàm này SV tự cài đặt).

TLTK:
[1] Hands-on lab on Speech Processing-Frequency-domain processing_2021 (phần 1 về spectrogram).
[4]CITA_SoSanhPhuongPhapDuongBaoPhovaPhuongPhapAnhPhoTrongTimKiemAmNhac_2021 (phần 2 về mô hình của BT tìm kiếm/nhận dạng dựa trên so khớp mẫu).

<h1>Algorithm Example</h1>
<img src="https://github.com/NT912/NhanDangNguyenAmKhongPhuThuocNguoiNoi-DungDacTrungPhoFFT/blob/main/img/AlgorithmMain.png">
