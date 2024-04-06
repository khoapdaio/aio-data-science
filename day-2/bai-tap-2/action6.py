def view():
	isContinue = True
	while isContinue:
		print("----------Action6------------")
		try:
			number = int(input("Hãy nhập số nguyên: "))
			result = getFibonacci(number)
			print("Số Fibonacci thứ {} là: {}".format(number, result))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập số nguyên.")
		except Exception:
			print("Không có số Fibonacci cho n <= 0")
	return None


def getFibonacci(n):
	if n <= 0:
		raise Exception()
	elif n == 1:
		return 0
	elif n == 2:
		return 1
	else:
		return getFibonacci(n - 1) + getFibonacci(n - 2)
