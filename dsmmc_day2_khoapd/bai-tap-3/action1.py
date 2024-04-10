def view():
	isContinue = True
	while isContinue:
		print("----------Action1------------")
		try:
			print("Chọn một trong các kiểu hiển thị sau đây:")
			print("1. Hiển thị thứ 1")
			print("2. Hiển thị thứ 2")
			print("3. Hiển thị thứ 3")
			print("4. Hiển thị thứ 4")
			number = int(input("Kiểu hiển thị là: "))
			sum = view_square(number)
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def view_square(n):
	match (n):
		case 1:
			view_square_1()
		case 2:
			view_square_2()
		case 3:
			view_square_3()
		case 4:
			view_square_4()


def view_square_1():
	for i in range(9):
		print("* " * i, sep=" ")

def view_square_2():
	n = 8
	while n >= 1:
		print("* " * n, sep=" ")
		n -= 1

def view_square_3():
	n = 8
	m = 0
	while n >= 1 and m < 8 :
		print("  "*m + "* " * n, sep=" ")
		n -= 1
		m+=1

def view_square_4():
	n = 7
	m = 1
	while n >= 0 and m < 9 :
		print("  " * n + "* " * m, sep=" ")
		n -= 1
		m += 1
