USE
    TESTINGSYSTEM;


# 1. Tạo bảng vớiràng buộc và kiểu dữ liệu. Sau đó, thêm ít nhất 5 bản ghi vào
# bảng.
DROP TABLE IF EXISTS `CUSTOMER`;
CREATE TABLE CUSTOMER
(
    CUSTOMER_ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME        VARCHAR(50) NOT NULL,
    PHONE       VARCHAR(20) NOT NULL,
    EMAIL       VARCHAR(50) NOT NULL,
    ADDRESS     VARCHAR(50),
    NOTE        TEXT
);

DROP TABLE IF EXISTS `CAR`;
CREATE TABLE CAR
(
    CAR_ID INT PRIMARY KEY AUTO_INCREMENT,
    MAKER  ENUM ('HONDA','TOYOTA','NISSAN') NOT NULL,
    MODEL  VARCHAR(255) UNIQUE              NOT NULL,
    YEAR   VARCHAR(5)                       NOT NULL,
    COLOR  VARCHAR(50)                      NOT NULL,
    NOTE   TEXT
);

DROP TABLE IF EXISTS `CAR_ORDER`;
CREATE TABLE CAR_ORDER
(
    ORDER_ID         INT PRIMARY KEY AUTO_INCREMENT          NOT NULL,
    CUSTOMER_ID      INT                                     NOT NULL,
    CAR_ID           INT                                     NOT NULL,
    AMOUNT           TINYINT                                 NOT NULL,
    SALE_PRICE       DECIMAL(10, 2)                          NOT NULL,
    ORDER_DATE       DATE                                    NOT NULL,
    DELIVERY_DATE    DATE,
    DELIVERY_ADDRESS VARCHAR(255),
    STATUS           ENUM ('ORDERED','DELIVERED','CANCELED') NOT NULL,
    NOTE             TEXT,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID),
    FOREIGN KEY (CAR_ID) REFERENCES CAR (CAR_ID)
);

INSERT INTO CUSTOMER ( NAME, PHONE, EMAIL, ADDRESS, NOTE )
VALUES
    ( 'NAME1', '0123456789', 'email1@gmail.com', 'ADDRESS1', '1' ),
    ( 'NAME2', '0123456789', 'email2@gmail.com', 'ADDRESS2', '2' ),
    ( 'NAME3', '0123456789', 'email3@gmail.com', 'ADDRESS3', '3' ),
    ( 'NAME4', '0123456789', 'email4@gmail.com', 'ADDRESS4', '4' ),
    ( 'NAME5', '0123456789', 'email5@gmail.com', 'ADDRESS5', '5' ),
    ( 'NAME6', '0123456789', 'email6@gmail.com', 'ADDRESS6', '6' ),
    ( 'NAME7', '0123456789', 'email7@gmail.com', 'ADDRESS7', '7' ),
    ( 'NAME8', '0123456789', 'email8@gmail.com', 'ADDRESS8', '8' );

insert into CAR ( MAKER, MODEL, YEAR, COLOR, NOTE )
values
    ( 'HONDA',  'MODEL1', '1997', 'RED1', '1' ),
    ( 'HONDA',  'MODEL2', '1997', 'RED2', '2' ),
    ( 'HONDA',  'MODEL3', '1997', 'RED3', '3' ),
    ( 'HONDA',  'MODEL4', '1997', 'RED4', '4' ),
    ( 'TOYOTA', 'MODEL5', '1997', 'RED5', '5' ),
    ( 'TOYOTA', 'MODEL6', '1997', 'RED6', '6' ),
    ( 'NISSAN', 'MODEL7', '1997', 'RED7', '7' ),
    ( 'NISSAN', 'MODEL8', '1997', 'RED8', '8' );

INSERT INTO CAR_ORDER ( CUSTOMER_ID, CAR_ID, AMOUNT, SALE_PRICE, ORDER_DATE, DELIVERY_DATE, DELIVERY_ADDRESS, STATUS,
                        NOTE )
