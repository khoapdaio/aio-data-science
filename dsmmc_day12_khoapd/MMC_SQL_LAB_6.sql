use testingsystem;

# Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account
# thuộc phòng ban đó
DROP PROCEDURE IF EXISTS P_ACCOUNT_ALL;
CREATE PROCEDURE P_ACCOUNT_ALL(IN P_NAME_DEPARTMENT VARCHAR(50))
BEGIN
    SELECT A.*, C.NAME AS NAME_DEPARTMENT
    FROM ACCOUNT A
             INNER JOIN CATEGORY C ON A.DEPARTMENT_ID = C.ID
    WHERE C.NAME = P_NAME_DEPARTMENT;
END;


CALL P_ACCOUNT_ALL('Marketing');

# Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS P_NUMBER_ACCOUNT;
CREATE PROCEDURE P_NUMBER_ACCOUNT()
BEGIN
    SELECT C.NAME AS DEPARTMENT_NAME, COUNT(A.ID) AS NUMBER_ACCOUNT
    FROM ACCOUNT A
             INNER JOIN CATEGORY C ON A.DEPARTMENT_ID = C.ID
    GROUP BY A.DEPARTMENT_ID;
END;

CALL P_NUMBER_ACCOUNT();
# Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
# trong tháng hiện tại

DROP PROCEDURE IF EXISTS P_QUESTION_TYPE;
CREATE PROCEDURE P_QUESTION_TYPE()
BEGIN
    SELECT C.NAME AS NAME_TYPE_QUESTION, COUNT(Q.ID) AS NUMBER_QUESTION
    FROM QUESTION Q
             INNER JOIN category C ON Q.TYPE_ID = C.ID
    GROUP BY Q.TYPE_ID
    ORDER BY COUNT(Q.TYPE_ID) DESC;
END;

CALL P_QUESTION_TYPE();


# Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS P_MAX_QUESTION_TYPE;
CREATE PROCEDURE P_MAX_QUESTION_TYPE(OUT P_ID_TYPE INT)
BEGIN
    SELECT C.ID
    INTO P_ID_TYPE
    FROM QUESTION Q
             INNER JOIN category C ON Q.TYPE_ID = C.ID
    GROUP BY Q.TYPE_ID
    ORDER BY COUNT(Q.TYPE_ID) DESC
    LIMIT 1;
END;
SET @ID = 0;
CALL P_MAX_QUESTION_TYPE(@ID);
SELECT @ID;

# Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
SET @ID = 0;
CALL P_MAX_QUESTION_TYPE(@ID);
SELECT @ID;

SELECT *
FROM category
WHERE ID = @ID;

# Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
# chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của
# người dùng nhập vào
DROP PROCEDURE IF EXISTS P_FIND_GROUP_NAME;
CREATE PROCEDURE P_FIND_GROUP_NAME(IN P_GROUP_NAME VARCHAR(50))
BEGIN
    SELECT * FROM `group` G WHERE UPPER(G.NAME) LIKE UPPER('%' || P_GROUP_NAME || '%');
END;

DROP PROCEDURE IF EXISTS P_FIND_ACCOUNT_NAME;
CREATE PROCEDURE P_FIND_ACCOUNT_NAME(IN P_FULL_NAME VARCHAR(50))
BEGIN
    SELECT * FROM account a WHERE UPPER(a.FULLNAME) LIKE UPPER('%' || P_FULL_NAME || '%');
END;
# Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
# trong store sẽ tự động gán:
# username sẽ giống email nhưng bỏ phần @..mail đi
# positionID: sẽ có default là developer
# departmentID: sẽ được cho vào 1 phòng chờ
# Sau đó in ra kết quả tạo thành công

DROP PROCEDURE IF EXISTS P_ADD_ACCOUNT;
CREATE PROCEDURE P_ADD_ACCOUNT(IN P_FULL_NAME VARCHAR(50), in p_email varchar(50))
BEGIN
    DECLARE p_username VARCHAR(255);
    DECLARE isValid BOOLEAN;
    SET isValid = p_email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$';

    IF NOT isValid THEN
        SELECT 'Error: Invalid email format.' AS result;
    END IF;

    SET p_username = SUBSTRING_INDEX(p_email, '@', 1);
    insert into account( email, USERNAME, FULLNAME, POSITION_ID, DEPARTMENT_ID )
        value (p_email, p_username, P_FULL_NAME, 11, 27);
    SELECT CONCAT('User ', P_FULL_NAME, ' with email ', p_email, ' has been created successfully with username ',
                  p_username) AS result;
END;

call P_ADD_ACCOUNT('Phạm Đăng Khoa', 'khoapd@gmail.com');

# Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để
# thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DROP PROCEDURE IF EXISTS P_Q_FIND_LONGEST_CONTENT;
CREATE PROCEDURE P_Q_FIND_LONGEST_CONTENT(IN P_TYPE_QUESTION_NAME VARCHAR(50))
BEGIN
    SELECT Q.*
    FROM question Q
             INNER JOIN category C ON Q.TYPE_ID = C.ID
    WHERE C.NAME = P_TYPE_QUESTION_NAME
    ORDER BY LENGTH(Q.CONTENT) DESC
    LIMIT 1;
