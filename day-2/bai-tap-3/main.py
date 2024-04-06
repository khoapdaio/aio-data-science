import action1
import action2


def main():
	isContinue = True

	while isContinue:
		menu()
		choice = int(input("Lựa chọn của bạn là: "))
		match choice:
			case 1:
				action1.view()
			case 2:
				action2.view()
			case 3:
				isContinue = False
			case _:
				print("Lựa chọn nằm ngoài khả năng của hệ thống, xin mời bạn chọn lại ")


def menu():
	print("----------------Bài tập 1--------------")
	print("Chọn 1 trong các hành động sau đây:")
	print("1: Hiển thị sao ")
	print("2: Tính giai thừa")
	print("3: Kết thúc chương trình")


if __name__ == '__main__':
	main()
