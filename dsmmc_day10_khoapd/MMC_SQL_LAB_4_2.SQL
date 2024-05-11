use TESTINGSYSTEM;
# Exercise 1: Join
# Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
SELECT A.*, D.NAME AS NAME_DEPARTMENT
FROM ACCOUNT A
         INNER JOIN CATEGORY D
                    ON D.TYPE = 'DEPARTMENT'
                        AND D.ID = A.DEPARTMENT_ID;


# Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
select *
from account
where CREATE_AT > STR_TO_DATE('2010,12,20', '%Y,%m,%d');

# Question 3: Viết lệnh để lấy ra tất cả các developer
SELECT A.*, P.NAME AS NAME_DEPARTMENT
FROM ACCOUNT A
         INNER JOIN CATEGORY P
                    ON P.TYPE = 'POSITION'
                        AND P.ID = A.POSITION_ID
where P.name = 'Dev';
# Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
SELECT D.NAME AS NAME_DEPARTMENT
FROM ACCOUNT A
         INNER JOIN CATEGORY D
                    ON D.TYPE = 'DEPARTMENT'
                        AND D.ID = A.DEPARTMENT_ID
group by a.DEPARTMENT_ID
having count(a.ID) > 3
;

# Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
select *, eq.count_exam
from question q
         inner join (select QUESTION_ID, count(EXAM_ID) as count_exam
                     from exam_question
                     group by QUESTION_ID) as eq
                    on eq.QUESTION_ID = q.ID
order by eq.count_exam desc;


# Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
select id, NAME
from category c
         left join (select q.CATEGORY_ID, count(q.CATEGORY_ID) as count_question
                    from question q
                    group by CATEGORY_ID) as q
                   on q.CATEGORY_ID = c.ID
where TYPE = 'CATEGORY_QUESTION'
order by q.count_question desc
;

# Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam

SELECT Q.*, EQ.COUNT_EXAM
FROM question Q
         LEFT JOIN
     (SELECT QUESTION_ID, COUNT(EXAM_ID) AS COUNT_EXAM FROM exam_question GROUP BY QUESTION_ID) AS eq
     ON Q.ID = EQ.QUESTION_ID
ORDER BY EQ.COUNT_EXAM DESC;
# Question 8: Lấy ra Question có nhiều câu trả lời nhất
SELECT Q.*, A.COUNT_ANSWER
FROM question Q
         LEFT JOIN(SELECT QUESTION_ID, COUNT(ID) AS COUNT_ANSWER FROM answer GROUP BY QUESTION_ID) AS A
                  ON A.QUESTION_ID = Q.ID
ORDER BY A.COUNT_ANSWER DESC;

# Question 9: Thống kê số lượng account trong mỗi group
SELECT *
FROM `group` G
         LEFT JOIN(SELECT GROUP_ID, COUNT(ACCOUNT_ID) COUNT_ACCOUNT
                   FROM group_account
                   GROUP BY GROUP_ID) AS GA ON GA.GROUP_ID = G.ID
ORDER BY GA.COUNT_ACCOUNT DESC;
# Question 10: Tìm chức vụ có ít người nhất


SELECT POSITION_ID, C.NAME, COUNT(A.ID) COUNT_ACCOUNT
FROM account A
         INNER JOIN category C ON C.ID AND C.TYPE = 'POSITION'
GROUP BY POSITION_ID, C.NAME
ORDER BY COUNT_ACCOUNT;

# Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT CD.NAME, CP.NAME, COUNT(A.POSITION_ID) COUNT_POSITION
FROM account A
         INNER JOIN category CD ON A.DEPARTMENT_ID = CD.ID AND CD.TYPE = 'DEPARTMENT'
         INNER JOIN category CP ON A.POSITION_ID = CP.ID AND CP.TYPE = 'POSITION'
