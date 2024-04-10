def view():
	isContinue = True
	while isContinue:
		print("----------Action11------------")
		try:
			chuoi = input("Hãy nhập chuỗi cần xử lý: ")
			chuoi = chuoi.split()
			max_length = 0
			max_word = ''
			position = -1
			for i, word in enumerate(chuoi):
				word_length = len(word)
				if word_length > max_length:
					max_length = word_length
					max_word = word
					position = i

			print("Từ dài nhất trong xâu là:", max_word)
			print("Từ đó xuất hiện ở vị trí:", position + 1)  # Vị trí bắt đầu từ 1, không phải từ 0
			choice = int(input("Bạn có muốn thử lại không (nhập 1(có), 2(không)): "))
			if choice == 2:
				isContinue = False
		except ValueError:
			print("Vui lòng nhập một số nguyên.")
	return None
