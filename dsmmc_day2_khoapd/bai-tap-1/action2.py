def view():
	isContinue = True
	while isContinue:
		print("----------Action2------------")
		try:
			cm = int(input("Hãy nhập số giây: "))
			hours, minutes, remaining_seconds = seconds_to_hms(cm)
			print("Kết quả: {:02d}:{:02d}:{:02d}".format(hours, minutes, remaining_seconds))
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None


def seconds_to_hms(seconds):
	hours = seconds // 3600
	minutes = (seconds % 3600) // 60
	remaining_seconds = seconds % 60
	return hours, minutes, remaining_seconds
