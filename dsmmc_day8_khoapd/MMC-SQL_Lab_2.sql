-- CREATE DATABASE
DROP
    DATABASE IF EXISTS TESTINGSYSTEM;
CREATE
    DATABASE TESTINGSYSTEM;
USE
    TESTINGSYSTEM;

# TẠO MỚI BẢNG DANH MỤC CHỨA: DEPARTMENT,POSITION, TYPE_QUESTION, CATEGORY_QUESTION,
# GROUP, PHÂN BIỆT BẰNG TYPE
DROP TABLE IF EXISTS `CATEGORY`;
CREATE TABLE `CATEGORY`
(
    ID   INT PRIMARY KEY AUTO_INCREMENT,
    TYPE enum ('DEPARTMENT','POSITION', 'TYPE_QUESTION', 'CATEGORY_QUESTION') NOT NULL,
    NAME VARCHAR(50)                                                          NOT NULL
);

-- CREATE TABLE: ACCOUNT
DROP TABLE IF EXISTS `ACCOUNT`;
CREATE TABLE `ACCOUNT`
(
    ID            INT PRIMARY KEY AUTO_INCREMENT,
    EMAIL         VARCHAR(50) UNIQUE,
    USERNAME      VARCHAR(50),
    FULLNAME      CHAR(50),
    DEPARTMENT_ID INT,
    POSITION_ID   INT,
    CREATE_AT     DATE
);

-- CREATE TABLE: GROUP
DROP TABLE IF EXISTS `GROUP`;
CREATE TABLE `GROUP`
(
    ID         INT PRIMARY KEY AUTO_INCREMENT,
    NAME       VARCHAR(50) NOT NULL UNIQUE,
    CREATOR_ID INT,
    CREATE_AT  DATE
);


-- CREATE TABLE: GROUPACCOUNT
DROP TABLE IF EXISTS `GROUP_ACCOUNT`;
CREATE TABLE GROUP_ACCOUNT
(
    GROUP_ID   INT,
    ACCOUNT_ID INT,
    JOIN_AT    DATE,
    primary key (group_id, account_id)
);

-- CREATE TABLE: QUESTION
DROP TABLE IF EXISTS `QUESTION`;
CREATE TABLE QUESTION
(
    ID          INT PRIMARY KEY AUTO_INCREMENT,
    CONTENT     VARCHAR(100),
    CATEGORY_ID INT,
    TYPE_ID     INT,
    CREATOR_ID  INT,
    CREATE_AT   DATE
);

-- CREATE TABLE: ANSWER
DROP TABLE IF EXISTS `ANSWER`;
CREATE TABLE ANSWER
(
    ID          INT PRIMARY KEY AUTO_INCREMENT,
    CONTENT     VARCHAR(50),
    QUESTION_ID INT,
    IS_CORRECT  BIT
);

-- CREATE TABLE: EXAM
DROP TABLE IF EXISTS `EXAM`;
CREATE TABLE EXAM
(
    ID          INT PRIMARY KEY AUTO_INCREMENT,
    CODES       VARCHAR(10),
    TITLE       VARCHAR(50),
    CATEGORY_ID INT,
    DURATION    INT,
    CREATOR_ID  INT,
    CREATE_AT   DATE
);

-- CREATE TABLE: EXAMQUESTION
DROP TABLE IF EXISTS `EXAM_QUESTION`;
CREATE TABLE EXAM_QUESTION
(
    EXAM_ID     INT,
    QUESTION_ID INT
);

ALTER TABLE `ACCOUNT`
    ADD FOREIGN KEY FK_ACCOUNT_CATEGORY_DEP (DEPARTMENT_ID) REFERENCES `CATEGORY` (ID);
ALTER TABLE `ACCOUNT`
    ADD FOREIGN KEY FK_ACCOUNT_CATEGORY_POS (POSITION_ID) REFERENCES `CATEGORY` (ID);
ALTER TABLE `GROUP_ACCOUNT`
    ADD FOREIGN KEY FK_GROUP_ACCOUNT_GRP (GROUP_ID) REFERENCES `GROUP` (ID);
ALTER TABLE `GROUP_ACCOUNT`
    ADD FOREIGN KEY FK_GROUP_ACCOUNT_ACCOUNT (ACCOUNT_ID) REFERENCES `ACCOUNT` (ID);
ALTER TABLE `QUESTION`
    ADD FOREIGN KEY FK_QUESTION_CATEGORY (CATEGORY_ID) REFERENCES `CATEGORY` (ID);
ALTER TABLE `QUESTION`
    ADD FOREIGN KEY FK_QUESTION_CATEGORY_TYPE (TYPE_ID) REFERENCES `CATEGORY` (ID);