END;

CALL P_Q_FIND_LONGEST_CONTENT('Multiple-Choice');
# Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS P_DELETE_EXAM_BY_ID;
CREATE PROCEDURE P_DELETE_EXAM_BY_ID(IN P_ID VARCHAR(50))
BEGIN
    DECLARE isValid BOOLEAN;
    SET isValid = (SELECT CASE WHEN EXISTS (SELECT 1 FROM EXAM WHERE ID = P_ID) THEN TRUE ELSE FALSE END);
    IF NOT isValid THEN
        SELECT 'Error: Invalid ID .' AS result;
    end if;
    DELETE FROM exam_question WHERE EXAM_ID = P_ID;
    DELETE FROM exam WHERE ID = P_ID;
END;

# Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng
# store ở câu 9 để xóa)
# Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
DROP PROCEDURE IF EXISTS P_REMOVE_OLD_EXAM;
CREATE PROCEDURE P_REMOVE_OLD_EXAM()
BEGIN

    DECLARE P_EXAM_ID INT;
    DECLARE done INT DEFAULT 0;
    DECLARE P_COUNT_RECORD INT DEFAULT 0;
    DECLARE cur CURSOR FOR
        SELECT ID FROM exam WHERE CREATE_AT <= CURDATE() - INTERVAL 3 YEAR;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    OPEN cur;
    READ_LOOP:
    LOOP
        FETCH cur INTO P_EXAM_ID;
        IF done THEN
            SELECT CONCAT('number of exams deleted: ', P_COUNT_RECORD) as exams_deleted;
            LEAVE read_loop;
        END IF;
        CALL P_DELETE_EXAM_BY_ID(P_EXAM_ID);
        set P_COUNT_RECORD = P_COUNT_RECORD + 1;
    end loop;
    SELECT CONCAT('number of exams deleted: ', P_COUNT_RECORD) as exams_deleted;
END;

call P_REMOVE_OLD_EXAM();


# Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập
# vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng ban
# default là phòng ban chờ việc

DROP PROCEDURE IF EXISTS P_REMOVE_DEPARTMENT;
CREATE PROCEDURE P_REMOVE_DEPARTMENT(IN P_NAME_DEPARTMENT VARCHAR(50))
BEGIN
    update account
    set DEPARTMENT_ID = (select id from category c where c.TYPE = 'DEPARTMENT' and c.name = 'Waiting Department')
    where DEPARTMENT_ID = (select id from category c where c.NAME = P_NAME_DEPARTMENT);
    DELETE
    FROM category c
    WHERE c.NAME = P_NAME_DEPARTMENT;
    SELECT ROW_COUNT() AS accounts_transferred;
END;


# Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

DROP PROCEDURE IF EXISTS P_QUESTION_CREATED_PER_MONTH;
CREATE PROCEDURE P_QUESTION_CREATED_PER_MONTH()
BEGIN
    with question_month as (select *, Month(CREATE_AT) as month_create_at
                            from question
                            where YEAR(CREATE_AT) = year(curdate()))
    select concat('Tháng ', month_create_at, ' có số câu hỏi là: ', count(id)) as result
    from question_month
    group by month_create_at
    order by month_create_at;
END;

call P_QUESTION_CREATED_PER_MONTH();


# Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng
# gần đây nhất
# (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")

CREATE or replace view v_list_month_from_cur as
select month(DATE_SUB(curdate(), INTERVAL 6 MONTH)) as month, year(DATE_SUB(curdate(), INTERVAL 6 MONTH)) as year
union
select month(DATE_SUB(curdate(), INTERVAL 5 MONTH)) as month, year(DATE_SUB(curdate(), INTERVAL 5 MONTH)) as year
union
select month(DATE_SUB(curdate(), INTERVAL 4 MONTH)) as month, year(DATE_SUB(curdate(), INTERVAL 4 MONTH)) as year
union
select month(DATE_SUB(curdate(), INTERVAL 3 MONTH)) as month, year(DATE_SUB(curdate(), INTERVAL 3 MONTH)) as year
union
select month(DATE_SUB(curdate(), INTERVAL 2 MONTH)) as month, year(DATE_SUB(curdate(), INTERVAL 2 MONTH)) as year
union
select month(DATE_SUB(curdate(), INTERVAL 1 MONTH)) as month, year(DATE_SUB(curdate(), INTERVAL 1 MONTH)) as year
;

DROP PROCEDURE IF EXISTS P_QUESTION_CREATED_PER_MONTH;
CREATE PROCEDURE P_QUESTION_CREATED_PER_MONTH()
BEGIN
    with question_month as (select id, Month(CREATE_AT) as month_create_at
                            from question
                            where CREATE_AT >= DATE_SUB(curdate(), INTERVAL 6 MONTH))
    select concat(month, '-', year)                                     AS month,
           coalesce(question_count, 'không có câu hỏi nào trong tháng') as question_count
    from v_list_month_from_cur vm
             left join (select count(id) as question_count, month_create_at
                        from question_month
                        group by month_create_at) qm
                       on vm.month = qm.month_create_at;
END;

call P_QUESTION_CREATED_PER_MONTH();

