import random

from recharge import getMoney
from recharge import addMoney


def view():
	try:
		cash = int(getMoney())

		isContinue = True

		while isContinue:
			if cash == 0:
				print("Tiền của bạn là 0, xin hãy nạp tiền")
				return

			tienCuoc = nhapTienCuoc(cash)
			if tienCuoc > cash: return

			soLoCuoc = getSoLoCuoc()
			if soLoCuoc > 99 or soLoCuoc < 10: return

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
		tienCuoc = int(input("Nhập tiền cược mà bn muốn cược (Tiền cược < tổng tiền bạn có):  "))
		if tienCuoc > cash:
			print("Số tiền cược lớn hơn tồng tiền bạn có ")
			choice = int(input("Bạn có muốn nhập lại không (nhập 1(có), 2(không)): "))
			if choice == 1:
				isContinue = True
		else:
			isContinue = False
	return tienCuoc


def getSoLoCuoc():
	isContinue = True
	soLoCuoc = 0
	while isContinue:
		soLoCuoc = int(input("Nhập số lô mà bạn muốn cược(10-99): "))
		if soLoCuoc > 99 or soLoCuoc < 10:
			print("Số lô phải nằm trong 10-99  ")
			choice = int(input("Bạn có muốn nhập lại không (nhập 1(có), 2(không)): "))
			if choice == 1:
				isContinue = True
		else:
			isContinue = False

	return soLoCuoc


def getDsGiai():
	dsGiai = list()
	for i in range(8):
		ketQua = random.randint(10, 99)
		print(f"Giải {i + 1}: {ketQua}")
		dsGiai.append(ketQua)
	return dsGiai


def getKetQua(dsGiai, tienCuoc, soLoCuoc):
	tienThangCuoc = 0
	demSoLo = 0
	for ketQua in dsGiai:
		if soLoCuoc == ketQua:
			demSoLo += 1

	if tienThangCuoc == 0:
		addMoney(-tienCuoc)
		print("Bạn đã thua lô")
		print(f"Tổng tiền bạn còn là {getMoney()}")
	else:
		tienThangCuoc = tienCuoc * demSoLo * 70
		addMoney(tienThangCuoc)
		print(f"Bạn đã trúng {demSoLo} nháy!")
		print(f"Số tiền bạn trúng là {tienThangCuoc}")
		print(f"Tổng tiền bạn có là {getMoney()}")
	pass