ALTER TABLE `ANSWER`
    ADD FOREIGN KEY FK_ANSWER_QUESTION (QUESTION_ID) REFERENCES `QUESTION` (ID);
ALTER TABLE `EXAM`
    ADD FOREIGN KEY FK_EXAM_CATEGORY (CATEGORY_ID) REFERENCES `CATEGORY` (ID);
ALTER TABLE `EXAM_QUESTION`
    ADD FOREIGN KEY FK_EXAM_QUESTION_EXAM (EXAM_ID) REFERENCES `EXAM` (ID);
ALTER TABLE `EXAM_QUESTION`
    ADD FOREIGN KEY FK_EXAM_QUESTION_QUESTION (QUESTION_ID) REFERENCES `QUESTION` (ID);

INSERT INTO `CATEGORY` ( TYPE, NAME )
VALUES
    ( 'DEPARTMENT',        N'Marketing'       ),
    ( 'DEPARTMENT',        N'Sale'            ),
    ( 'DEPARTMENT',        N'Bảo vệ'          ),
    ( 'DEPARTMENT',        N'Nhân sự'         ),
    ( 'DEPARTMENT',        N'Kỹ thuật'        ),
    ( 'DEPARTMENT',        N'Tài chính'       ),
    ( 'DEPARTMENT',        N'Phó giám đốc'    ),
    ( 'DEPARTMENT',        N'Giám đốc'        ),
    ( 'DEPARTMENT',        N'Thư kí'          ),
    ( 'DEPARTMENT',        N'Bán hàng'        ),
    ( 'POSITION',          N'Dev'             ),
    ( 'POSITION',          N'Test'            ),
    ( 'POSITION',          N'Scrum master'    ),
    ( 'POSITION',          N'PM'              ),
    ( 'TYPE_QUESTION',     N'Essay'           ),
    ( 'TYPE_QUESTION',     N'Multiple-Choice' ),
    ( 'CATEGORY_QUESTION', N'Java'            ),
    ( 'CATEGORY_QUESTION', N'ASP.NET'         ),
    ( 'CATEGORY_QUESTION', N'ADO.NET'         ),
    ( 'CATEGORY_QUESTION', N'SQL'             ),
    ( 'CATEGORY_QUESTION', N'Postman'         ),
    ( 'CATEGORY_QUESTION', N'Ruby'            ),
    ( 'CATEGORY_QUESTION', N'Python'          ),
    ( 'CATEGORY_QUESTION', N'C++'             ),
    ( 'CATEGORY_QUESTION', N'C Sharp'         ),
    ( 'CATEGORY_QUESTION', N'PHP'             );

INSERT INTO `ACCOUNT`( EMAIL, USERNAME, FULLNAME, DEPARTMENT_ID, POSITION_ID, CREATE_AT )
VALUES
    ( 'haidang29productions@gmail.com', 'dangblack',    'Nguyễn hải Đăng',     '5',  '11', '2020-03-05' ),
    ( 'account1@gmail.com',             'quanganh',     'Nguyen Chien Thang2', '1',  '12', '2020-03-05' ),
    ( 'account2@gmail.com',             'vanchien',     'Nguyen Van Chien',    '2',  '13', '2020-03-07' ),
    ( 'account3@gmail.com',             'cocoduongqua', 'Duong Do',            '3',  '14', '2020-03-08' ),
    ( 'account4@gmail.com',             'doccocaubai',  'Nguyen Chien Thang1', '4',  '14', '2020-03-10' ),
    ( 'dapphatchetngay@gmail.com',      'khabanh',      'Ngo Ba Kha',          '6',  '13', '2020-04-05' ),
    ( 'songcodaoly@gmail.com',          'huanhoahong',  'Bui Xuan Huan',       '7',  '12', NULL         ),
    ( 'sontungmtp@gmail.com',           'tungnui',      'Nguyen Thanh Tung',   '8',  '11', '2020-04-07' ),
    ( 'duongghuu@gmail.com',            'duongghuu',    'Duong Van Huu',       '9',  '12', '2020-04-07' ),
    ( 'vtiaccademy@gmail.com',          'vtiaccademy',  'Vi Ti Ai',            '10', '11', '2020-04-09' );

-- Add data Group
INSERT INTO `Group` ( NAME, ID, CREATE_AT )
VALUES
    ( N'Testing System',   5,  '2019-03-05' ),
    ( N'Development',      1,  '2020-03-07' ),
    ( N'VTI Sale 01',      2,  '2020-03-09' ),
    ( N'VTI Sale 02',      3,  '2020-03-10' ),
    ( N'VTI Sale 03',      4,  '2020-03-28' ),
    ( N'VTI Creator',      6,  '2020-04-06' ),
    ( N'VTI Marketing 01', 7,  '2020-04-07' ),
    ( N'Management',       8,  '2020-04-08' ),
    ( N'Chat with love',   9,  '2020-04-09' ),
    ( N'Vi Ti Ai',         10, '2020-04-10' );

