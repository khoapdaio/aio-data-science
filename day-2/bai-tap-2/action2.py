def view():
	isContinue = True
	while isContinue:
		print("----------Action2------------")
		try:
			number = int(input("Hãy nhập số cần phân tích: "))
			result = getThuaSoNguyenTo(number)
			print("Số {} được phân tích thành {}".format(number, 'x'.join(map(str, result))))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def getThuaSoNguyenTo(soChia):
	result = []
	soBiChia = 2
	while soChia > 1:
		# lọc số không phải số nguyên tố
		while soChia % soBiChia == 0:
			result.append(soBiChia)
			soChia //= soBiChia
		soBiChia += 1

	return result
