import game
import recharge
import auth

def main():
	isContinue = True
	auth.view()
	while isContinue:
		if auth.getIsLogin():
			menu()
			choice = int(input("Lựa chọn của bạn là: "))
			match choice:
				case 1:
					game.view()
				case 2:
					recharge.view()
				case 3:
					auth.logout()
				case _:
					print("Lựa chọn nằm ngoài khả năng của hệ thống, xin mời bạn chọn lại ")
		else:
			isContinue = False

def menu():
	print("----------------Bài tập 1--------------")
	print("Chọn 1 trong các hành động sau đây:")
	print("1: Chơi lô ")
	print("2: Nạp tiền")
	print("3: Đăng xuất")


if __name__ == '__main__':
	main()


