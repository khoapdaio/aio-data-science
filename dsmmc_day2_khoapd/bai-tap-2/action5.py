def view():
	isContinue = True
	while isContinue:
		print("----------Action5------------")
		try:
			numbers = [int(x) for x in input("Nhâp 2 số nguyên cách nhau bằng dấu phẩy không cách: ").split(',')]
			if len(numbers) != 2:
				print("Bạn cần nhập đúng 2 số nguyên. Vui lòng thử lại.")
				continue
			uscln = gcd(numbers[0], numbers[1])
			bscnn = lcm(numbers[0], numbers[1])
			print("Ước số chung lớn nhất của", numbers[0], "và", numbers[1], "là:", uscln)
			print("Bội số chung nhỏ nhất của", numbers[0], "và", numbers[1], "là:", bscnn)
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
		except ZeroDivisionError:
			print("Vui lòng nhập số thứ 2 khác 0 ")
	return None


def gcd(a, b):
	while b != 0:
		a, b = b, a % b
	return a


def lcm(a, b):
	return (a * b) // gcd(a, b)
