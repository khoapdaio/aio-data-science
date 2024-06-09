use TESTINGSYSTEM;

# Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
create or replace view v_nv_sale as
select a.*, c.name as name_department
from account a
         inner join category c on a.DEPARTMENT_ID = c.ID
where c.NAME = 'Sale';

select *
from v_nv_sale;

# Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
create or replace view v_account_group_top as
select a.*, count(ga.GROUP_ID) as number_of_group
from account a
         inner join group_account ga on a.ID = ga.ACCOUNT_ID
group by ga.ACCOUNT_ID
order by count(ga.GROUP_ID) desc;

select *
from v_account_group_top;

# Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
# được coi là quá dài) và xóa nó đi

create or replace view v_question_long_content as
select *
from question
where length(CONTENT) > 300;

select *
from v_question_long_content;

# Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
create or replace view v_department_max_account as
select `c`.`NAME` AS `NAME`, count(`a`.`ID`) AS `count(a.id)`
from (`testingsystem`.`account` `a` join `testingsystem`.`category` `c` on ((`a`.`DEPARTMENT_ID` = `c`.`ID`)))
where (`c`.`TYPE` = 'DEPARTMENT')
group by `a`.`DEPARTMENT_ID`, `c`.`NAME`
order by count(`a`.`ID`) desc;

select *
from v_department_max_account;

# Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
create or replace view v_account_nguyen as
select `testingsystem`.`account`.`ID`            AS `ID`,
       `testingsystem`.`account`.`EMAIL`         AS `EMAIL`,
       `testingsystem`.`account`.`USERNAME`      AS `USERNAME`,
       `testingsystem`.`account`.`FULLNAME`      AS `FULLNAME`,
       `testingsystem`.`account`.`DEPARTMENT_ID` AS `DEPARTMENT_ID`,
       `testingsystem`.`account`.`POSITION_ID`   AS `POSITION_ID`,
       `testingsystem`.`account`.`CREATE_AT`     AS `CREATE_AT`
from `testingsystem`.`account`
where (`testingsystem`.`account`.`FULLNAME` like 'Nguyễn%');

select *
from v_account_nguyen;