GROUP BY CD.NAME, A.DEPARTMENT_ID, A.POSITION_ID, CP.NAME;
# Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của
# question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, …
SELECT Q.CONTENT, CCQ.NAME, CT.NAME, A.FULLNAME
FROM question Q
         INNER JOIN category CCQ ON Q.CATEGORY_ID = CCQ.ID AND CCQ.TYPE = 'CATEGORY_QUESTION'
         INNER JOIN category CT ON Q.TYPE_ID = CT.ID AND CT.TYPE = 'TYPE_QUESTION'
         INNER JOIN account A ON Q.CREATOR_ID = A.ID

# Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT CT.NAME, COUNT(Q.ID) COUNT_QUESTION
FROM question Q
         INNER JOIN category CT ON Q.TYPE_ID = CT.ID AND CT.TYPE = 'TYPE_QUESTION'
GROUP BY Q.TYPE_ID, CT.NAME;
# Question 14: Lấy ra group không có account nào
SELECT G.NAME, COUNT(GA.ACCOUNT_ID) COUNT_ACCOUNT
FROM `group` G
         LEFT JOIN group_account GA ON G.ID = GA.GROUP_ID
GROUP BY GA.GROUP_ID, G.NAME
ORDER BY COUNT_ACCOUNT DESC;

# Question 15: Lấy ra group không có account nào
SELECT A.FULLNAME, COUNT(GA.ACCOUNT_ID) COUNT_ACCOUNT
FROM `account` A
         LEFT JOIN group_account GA ON A.ID = GA.GROUP_ID
GROUP BY GA.GROUP_ID, A.FULLNAME
HAVING COUNT_ACCOUNT = 0;
# Question 16: Lấy ra question không có answer nào
SELECT Q.CONTENT, COUNT(A.ID) COUNT_ANSWER
FROM question Q
         LEFT JOIN answer A ON Q.ID = A.QUESTION_ID
GROUP BY Q.ID
HAVING COUNT_ANSWER = 0;


# Exercise 2: Union
# Question 17:
# a) Lấy các account thuộc nhóm thứ 1
select *
from account a
         inner join group_account ga on a.ID = ga.ACCOUNT_ID
where ga.GROUP_ID = 1;
# b) Lấy các account thuộc nhóm thứ 2
select *
from account a
         inner join group_account ga on a.ID = ga.ACCOUNT_ID
where ga.GROUP_ID = 3;
# c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
select *
from account a
         inner join group_account ga on a.ID = ga.ACCOUNT_ID
where ga.GROUP_ID = 1
union
select *
from account a
         inner join group_account ga on a.ID = ga.ACCOUNT_ID
where ga.GROUP_ID = 3;

# Question 18:
# a) Lấy các group có lớn hơn 5 thành viên
select g.NAME, count(ga.ACCOUNT_ID) as count_account
from `group` g
         inner join group_account ga on g.ID = ga.GROUP_ID
group by ga.GROUP_ID, g.NAME
having count_account > 5;
# b) Lấy các group có nhỏ hơn 7 thành viên
select g.NAME, count(ga.ACCOUNT_ID) as count_account
from `group` g
         inner join group_account ga on g.ID = ga.GROUP_ID
group by ga.GROUP_ID, g.NAME
having count_account < 7;
# c) Ghép 2 kết quả từ câu a) và câu b)
select g.NAME, count(ga.ACCOUNT_ID) as count_account
from `group` g
         inner join group_account ga on g.ID = ga.GROUP_ID
group by ga.GROUP_ID, g.NAME
having count_account > 5
union
select g.NAME, count(ga.ACCOUNT_ID) as count_account
from `group` g
         inner join group_account ga on g.ID = ga.GROUP_ID
group by ga.GROUP_ID, g.NAME
having count_account < 7;

select g.NAME, count(ga.ACCOUNT_ID) as count_account
from `group` g
         inner join group_account ga on g.ID = ga.GROUP_ID
group by ga.GROUP_ID, g.NAME
having count_account >5 or count_account<7;