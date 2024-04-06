def view():
	isContinue = True
	while isContinue:
		print("----------Action6------------")
		try:
			diem_toan = float(input("Nhập điểm môn Toán: "))
			if diem_toan == 0.0 or diem_toan > 10.0:
				print("Điểm toán phải nằm trong khoảng 0-10")
				continue
			diem_vat_ly = float(input("Nhập điểm môn Lý: "))
			if diem_vat_ly == 0.0 or diem_vat_ly > 10.0:
				print("Điểm vật lý phải nằm trong khoảng 0-10")
				continue
			diem_hoa = float(input("Nhập điểm môn Hóa: "))
			if diem_hoa == 0.0 or diem_hoa > 10.0:
				print("Điểm hoa phải nằm trong khoảng 0-10")
				continue
			diem_tb = tinh_diem_tb(diem_toan, diem_vat_ly, diem_hoa)
			hoc_luc = xac_dinh_xep_loai(diem_tb)
			print("Điểm trung bình: {:.2f}".format(diem_tb))
			print("Học lực của học sinh: ", hoc_luc)
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập số nguyên.")
	return None


def tinh_diem_tb(diem_toan, diem_vat_ly, diem_hoa):
	return (diem_toan * 2 + diem_vat_ly + diem_hoa) / 4


def xac_dinh_xep_loai(diem_tb):
	if diem_tb >= 9.0:
		return "Xuất sắc"
	elif 8.0 <= diem_tb < 9.0:
		return "Giỏi"
	elif 7.0 <= diem_tb < 8.0:
		return "Khá"
	elif 6.0 <= diem_tb < 7.0:
		return "Trung bình khá"
	elif 5.0 <= diem_tb < 6.0:
		return "Trung bình"
	else:
		return "Kém"
