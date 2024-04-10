def view():
	isContinue = True
	while isContinue:
		print("----------Action3------------")
		try:
			numbers = [int(x) for x in input("Nhâp 4 số nguyên cách nhau bằng dấu phẩy không cách: ").split(',')]
			if len(numbers) != 4:
				print("Bạn cần nhập đúng 4 số nguyên. Vui lòng thử lại.")
				continue
			max_num, min_num = find_max_min(numbers)
			print("Số lớn nhất là:", max_num)
			print("Số nhỏ nhất là:", min_num)
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def find_max_min(numbers):
	max_num = max(numbers)
	min_num = min(numbers)
	return max_num, min_num
