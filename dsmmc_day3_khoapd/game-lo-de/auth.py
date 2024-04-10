isLogin = False


def view():
	isContiue = True
	global isLogin
	print("----GAME LÔ ĐỀ HỌC-----")
	print("Vui lòng đăng nhập để chơi game")
	while isContiue:
		username = input("Nhập username: ")
		password = input("Nhập password: ")
		if username == 'admin' and password == 'admin':
			isLogin = True
			return
		choice = int(input("Sai username hoặc password,(1:nhập lại,2:thoat):"))
		if choice == 1:
			continue
		if choice == 2:
			isLogin = False
			return


def getIsLogin():
	global isLogin
	return isLogin


def logout():
	global isLogin
	isLogin = False
