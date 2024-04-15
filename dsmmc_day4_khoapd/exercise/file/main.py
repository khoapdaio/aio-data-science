"""
Câu lạc bộ người hâm mộ Raptors của trường đại học địa phương của bạn duy trì danh sách các thành viên tích cực của mình
trên tài liệu .txt. Hàng tháng, họ cập nhật tệp bằng cách loại bỏ các thành viên không hoạt động. Bạn đã được giao nhiệm vụ
tự động hóa điều này bằng các kỹ năng python của mình.

Với tệp currentMem, loại từng thành viên có 'no' trong cột không hoạt động của họ. Theo dõi từng thành viên đã bị loại bỏ
và thêm họ vào tệp exMem. Đảm bảo định dạng của tệp gốc được giữ nguyên. (Gợi ý: Làm điều này bằng cách đọc/ghi toàn bộ
dòng và đảm bảo vẫn giữ nguyên tiêu đề)

Chạy khối code bên dưới trước khi bắt đầu exercise. Khung code đã cung cấp cho bạn, bạn chỉ chỉnh sửa hàm cleanFiles.

"""
# Run this prior to starting the exercise
from random import randint as rnd

memReg = 'members.txt'
exReg = 'inactive.txt'
fee = ('yes', 'no')


def genFiles(current, old):
	with open(current, 'w+') as writefile:
		writefile.write('Membership No  Date Joined  Active  \n')
		data = "{:^13}  {:<11}  {:<6}\n"

		for rowno in range(20):
			date = str(rnd(2015, 2020)) + '-' + str(rnd(1, 12)) + '-' + str(rnd(1, 25))
			writefile.write(data.format(rnd(10000, 99999), date, fee[rnd(0, 1)]))

	with open(old, 'w+') as writefile:
		writefile.write('Membership No  Date Joined  Active  \n')
		data = "{:^13}  {:<11}  {:<6}\n"
		for rowno in range(3):
			date = str(rnd(2015, 2020)) + '-' + str(rnd(1, 12)) + '-' + str(rnd(1, 25))
			writefile.write(data.format(rnd(10000, 99999), date, fee[1]))


def cleanFiles(currentMem, exMem):
	'''
	currentMem: File containing list of current members
	exMem: File containing list of old members

	Removes all rows from currentMem containing 'no' and appends them to exMem
	'''
	with open(currentMem, 'r+') as writeFile:
		with open(exMem, 'a+') as appendFile:
			writeFile.seek(0)
			members = writeFile.readlines()

			header = members[0]
			members.pop(0)
			inactive = [member for member in members if ('no' in member)]

			writeFile.seek(0)
			writeFile.write(header)
			for member in members:
				if (member in inactive):
					appendFile.write(member)
				else:
					writeFile.write(member)
			writeFile.truncate()


cleanFiles(memReg, exReg)

headers = "Membership No  Date Joined  Active  \n"
with open(memReg, 'r') as readFile:
	print("Active Members: \n\n")
	print(readFile.read())

with open(exReg, 'r') as readFile:
	print("Inactive Members: \n\n")
	print(readFile.read())