VALUES
    ( 1, 1, 1, 20000.00, '2023-01-15', '2023-01-20', '123 Elm St',   'DELIVERED', 'Delivered on time' ),
    ( 2, 2, 2, 18000.00, '2023-02-10', '2023-02-25', '456 Oak St',   'DELIVERED', 'Delivered on time' ),
    ( 3, 3, 1, 22000.00, '2023-03-05', '2023-03-20', '789 Pine St',  'DELIVERED', 'Delivered on time' ),
    ( 4, 4, 1, 25000.00, '2023-04-01', NULL,         '321 Maple St', 'ORDERED',   'Pending delivery'  ),
    ( 5, 5, 1, 24000.00, '2023-05-20', '2023-06-05', '654 Cedar St', 'DELIVERED', 'Delivered on time' );

# 2. Viết lệnh lấy ra thông tin của khách hàng: tên, số lượng oto khách hàng đã
# mua và sắp sếp tăng dần theo số lượng oto đã mua.
SELECT c.Name, SUM(co.Amount) AS TotalCarsPurchased
FROM CUSTOMER c
         JOIN CAR_ORDER co ON c.CUSTOMER_ID = co.CUSTOMER_ID
GROUP BY c.Name
ORDER BY TotalCarsPurchased ASC;

# 3. Viết hàm (không có parameter) trả về tên hãng sản xuất đã bán được
# nhiều oto nhất trong năm nay.

DELIMITER $$

CREATE FUNCTION top_selling_maker_this_year() RETURNS VARCHAR(50)
BEGIN
    DECLARE top_maker VARCHAR(50);

    SELECT Maker
    INTO top_maker
    FROM CAR_ORDER co
             JOIN CAR c ON co.CAR_ID = c.CAR_ID
    WHERE YEAR(co.ORDER_DATE) = YEAR(CURDATE())
    GROUP BY c.Maker
    ORDER BY SUM(co.Amount) DESC
    LIMIT 1;

    RETURN top_maker;
END$$

DELIMITER ;
# 4. Viết 1 thủ tục (không có parameter) để xóa các đơn hàng đã bị hủy của
# những năm trước. In ra số lượng bản ghi đã bị xóa.


DELIMITER $$

CREATE PROCEDURE delete_old_cancelled_orders()
BEGIN
    DECLARE deleted_rows INT;

    DELETE
    FROM CAR_ORDER
    WHERE Status = 2
      AND YEAR(ORDER_DATE) < YEAR(CURDATE());

    SET deleted_rows = ROW_COUNT();

    SELECT CONCAT('Number of deleted records: ', deleted_rows) AS result;
END$$

DELIMITER ;

# 5. Viết 1 thủ tục (có CustomerID parameter) để in ra thông tin của các đơn
# hàng đã đặt hàng bao gồm: tên của khách hàng, mã đơn hàng, số lượng
# oto và tên hãng sản xuất.


DELIMITER $$

CREATE PROCEDURE GET_CUSTOMER_ORDERS(IN P_CUSTOMER_ID INT)
BEGIN
    SELECT C.NAME, CO.ORDER_ID, CO.AMOUNT, C.MAKER
    FROM CUSTOMER C
             JOIN CAR_ORDER CO ON C.CUSTOMER_ID = CO.CUSTOMER_ID
             JOIN CAR C ON CO.CAR_ID = C.CAR_ID
    WHERE C.CUSTOMER_ID = P_CUSTOMER_ID
      AND CO.STATUS = 0;
END$$

DELIMITER ;

# 6. Viết trigger để tránh trường hợp người dụng nhập thông tin không hợp lệ
# vào database (DeliveryDate < OrderDate + 15).
DELIMITER $$

CREATE TRIGGER check_delivery_date
    BEFORE INSERT
    ON CAR_ORDER
    FOR EACH ROW
BEGIN
    IF NEW.DELIVERY_DATE IS NOT NULL AND NEW.DELIVERY_DATE < NEW.ORDER_DATE + INTERVAL 15 DAY THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Delivery date must be at least 15 days after order date';
    END IF;
END$$

DELIMITER ;
