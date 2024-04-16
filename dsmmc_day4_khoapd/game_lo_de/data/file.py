def write(data, path, mode='a'):
	try:
		with open(path, mode) as file:
			for line in data:
				file.write(line)
	except Exception as e:
		print(f"Có lỗi xảy ra: {e}")


def read(path, mode='r'):
	try:
		with open(path, mode) as file:
			du_lieu = [line.strip().split(',') for line in file.readlines()]
		return du_lieu
	except Exception as e:
		print(f"Có lỗi xảy ra khi đọc file: {e}")
		return None


def clearData(path):
	try:
		# Open the file in write mode, which clears its contents
		with open(path, "w") as file:
			pass  # This effectively clears the file

		print("File cleared successfully.")
	except Exception as e:
		print(f"Có lỗi xảy ra khi đọc file: {e}")
		return None
