from action3 import isPrime


def view():
	isContinue = True
	while isContinue:
		print("----------Action4------------")
		try:
			number = int(input("Hãy nhập số làm mốc: "))
			result = getPrimes(number)
			print("{} số nguyên tố đầu tiên: {} ".format(number, ','.join(map(str, result))))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None





def getPrimes(n):
	result = []
	begin = 2
	if n >= 1:
		result.append(1)
	while len(result) <= n:
		if isPrime(begin):
			result.append(begin)
		begin += 1
	return result
