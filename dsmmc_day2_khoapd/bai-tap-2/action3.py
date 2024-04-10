def view():
	isContinue = True
	while isContinue:
		print("----------Action3------------")
		try:
			number = int(input("Hãy nhập số làm mốc: "))
			result = getPrimes(number)
			print("Các số nguyên tố nhỏ hơn {} cho trước: {} ".format(number, ','.join(map(str, result))))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def isPrime(num):
	if num <= 1:
		return False
	i = 2
	while i * i <= num:
		if num % i == 0:
			return False
		i += 1
	return True


def getPrimes(n):
	result = []
	begin = 2
	if n >= 1:
		result.append(1)
	while begin < n:
		if isPrime(begin):
			result.append(begin)
		begin += 1
	return result
