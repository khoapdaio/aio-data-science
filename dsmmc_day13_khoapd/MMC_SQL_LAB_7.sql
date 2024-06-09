use TESTINGSYSTEM;
# Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1
# năm trước

drop trigger if exists trg_check_create_at;
delimiter $$
create trigger trg_check_create_at
    before insert
    on `group`
    for each row
begin
    if new.CREATE_AT < curdate() - INTERVAL 1 year then
        SIGNAL sqlstate '12345'
            set message_text = 'không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước';
    end if;
end $$;
delimiter ;


# Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
# department "Sale" nữa, khi thêm thì hiện ra thông báo "Department "Sale" cannot add
# more user"

drop trigger if exists trg_deny_sale;
delimiter $$
create trigger trg_deny_sale
    before insert
    on `account`
    for each row
begin
    declare p_department_name varchar(50);

    select name into p_department_name from `category` where TYPE = 'DEPARTMENT' and id = new.DEPARTMENT_ID;
    if p_department_name = 'Sale' then
        SIGNAL sqlstate '12345'
            set message_text = 'Department "Sale" cannot add more user';
    end if;
end $$;
delimiter ;

# Question 3: Cấu hình 1 group có nhiều nhất là 5 user
drop trigger if exists trg_group_limit_user;
delimiter $$
create trigger trg_group_limit_user
    before insert
    on `group_account`
    for each row
begin
    declare p_count_user int;

    select count(account_id) into p_count_user from `group_account` where new.GROUP_ID = GROUP_ID group by GROUP_ID;
    if p_count_user > 5 then
        SIGNAL sqlstate '12345'
            set message_text = 'Group này không thể có nhiều hơn 5 user ';
    end if;
end $$;
delimiter ;


# Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question


drop trigger if exists trg_exam_limit_question;
delimiter $$
create trigger trg_exam_limit_question
    before insert
    on `exam_question`
    for each row
begin
    declare p_count_question int;

    select count(QUESTION_ID) into p_count_question from `exam_question` where new.EXAM_ID = EXAM_ID group by EXAM_ID;
    if p_count_question > 10 then
        SIGNAL sqlstate '12345'
            set message_text = 'Bài thi này không thể có 10 câu hỏi ';
    end if;
end $$;
delimiter ;
# Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
# admin@gmail.com (đây là tài khoản admin, không cho phép user xóa), còn lại các tài
# khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông tin liên quan tới user đó.

DROP TRIGGER IF EXISTS TRG_ADMIN_NOT_DELETED;
DELIMITER $$
CREATE TRIGGER TRG_ADMIN_NOT_DELETED
    BEFORE DELETE
    ON `ACCOUNT`
    FOR EACH ROW
BEGIN

    IF OLD.EMAIL = 'admin@gmail.com' THEN
        SIGNAL sqlstate '12345'
            SET MESSAGE_TEXT = 'Đây là tài khoản admin, không cho phép user xóa';
    END IF;

    DELETE
    FROM GROUP_ACCOUNT
    WHERE ACCOUNT_ID = OLD.ID;
END $$;
DELIMITER ;

# Question 6: Không sử dụng cấu hình default cho field DepartmentID của table Account,
# hãy tạo trigger cho phép người dùng khi tạo account không điền vào departmentID thì
# sẽ được phân vào phòng ban "waiting Department".

DROP TRIGGER IF EXISTS TRG_ADMIN_NOT_DELETED;
DELIMITER $$
CREATE TRIGGER TRG_ADMIN_NOT_DELETED
    BEFORE DELETE
    ON `ACCOUNT`
    FOR EACH ROW
BEGIN

    IF OLD.EMAIL = 'admin@gmail.com' THEN
        SIGNAL sqlstate '12345'
            SET MESSAGE_TEXT = 'Đây là tài khoản admin, không cho phép user xóa';
    END IF;

    DELETE
    FROM GROUP_ACCOUNT
    WHERE ACCOUNT_ID = OLD.ID;
END $$;
DELIMITER ;
# Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi question,
# trong đó có tối đa 2 đáp án đúng.

DROP TRIGGER IF EXISTS TRG_MAX_ANSWERS_PER_QUEST;
DELIMITER $$
CREATE TRIGGER TRG_MAX_ANSWERS_PER_QUEST
    BEFORE INSERT
    ON `answer`
    FOR EACH ROW
