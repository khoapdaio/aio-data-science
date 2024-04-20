import numpy as np

# câu 1

matrix = np.random.rand(5, 5)
print(f"ma trận: {matrix}")
determinant = np.linalg.det(matrix)
print(f"Định thức của ma trận:{determinant}")

inverse_matrix = np.linalg.inv(matrix)
print(f"Ma trận nghịch đảo: {inverse_matrix}")

# Tính các giá trị riêng và vectơ riêng của ma trận
eigen_values, eigen_vectors = np.linalg.eig(matrix)
print("\nCác giá trị riêng:")
print(eigen_values)
print("\nCác vectơ riêng:")
print(eigen_vectors)


# bài 2:
def gradient_descent( x, learning_rate, iterations ):
	for _ in range(iterations):
		gradient = 2 * x + 5 * np.cos(x)  # Đạo hàm riêng theo x
		x = x - learning_rate * gradient  # Cập nhật tham số
	return x


# Khởi tạo các hyperparameters
x_initial = 5  # Input đầu vào
learning_rate = 0.1  # Tốc độ học
iterations = 100  # Số lần lặp

# Run gradient descent
minima = gradient_descent(x_initial, learning_rate, iterations)
print(f"minima=>{minima}")

# bài 3: Phân tích thống kê
data = np.loadtxt('../dsmmc_day5_khoapd/bai3.csv', delimiter = ',')

mean = np.mean(data)
median = np.median(data)
std_dev = np.std(data)
print(f"mean=>{mean}")
print(f"median=>{median}")
print(f"std_dev=>{std_dev}")

correlation = np.corrcoef(data, rowvar = False)
print(f"correlation=>{correlation}")

z_score = np.abs((data - mean) / std_dev)
print(f"z_score=>{z_score}")
outliers = np.where(z_score > 3)
print(f"outliers=>{outliers}")
