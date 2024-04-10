

def view():
	isContinue = True
	while isContinue:
		print("----------Action1------------")
		try:
			cm = float(input("Hãy nhập số cm: "))
			feet, inches = convertCm(cm)
			print("Số tương đương là: {:.2f} feet và {:.2f} inches.".format(feet, inches))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def convertCm(cm):
	inches = cm / 2.54
	feet = inches / 12
	return inches, feet
