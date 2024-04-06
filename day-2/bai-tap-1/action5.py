def view():
	isContinue = True
	while isContinue:
		print("----------Action5------------")
		try:
			numbers = [int(x) for x in input("Nhâp 2 số nguyên cách nhau bằng dấu phẩy không cách: ").split(',')]
			if len(numbers) != 2:
				print("Bạn cần nhập đúng 4 số nguyên. Vui lòng thử lại.")
				continue
			result = isChiaHet(numbers[0], numbers[1])
			if result:
				print("Số {} chia hết cho số {}.".format(numbers[0], numbers[1]))
			else:
				print("Số {} không chia hết cho số {}.".format(numbers[0], numbers[1]))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
		except ZeroDivisionError:
			print("Vui lòng nhập số thứ 2 khác 0 ")
	return None


def isChiaHet(a, b):
	if b == 0:
		raise ZeroDivisionError
	return a % b == 0
