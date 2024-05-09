use TESTINGSYSTEM;
# Question 1: Thêm ít nhất 10 record vào mỗi table
# Question 2: Lấy ra tất cả các phòng ban Department
SELECT *
FROM category
where TYPE = 'DEPARTMENT';


# Question 3: Lấy ra id của phòng ban "Sale"
SELECT id
FROM category
WHERE TYPE = 'DEPARTMENT'
  and NAME = 'Sale';


# Question 4: lấy ra thông tin account có full name dài nhất

SELECT *
FROM ACCOUNT
WHERE LENGTH(FULLNAME) = (SELECT MAX(LENGTH(FULLNAME)) FROM ACCOUNT);

# Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3

SELECT *
FROM ACCOUNT
WHERE LENGTH(FULLNAME) = (SELECT MAX(LENGTH(FULLNAME)) FROM ACCOUNT where DEPARTMENT_ID = 3)
  and DEPARTMENT_ID = 3;

# Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019

SELECT NAME
FROM `group`
WHERE CREATE_AT < STR_TO_DATE('2019,12,20', '%Y,%m,%d');

# Question 7: Lấy ra ID của question có >= 4 câu trả lời

SELECT ANSWER.QUESTION_ID
FROM QUESTION
         LEFT JOIN ANSWER ON QUESTION.ID = ANSWER.QUESTION_ID
GROUP BY ANSWER.QUESTION_ID
HAVING COUNT(ANSWER.QUESTION_ID) >= 4;

# Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
SELECT DISTINCT CODES
FROM exam
WHERE DURATION >= 60
  AND CREATE_AT < STR_TO_DATE('2019,12,20', '%Y,%m,%d');
# Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT *
FROM `group`
ORDER BY CREATE_AT DESC
LIMIT 5;

# Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(1)
FROM ACCOUNT
         INNER JOIN CATEGORY ON CATEGORY.TYPE = 'DEPARTMENT' AND CATEGORY.ID = DEPARTMENT_ID
WHERE DEPARTMENT_ID = 2;
# Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT *
FROM account
WHERE FULLNAME like 'D%o';
# Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
delete
from exam
where CREATE_AT < STR_TO_DATE('2019,12,20', '%Y,%m,%d');
# Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
delete
from question
where CONTENT like '%câu hỏi%';
# Question 14: Update thông tin của account có id = 5 thành tên "Lô Văn Đề" và
# email thành lo.vande@mmc.edu.vn
UPDATE ACCOUNT
SET FULLNAME='Lô Văn Đề',
    EMAIL='lo.vande@mmc.edu.vn'
WHERE ID = 5;
# Question 15: Update account có id = 5 sẽ thuộc group có id = 4
UPDATE ACCOUNT a
SET FULLNAME='Lô Văn Đề',
    EMAIL='lo.vande@mmc.edu.vn'
WHERE ID = 5
  and exists (select 1 from group_account ga where ga.ACCOUNT_ID = a.ID and ga.GROUP_ID = 4);
