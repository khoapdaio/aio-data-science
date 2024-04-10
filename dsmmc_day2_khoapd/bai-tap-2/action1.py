def view():
	isContinue = True
	while isContinue:
		print("----------Action1------------")
		try:
			number = int(input("Hãy nhập số cần tính: "))
			sum = sumNumChar(number)
			print("Số {} có tổng các chữ số là: {}".format(number, sum))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def sumNumChar(number):
	result = 0
	while number != 0:
		lastNumber = number % 10
		number = number // 10
		result += lastNumber

	return result
