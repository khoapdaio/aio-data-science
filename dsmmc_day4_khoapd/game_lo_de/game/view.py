from dsmmc_day4_khoapd.game_lo_de import auth, data
from dsmmc_day4_khoapd.game_lo_de.auth import action as authAction
from dsmmc_day4_khoapd.game_lo_de.game import action as gameAction


def doView():
	isContinue = True
	while isContinue:
		if authAction.getCurrentUser():
			menu()
			choice = int(input("Lựa chọn của bạn là: "))
			match choice:
				case 1:
					gameAction.play()
				case 2:
					auth.resetPasswordView()
				case 3:
					data.doStatistic()
				case 4:
					isContinue = False
				case _:
					print("Lựa chọn nằm ngoài khả năng của hệ thống, xin mời bạn chọn lại ")
		else:
			isContinue = False
	pass


def menu():
	print("GAME LÔ ĐỀ HỌC")
	print("1. Chơi lô")
	print("2. Đổi mật khẩu")
	print("3. Thống kê")
	print("4. Đăng xuất")
