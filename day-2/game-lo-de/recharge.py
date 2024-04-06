def view():
	print("--------------------------")
	isContinue = True
	while isContinue:
		money = int(input("Nhập số tiền mà bạn muốn nạp "))
		addMoney(money)
		print(f"Số tiền của bạn đang có là: {getMoney()}")
		addMoney(money)
		choice = int(input("Bạn có muốn nạp tiếp không? (1:có, 2:không)"))
		if choice == 2:
			isContinue = False


cash = 0


def addMoney(money):
	global cash
	cash += money


def getMoney():
	global cash
	return cash