-- Add data GroupAccount
INSERT INTO `GROUP_ACCOUNT` ( GROUP_ID, ACCOUNT_ID, JOIN_AT )
VALUES
    ( 1,  1,  '2019-03-05' ),
    ( 1,  2,  '2020-03-07' ),
    ( 3,  3,  '2020-03-09' ),
    ( 3,  4,  '2020-03-10' ),
    ( 5,  5,  '2020-03-28' ),
    ( 1,  3,  '2020-04-06' ),
    ( 1,  7,  '2020-04-07' ),
    ( 8,  3,  '2020-04-08' ),
    ( 1,  9,  '2020-04-09' ),
    ( 10, 10, '2020-04-10' );


-- Add data Question
INSERT INTO QUESTION ( CONTENT, CATEGORY_ID, TYPE_ID, CREATOR_ID, CREATE_AT )
VALUES
    ( N'Câu hỏi về Java Câu hỏi về Java Câu hỏi về Java Câu hỏi về Java',
                         1,  '1', '2',  '2020-04-05' ),
    ( N'Câu Hỏi về PHP', 10, '2', '2',  '2020-04-05' ),
    ( N'Hỏi về C#',      9,  '2', '3',  '2020-04-06' ),
    ( N'Hỏi về Ruby',    6,  '1', '4',  '2020-04-06' ),
    ( N'Hỏi về Postman', 5,  '1', '5',  '2020-04-06' ),
    ( N'Hỏi về ADO.NET', 3,  '2', '6',  '2020-04-06' ),
    ( N'Hỏi về ASP.NET', 2,  '1', '7',  '2020-04-06' ),
    ( N'Hỏi về C++',     8,  '1', '8',  '2020-04-07' ),
    ( N'Hỏi về SQL',     4,  '2', '9',  '2020-04-07' ),
    ( N'Hỏi về Python',  7,  '1', '10', '2020-04-07' );

-- Add data Answers
INSERT INTO ANSWER ( CONTENT, QUESTION_ID, IS_CORRECT )
VALUES
    ( N'Trả lời 01', 1,  0 ),
    ( N'Trả lời 02', 1,  1 ),
    ( N'Trả lời 03', 1,  0 ),
    ( N'Trả lời 04', 1,  1 ),
    ( N'Trả lời 05', 2,  1 ),
    ( N'Trả lời 06', 3,  1 ),
    ( N'Trả lời 07', 4,  0 ),
    ( N'Trả lời 08', 8,  0 ),
    ( N'Trả lời 09', 9,  1 ),
    ( N'Trả lời 10', 10, 1 );

-- Add data Exam
INSERT INTO EXAM ( CODES, TITLE, CATEGORY_ID, DURATION, CREATOR_ID, CREATE_AT )
VALUES
    ( 'VTIQ001', N'Đề thi C#',      17, 60,  '5',  '2019-04-05' ),
    ( 'VTIQ002', N'Đề thi PHP',     18, 60,  '2',  '2019-04-05' ),
    ( 'VTIQ003', N'Đề thi C++',     19, 120, '2',  '2019-04-07' ),
    ( 'VTIQ004', N'Đề thi Java',    20, 60,  '3',  '2020-04-08' ),
    ( 'VTIQ005', N'Đề thi Ruby',    21, 120, '4',  '2020-04-10' ),
    ( 'VTIQ006', N'Đề thi Postman', 22, 60,  '6',  '2020-04-05' ),
    ( 'VTIQ007', N'Đề thi SQL',     23, 60,  '7',  '2020-04-05' ),
    ( 'VTIQ008', N'Đề thi Python',  24, 60,  '8',  '2020-04-07' ),
    ( 'VTIQ009', N'Đề thi ADO.NET', 25, 90,  '9',  '2020-04-07' ),
    ( 'VTIQ010', N'Đề thi ASP.NET', 26, 90,  '10', '2020-04-08' );


-- Add data ExamQuestion
INSERT INTO EXAM_QUESTION( EXAM_ID, QUESTION_ID )
VALUES
    ( 1,  5  ),
    ( 2,  10 ),
    ( 3,  4  ),
    ( 4,  3  ),
    ( 5,  7  ),
    ( 6,  10 ),
    ( 7,  2  ),
    ( 8,  10 ),
    ( 9,  9  ),
    ( 10, 8  );