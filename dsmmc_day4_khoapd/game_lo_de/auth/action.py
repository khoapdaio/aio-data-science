from dsmmc_day4_khoapd.game_lo_de import data

PATH_DATA_TAI_KHOAN = 'O:\Git\\aio-data-science\data\data_tai_khoan.txt'

# 0 logout
# 1 admin
# 2 user
statusLogin = 0

user: list = None


def isAdmin(username):
	return username == 'admin'


def getCurrentUser():
	global user
	return user


def createAccount(username, password, tongTien=0):
	try:
		user_info = f"{username},{password},{tongTien}\n"
		data.write([user_info], PATH_DATA_TAI_KHOAN)
		print(f"Tạo tài khoản {username} thành công")
		return True
	except Exception as e:
		print(f'Có lỗi trong quá trình tạo tài khoảng: {e}')
		return False


def resetPassword(password, newPassword):
	global user
	if user is not None:
		lst_accounts = getListAccount()
		for account in lst_accounts:
			if account[0] == user[0] and account[1] == password:
				account[1] = newPassword
				break
		return writeListAccount(lst_accounts)


def isPasswordValid(password):
	global user
	if user is not None:
		if password == user[1]:
			return True
	return False


def isExist(username):
	lst_accounts = getListAccount()
	for account in lst_accounts:
		if account[0] == username:
			return True
	return False


def deleteAccount(username):
	try:
		lst_accounts = getListAccount()
		temp = lst_accounts.copy()

		for account in temp:
			if account[0] == username:
				lst_accounts.remove(account)
				break
		if writeListAccount(lst_accounts):
			print("Đã xóa tài khoản thành công")
			return True

		return False
	except Exception as e:
		print(f"Có lỗi trong quá trình xóa tài khoản: {e}")
		return False


def recharge(username, money: int):
	try:
		lst_accounts = getListAccount()
		for account in lst_accounts:
			if account[0] == username:
				account[2] = money + int(account[2])
				break
		if writeListAccount(lst_accounts):
			print("Đã nạp tiền tài khoản thành công!")
			return True
		return False
	except Exception as e:
		print(f"Có lỗi trong quá trình nạp tiền tài khoản: {e}")
		return False


def writeListAccount(newLstAccount):
	try:
		data.clearData(PATH_DATA_TAI_KHOAN)
		for account in newLstAccount:
			user_info = f"{account[0]},{account[1]},{account[2]}\n"
			data.write([user_info], PATH_DATA_TAI_KHOAN)
		return True
	except Exception as e:
		print(f"Có lỗi trong quá trình ghi danh sách tài khoản: {e}")
		return False


def getListAccount():
	return data.read(PATH_DATA_TAI_KHOAN)


def logout():
	global statusLogin, user
	statusLogin = 0
	user = None
	return True


def login(username, password):
	global statusLogin, user
	try:
		lst_account = getListAccount()
		if lst_account:
			for account in lst_account:
				if username == account[0] and password == account[1]:
					statusLogin = 1
					user = account
					return True

		return False
	except Exception as e:
		print(f'Có lỗi xảy ra: {e}')


def addMoney(money: int):
	try:
		tempUser = None
		lst_accounts = getListAccount()
		for account in lst_accounts:
			if account[0] == getCurrentUser()[0]:
				account[2] = money + int(account[2])
				tempUser = account
				break
		if writeListAccount(lst_accounts):
			global user
			user = tempUser
			return True
		return False
	except Exception as e:
		print(f"Có lỗi trong quá trình cộng tiền tài khoản: {e}")
		return False


def getMoney():
	return getCurrentUser()[2]
