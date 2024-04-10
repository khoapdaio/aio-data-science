from action3 import isPrime


def view():
	isContinue = True
	while isContinue:
		print("----------Action8------------")
		try:
			number = int(input("Hãy nhập số cần tính: "))
			dsUocSo = getDsUocSo(number)
			danhSachThuaSo = [i for i in dsUocSo if isPrime(i)]

			print("Số {} có số ước số là: {}".format(number, len(dsUocSo)))
			print("Số {} có các ước số là: {}".format(number, ','.join(map(str, dsUocSo))))
			print("Các ước số là nguyên tố của {}: {}".format(number, ','.join(map(str, danhSachThuaSo))))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def getDsUocSo(n):
	result = []
	for i in range(1, n + 1):
		if n % i == 0:
			result.append(i)
	return result
