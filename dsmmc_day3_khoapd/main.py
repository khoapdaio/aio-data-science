# Bài tập List
# 1
import functools
from collections import Counter

a_list = [1, 'hello', [1, 2, 3], True]
# 2
print(a_list[1])
# 3
print(a_list[1:4])
# 4
a = [1, 'a']
b = [2, 1, 'd']
c = a + b
print(c)
# Bài tập Tuple

genres_tuple = ("pop", "rock", "soul", "hard rock", "soft rock",
                "R&B", "progressive rock", "disco")
print(len(genres_tuple))
print(genres_tuple[3])
print(genres_tuple[3:6])
print(genres_tuple[:2])
print(genres_tuple[-1])

C_tuple = (- 5, 1, -3)
c_list = list(C_tuple)
c_list = sorted(c_list)
print(c_list)

# Bài tập dictionary
soundtrack_dic = {"The Bodyguard": "1992", "Saturday Night Fever": "1977"}
print(soundtrack_dic.keys())
print(soundtrack_dic.values())

album_sales_dict = {
	"The Bodyguard": 50,
	"Back in Black": 50,
	"Thriller": 65
}

print(album_sales_dict["Thriller"])
print(album_sales_dict.keys())
print(album_sales_dict.values())
# Bài tập Set

sets = set(['rap', 'house', 'electronic music', 'rap'])

a = [1, 2, 2, 1]
b = set([1, 2, 2, 1])

print(sum(b))
print(sum(a))
print(sum(a) + sum(b))

album_set1 = set(["Thriller", 'AC/DC', 'Back in Black'])
album_set2 = set(["AC/DC", "Back in Black", "The Dark Side of the Moon"])

album_set3 = list(album_set1 | album_set2)
print(album_set1.issubset(album_set3))
print(album_set3)

# bài tổng hợp
# bài 1
dict_roman = {
	'I': 1,
	'V': 5,
	'X': 10,
	'L': 50,
	'C': 100,
	'D': 500,
	'M': 1000,
	'IV': 4,
	'IX': 9,
	'XL': 50,
	'XC': 90,
	'CD': 500,
	'CM': 1000,
}


def romans_to_int(roman):
	roman = roman.upper()
	value = dict_roman[roman[-1]]
	result = 0
	for i in range(len(roman) - 1, -1, -1):
		if value <= dict_roman[roman[i]]:
			result += dict_roman[roman[i]]
		if value > dict_roman[roman[i]]:
			result -= dict_roman[roman[i]]
		value = dict_roman[roman[i]]
	return result


print(romans_to_int('MCMXCIV'))


# bài 2:
def singleNumber(nums) -> int:
	return functools.reduce(lambda a, b: a ^ b, nums)


print(singleNumber([2, 2, 1]))


# bài 3:
def longestCommonPrefix(strs) -> str:
	res = ""
	for i in range(len(strs[0])):
		for s in strs:
			if i == len(s) or s[i] != strs[0][i]:
				return res
		res += strs[0][i]
	return res


print(longestCommonPrefix(["flower", "flow", "flight"]))
print(longestCommonPrefix(["dog", "racecar", "car"]))


def topKFrequent( nums, k):
	counter = Counter(nums)
	return [num for num, _ in counter.most_common(k)]


print(topKFrequent([1,1,1,2,2,3],2))