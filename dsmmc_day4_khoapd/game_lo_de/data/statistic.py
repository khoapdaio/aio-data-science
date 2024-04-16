from dsmmc_day4_khoapd.game_lo_de import auth, data, game


def doStatistic():
	if auth.getCurrentUser() and auth.isAdmin(auth.getCurrentUser()[0]):
		return doStatisticAdmin()
	return doStatisticUser()


def doStatisticAdmin():
	try:
		# Đọc dữ liệu từ file choilo.txt
		duLieuChoiLo = data.read(game.PATH_DATA_GAME)
		lstAccount = len(data.read(auth.PATH_DATA_TAI_KHOAN))

		tongSoLanChoiLo = len(duLieuChoiLo)
		tongTienThang = sum(int(element[2]) for element in duLieuChoiLo)
		tongTienThua = sum(int(element[3]) for element in duLieuChoiLo)
		soLanThang = sum(1 for element in duLieuChoiLo if int(element[2]) > 0)
		soLanThua = tongSoLanChoiLo - soLanThang

		# Tính tỷ lệ thắng/thua
		tiLe = round(soLanThang / soLanThua, 2) if soLanThua > 0 else 0

		# In kết quả thống kê
		print("===THỐNG KÊ TỔNG HỢP===")
		print("Số lượng tài khoản:", lstAccount)
		print("Tổng số lượt chơi lô:", tongSoLanChoiLo)
		print("Tổng tiền chơi lô thắng:", tongTienThang)
		print("Tổng tiền chơi lô thua:", tongTienThua)
		print("Tỉ lệ thắng/thua:", tiLe)

	except Exception as e:
		print(f"Có lỗi xảy ra khi thực hiện thống kê tổng hợp: {e}")


def doStatisticUser():
	try:
		duLieuChoiLo = data.read(game.PATH_DATA_GAME)
		username = auth.getCurrentUser()[0]
		soLanChoi = 0
		tongTienThang = 0
		tongTienThua = 0
		soLanThang = 0
		soLanThua = 0
		tongTien = auth.getMoney()
		for element in duLieuChoiLo:
			if element[1] == username:
				soLanChoi += 1
				tongTienThang += int(element[2])
				tongTienThua += int(element[3])
				if int(element[2]) > 0:
					soLanThang += 1
				else:
					soLanThua += 1

		ti_le_thang = round(soLanThang / soLanThua, 2) if soLanThua > 0 else 0

		# In kết quả
		print("===THỐNG KÊ CHƠI LÔ USER: " + username + "===")
		print("Số tiền đang có trong tài khoản:", tongTien)
		print("Số lần chơi lô:", soLanChoi)
		print("Tổng tiền chơi lô thắng:", tongTienThang)
		print("Tổng tiền chơi lô thua:", tongTienThua)
		print("Tỉ lệ chơi lô thắng:", ti_le_thang)

	except Exception as e:
		print(f"Có lỗi xảy ra khi thực hiện thống kê: {e}")
