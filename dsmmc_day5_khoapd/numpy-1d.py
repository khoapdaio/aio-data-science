import numpy as np

# Câu 1: trừ hai mảng
u = np.array([1, 0])
v = np.array([0, 1])

print(np.subtract(u, v))

# câu 2: nhân mảng với -2
z = np.array([2, 4])
print(np.multiply(z, -2))

# câu 3: nhân hai mảng với nhau
u = np.array([1, 2, 3, 4, 5])
z = np.array([1, 0, 1, 0, 1])
print(np.multiply(u, z))

# câu 4: tính tích vô hướng hai mảng
u = np.array([-1, 1])
z = np.array([1, 1])
print(np.dot(u, z))

u = np.array([1, 0])
z = np.array( [0, 1])
print(np.dot(u, z))

u = np.array( [1, 1])
z = np.array([0, 1])
print(np.dot(u, z))


#giải thích  th1,th2 vuông góc , còn th3 là cùng thuộc một đường thẳng