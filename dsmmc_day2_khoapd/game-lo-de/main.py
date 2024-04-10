import game
import recharge


def main():
	isContinue = True
	while isContinue:
		menu()
		choice = int(input("Lựa chọn của bạn là: "))
		match choice:
			case 1:
				game.view()
			case 2:
				recharge.view()
			case 3:
				isContinue = False
			case _:
				print("Lựa chọn nằm ngoài khả năng của hệ thống, xin mời bạn chọn lại ")


def menu():
	print("----------------Bài tập 1--------------")
	print("Chọn 1 trong các hành động sau đây:")
	print("1: Chơi lô ")
	print("2: Nạp tiền")
	print("3: Kết thúc chương trình")


if __name__ == '__main__':
	main()