BEGIN
    DECLARE T_NUMBER_ANSWER INT default 0;
    DECLARE t_number_answer_true int default 0;

    SELECT COUNT(CONTENT) INTO T_NUMBER_ANSWER FROM ANSWER WHERE QUESTION_ID = NEW.QUESTION_ID GROUP BY QUESTION_ID;

    IF T_NUMBER_ANSWER >= 4 THEN
        SIGNAL sqlstate '12345'
            SET MESSAGE_TEXT = 'Quá số lượng câu trả lời cho câu hỏi vừa rồi ';
    END IF;

    select count(content)
    into t_number_answer_true
    from answer
    where QUESTION_ID = new.QUESTION_ID
      and IS_CORRECT = true
    group by QUESTION_ID;
    IF T_NUMBER_ANSWER >= 2 THEN
        SIGNAL sqlstate '12345'
            SET MESSAGE_TEXT = 'Quá số lượng câu trả lời đúng câu hỏi vừa rồi ';
    END IF;
END $$;
DELIMITER ;


# Question 8: Viết trigger sửa lại dữ liệu cho đúng:
# ● Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
# ● Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
ALTER TABLE ACCOUNT
    add GENDER ENUM ('M', 'F', 'U') NOT NULL DEFAULT 'U';

DROP TRIGGER IF EXISTS TRG_MODIFY_GENDER_ACCOUNT;
DELIMITER $$
CREATE TRIGGER TRG_MODIFY_GENDER_ACCOUNT
    BEFORE INSERT
    ON `account`
    FOR EACH ROW
BEGIN
    if new.GENDER = 'nam' then
        SET NEW.GENDER = 'M';
    end if;
    if new.GENDER = 'nữ' then
        SET NEW.GENDER = 'F';
    end if;
    if new.GENDER = 'chưa xác định' then
        SET NEW.GENDER = 'U';
    end if;
end $$;
DELIMITER ;

# Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày

DROP TRIGGER IF EXISTS TRG_NOT_DELETED_EXAM;
DELIMITER $$
CREATE TRIGGER TRG_NOT_DELETED_EXAM
    BEFORE delete
    ON `exam`
    FOR EACH ROW
BEGIN
    if DATEDIFF(CREATE_AT, curdate()) >= 2 then
        SIGNAL sqlstate '12345'
            SET MESSAGE_TEXT = 'Không được phép xóa bài thi do mới được tạo cách đây 2 ngày';
    end if;
end $$;
DELIMITER ;
# Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các question
# khi question đó chưa nằm trong exam nào

DROP TRIGGER IF EXISTS TRG_UPDATE_QUESTION;
DELIMITER $$
CREATE TRIGGER TRG_UPDATE_QUESTION
    BEFORE update
    ON `question`
    FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM exam_question WHERE question_id = OLD.ID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update question because it is part of an exam';
    END IF;
end $$;
DELIMITER ;

DROP TRIGGER IF EXISTS TRG_DELETE_QUESTION;
DELIMITER $$
CREATE TRIGGER TRG_DELETE_QUESTION
    BEFORE delete
    ON `question`
    FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM exam_question WHERE question_id = OLD.ID) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete question because it is part of an exam';
    END IF;
end $$;
DELIMITER ;

# Question 12: Lấy ra thông tin exam trong đó:
# ● Duration <= 30 thì sẽ đổi thành giá trị "Short time"
# ● 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
# ● Duration > 60 thì sẽ đổi thành giá trị "Long time"
SELECT ID,
       TITLE,
       CASE
           WHEN duration <= 30 THEN 'Short time'
           WHEN duration > 30 AND duration <= 60 THEN 'Medium time'
           ELSE 'Long time'
           END AS duration
FROM exam;

# Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên là
# the_number_user_amount và mang giá trị được quy định như sau:
# ● Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
# ● Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
# ● Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
SELECT G.NAME,
       CASE
           WHEN COUNT(ACCOUNT_ID) <= 5 THEN 'FEW'
           WHEN COUNT(ACCOUNT_ID) <= 20 AND COUNT(ACCOUNT_ID) > 5 THEN 'NORMAL'
           WHEN COUNT(ACCOUNT_ID) > 20 THEN 'HIGHER' END AS the_number_user_amount
FROM `group` G
         INNER JOIN group_account GA ON G.ID = GA.GROUP_ID
GROUP BY GA.GROUP_ID;

# Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
# không có user thì sẽ thay đổi giá trị 0 thành "Không có User"

SELECT C.NAME,
       CASE
           WHEN COUNT(A.ID) IS NOT NULL THEN COUNT(A.ID)
           ELSE 'Không có User' END AS the_number_user_amount
FROM account A
         RIGHT JOIN category C ON C.ID = A.DEPARTMENT_ID AND C.TYPE = 'DEPARTMENT'
GROUP BY DEPARTMENT_ID, C.NAME