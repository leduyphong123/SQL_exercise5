USE CLASSICMODELS;

DELIMITER //
CREATE PROCEDURE findAllCustomers()
BEGIN 
		SELECT*FROM CUSTOMERS;
END //
DELIMITER ;

CALL findAllCustomers;

DELIMITER //
DROP PROCEDURE IF EXISTS `findAllCustomers`//

CREATE PROCEDURE findAllCustomers()

BEGIN

SELECT * FROM customers where customerNumber = 175;

END //
