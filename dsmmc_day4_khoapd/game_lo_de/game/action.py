import random
from datetime import datetime

from dsmmc_day4_khoapd.game_lo_de import auth, data

PATH_DATA_GAME = 'O:\Git\\aio-data-science\data\data_game.txt'


def play():
	try:
		cash = int(auth.getCurrentUser()[2])

		isContinue = True
		while isContinue:
			if cash == 0:
				print("Tiền của bạn là 0, xin hãy nạp tiền")
				return
			soLoCuoc = getSoLoCuoc()

			tienCuoc = nhapTienCuoc(cash)
			if tienCuoc > cash: return

			print("--------------------")
			print("---DANH SÁCH GIẢI---")
			dsGiai = getDsGiai()
			print("---------------------")
			getKetQua(dsGiai, tienCuoc, soLoCuoc)

			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False

	except ValueError:
		print("Vui lòng nhập một số nguyên.")


def nhapTienCuoc(cash):
	isContinue = True
	tienCuoc = 0
	while isContinue:
		try:
			tienCuoc = int(input("Nhập tiền cược mà bn muốn cược (Tiền cược < tổng tiền bạn có):  "))
			if tienCuoc > cash:
				print("Số tiền cược lớn hơn tồng tiền bạn có ")
				isContinue = True
			else:
				isContinue = False
		except:
			print("Nhập sai định dạng tiền cược.Nhập lại")
	return tienCuoc


def getSoLoCuoc():
	isContinue = True
	soLoCuoc = None
	while isContinue:
		try:
			soLoCuoc = input("Nhập số lô mà bạn muốn chơi, cách nhau bằng dấu phẩy: ")
			soLoCuoc = [int(i) for i in soLoCuoc.split(',')]
			return soLoCuoc
		except ValueError:
			print("Nhập số lô sai định dạng.Nhập lại")
			isContinue = True
	return soLoCuoc


def getDsGiai():
	dsGiai = list()
	ds_ten_giai = ["GIẢI NHẤT", "GIẢI NHÌ", "GIẢI BA", "GIẢI TƯ", "GIẢI NĂM", "GIẢI SÁU", "GIẢI BẢY"]
	for ten_giai in ds_ten_giai:
		ketQua = ""
		for i in range(5):
			ketQua += str(random.randint(0, 9))
		print(f"{ten_giai}: {ketQua}")
		dsGiai.append(ketQua)
	return dsGiai


def getKetQua(dsGiai, tienCuoc, dsSoLoCuoc):
	demSoLo = 0
	dsSoLoTrung = []
	for ketQua in dsGiai:
		for soLoCuoc in dsSoLoCuoc:
			if soLoCuoc == ketQua[-2:]:
				demSoLo += 1
				dsSoLoTrung.append(soLoCuoc)

	if demSoLo == 0:
		tienThuaCuoc = tienCuoc * len(dsSoLoCuoc)
		auth.addMoney(-tienThuaCuoc)
		saveHistory(0, tienThuaCuoc, dsSoLoCuoc, dsGiai)
		print("Bạn đã thua lô")
		print(f"Số tiền bạn thua là {tienThuaCuoc}")
		print(f"Tổng tiền bạn còn là {auth.getMoney()}")
	else:
		tienThangCuoc = tienCuoc * demSoLo * 70
		tienThuaCuoc = tienCuoc * (len(dsSoLoCuoc) - len(dsSoLoTrung))
		auth.addMoney(tienThangCuoc - tienThuaCuoc)
		saveHistory(tienThangCuoc, tienThangCuoc, dsSoLoCuoc, dsGiai)
		print(f"Bạn đã trúng {demSoLo} nháy!")
		print("Các số lô trúng là: " + ",".join(dsSoLoTrung))
		print(f"Số tiền bạn trúng là {tienThangCuoc}")
		print(f"Số tiền bạn thua là {tienThuaCuoc}")
		print(f"Tổng tiền bạn có là {auth.getMoney()}")


def saveHistory(tienThang, tienThua, dsSoLoCuoc, dsGiai):
	username = auth.getCurrentUser()[0]
	dataGame = f"{datetime.now().strftime('%Y-%m-%d %H:%M:%S')},{username},{tienThang},{tienThua},{dsSoLoCuoc},{dsGiai}\n"
	data.write([dataGame], PATH_DATA_GAME)
