import numpy as np

#bài 1: convert to numpy array
A = [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]]
A = np.array(A)
print(type(A))
print(A)


#bài 2: tính kích  thước mảng
print(A.shape)

#bài 3: truy cập phần tử trên hàng đầu , cột đầu tiên và cột thứ hai
print(A[0, 0:2])

#bài 4:Thực hiện phép nhân ma trận với mảng numpy  A và  B.
B = np.array([[0, 1], [1, 0], [1, 1], [-1, 0]])
print(np.dot(A, B))