def view():
	isContinue = True
	while isContinue:
		print("----------Action2------------")
		try:
			number = int(input("Hãy nhập một số tự nhiên: "))
			ketQua = tinhGiaiThua(number)
			print("{}! có kết quả là: {} ".format(number, ketQua))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def tinhGiaiThua(number):
	result = 1
	for i in range(1, number + 1):
		result *= i
	return result
