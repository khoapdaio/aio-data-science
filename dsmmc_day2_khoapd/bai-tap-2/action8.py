from action1 import sumNumChar
from action2 import getThuaSoNguyenTo


def view():
	isContinue = True
	while isContinue:
		print("----------Action8------------")
		try:
			number = int(input("Hãy nhập số cần tính: "))
			sum = sumNumChar(number)
			danhSachThuaSo = getThuaSoNguyenTo(number)
			print("Số {} có tổng các chữ số là: {}".format(number, sum))
			print("Số {} có các thừa số: {}".format(number, ','.join(map(str, danhSachThuaSo))))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None
