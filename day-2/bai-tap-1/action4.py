def view():
	isContinue = True
	while isContinue:
		print("----------Action4------------")
		try:
			numbers = [int(x) for x in input("Nhâp 2 số nguyên cách nhau bằng dấu phẩy không cách: ").split(',')]
			if len(numbers) != 2:
				print("Bạn cần nhập đúng 4 số nguyên. Vui lòng thử lại.")
				continue
			result = compare(numbers[0], numbers[1])
			if result == 1:
				print("Số thứ nhất lớn hơn số thứ hai.")
			elif result == -1:
				print("Số thứ nhất nhỏ hơn số thứ hai.")
			else:
				print("Số thứ nhất bằng số thứ hai.")
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def compare(a, b):
	if a > b:
		return 1
	if a < b:
		return -1
	return 0
