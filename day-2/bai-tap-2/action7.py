from action3 import isPrime


def view():
	isContinue = True
	while isContinue:
		print("----------Action7------------")
		try:
			number = int(input("Hãy nhập số nguyên: "))
			result = getListFibonacci(number)
			print("các số Fibonaci nhỏ hơn {} là số nguyên tố: {}".format(number, ','.join(map(str, result))))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập số nguyên.")
		except Exception:
			print("Không có số Fibonacci cho n <= 0")
	return None


def getListFibonacci(number):
	result = []
	i = 1
	fibonacciNumb = 0
	while fibonacciNumb < number:
		fibonacciNumb = getFibonacci(i)
		if fibonacciNumb > number:
			break
		if isPrime(fibonacciNumb):
			result.append(fibonacciNumb)
		i += 1
	return result


def getFibonacci(n):
	if n <= 0:
		raise Exception()
	elif n == 1:
		return 0
	elif n == 2:
		return 1
	else:
		return getFibonacci(n - 1) + getFibonacci(n - 2)
