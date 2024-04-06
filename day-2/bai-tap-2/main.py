import action1
import action2
import action3
import action4
import action5
import action6
import action7
import action8
import action9
import action10
import action11


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
				action7.view()
			case 8:
				action8.view()
			case 9:
				action9.view()
			case 10:
				action10.view()
			case 11:
				action11.view()
			case 12:
				isContinue = False
			case _:
				print("Lựa chọn nằm ngoài khả năng của hệ thống, xin mời bạn chọn lại ")


def menu():
	print("----------------Bài tập 1--------------")
	print("Chọn 1 trong các hành động sau đây:")
	print("1: Tính tổng các chữ số của một sô nguyên bất kỳ ")
	print("2: Phân tích một số nguyên thành các thừa số nguyên tố ")
	print("3: Liệt kê tất cả các số nguyên tố nhỏ hơn n cho trước ")
	print("4: Liệt kê n số nguyên tố đầu tiên")
	print("5: Tìm ước số chung lớn nhất, bội số chung nhỏ nhất của hai số tự nhiên a và b. ")
	print("6: Tìm số Fibonacci thứ n")
	print("7: Hãy liệt kê các số Fibonaci nhỏ hơn n là số nguyên tố")
	print("8: Tính tổng các chữ số của n và phân tích n thành các thừa số nguyên tố")
	print("9: Liệt kê các ước số của n, có bao nhiêu ước số. Liệu ê các ước số là nguyên tố của n")
	print("10: Thực hiện chuẩn hoá một xâu ký tự nhập từ bàn phím")
	print("11: Hãy tìm từ dài nhất trong một xâu ký tự và từ đó xuất hiện ở vị trí nào")
	print("11: Kết thúc chương trình")


if __name__ == '__main__':
	main()
