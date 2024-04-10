def view():
	isContinue = True
	while isContinue:
		print("----------Action10------------")
		try:
			chuoi = input("Hãy nhập số cần tính: ")
			chuoi = chuoi.split()
			chuoi = ' '.join(chuoi).title()
			print("Xâu ký tự sau khi được  chuẩn hoá: {}".format(chuoi))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None
