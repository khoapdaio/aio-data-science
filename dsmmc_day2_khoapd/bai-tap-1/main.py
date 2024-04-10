import action1
import action2
import action3
import action4
import action5
import action6


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
				action3.view()
			case 4:
				action4.view()
			case 5:
				action5.view()
			case 6:
				action6.view()
			case 7:
				isContinue = False
			case _:
				print("Lựa chọn nằm ngoài khả năng của hệ thống, xin mời bạn chọn lại ")


def menu():
	print("----------------Bài tập 1--------------")
	print("Chọn 1 trong các hành động sau đây:")
	print("1: Chuyển đổi một số thực sang inch và foot ")
	print("2: Chuyển đổi một số thực ( giây )-> [giờ:phút:giây] ")
	print("3: Tìm số lớn nhất và số nhỏ nhất ")
	print("4: Tính hiệu của hai số")
	print("5: Kiểm tra chia hết của hai số ")
	print("6: Xếp loại sinh viên ")
	print("7: Kết thúc chương trình")


if __name__ == '__main__':
	main()
