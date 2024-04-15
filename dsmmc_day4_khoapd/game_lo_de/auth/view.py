import action
from dsmmc_day4_khoapd.game_lo_de import game


def view():
	isContiue = True
	print("----GAME LÔ ĐỀ HỌC-----")
	print("Vui lòng đăng nhập để chơi game")
	while isContiue:
		username = input("Nhập username: ")
		password = input("Nhập password: ")
		if action.login(username, password):
			if action.isAdmin(username):
				adminView()
			else:
				game.view()
			return
		else:
			choice = int(input("Sai username hoặc password,(1: nhập lại, 2: thoát ):"))
			if choice == 1:
				continue
			if choice == 2:
				return


def adminView():
	isContiue = True
	while isContiue:
		menu_admin()
		choice = int(input("Lựa chọn của bạn là: "))
		match choice:
			case 1:
				createAccountView()
				break
			case 2:
				deleteAccountView()
				break
			case 3:
				rechargeAccountView()
				break
			case 4:
				statisticView()
				break
			case 5:
				action.logout()
			case _:
				return


def createAccountView():
	isContiue = True
	while isContiue:
		try:
			username = input("Nhập username cần tạo: ")
			if action.isExist(username):
				print("Tài khoản user đã tồn tại")
			elif username == "admin":
				print("Không được tạo tài khoản admin")
			else:
				password = input("Nhập password cần tạo: ")
				tong_tien = int(input("Nhập số tiền: "))
				if action.createAccount(username, password, tong_tien):
					return
		except ValueError:
			print(f"Số tiền phải nhập số, vui lòng nhập lại")


def deleteAccountView():
	isContiue = True
	while isContiue:
		username = input("Nhập username cần tạo(0: thoát): ")
		if username == "0":
			return
		if not action.isExist(username):
			print("Tài khoản user không tồn tại")
		elif username == "admin":
			print("Không được xóa tài khoản admin")
		else:
			if action.deleteAccount(username):
				return


def rechargeAccountView():
	pass


def statisticView():
	pass


def menu_admin():
	print("ADMIN GAME LÔ ĐỀ HỌC")
	print("1. Tạo tài khoản")
	print("2. Xóa tài khoản")
	print("3. Nạp tiền tài khoản")
	print("4. Thống kê")
	print("5. Đăng xuất")
