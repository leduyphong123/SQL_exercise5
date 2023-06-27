USE CLASSICMODELS;

EXPLAIN SELECT*FROM PRODUCTS WHERE productCode = 'S10_1949';
ALTER TABLE PRODUCTS ADD UNIQUE INDEX idx_productCode(productCode);
EXPLAIN SELECT*FROM PRODUCTS WHERE productName ='1952 Alpine Renault 1300' AND buyPrice = 98.58;
ALTER TABLE PRODUCTS ADD UNIQUE INDEX idx_compositer(productName,buyPrice);

ALTER TABLE PRODUCTS DROP INDEX idx_productCode;
ALTER TABLE PRODUCTS DROP INDEX idx_compositer;

CREATE VIEW productView
AS
SELECT productCode,productName,buyPrice,productDescription
FROM PRODUCTS;

SELECT*FROM productView;

CREATE OR REPLACE VIEW productView
AS
SELECT productCode,productName,buyPrice,productDescription,MSRP
FROM PRODUCTS
WHERE productScale='1:10';

SELECT*FROM productView;
DROP VIEW productView;

DELIMITER //
CREATE PROCEDURE getAllProdcut()
BEGIN
	SELECT *FROM PRODUCTS;
END //
DELIMITER ;

CALL getAllProdcut;

DELIMITER //
CREATE PROCEDURE insertPoduct(
	IN productCodeIn VARCHAR(15),
	IN productNameIn VARCHAR(70),
    IN productLineIn VARCHAR(50),
    IN productScaleIn VARCHAR(10),
    IN productVendorIn VARCHAR(50),
    IN productDescriptionIn TEXT,
    IN quantityInStockIn SMALLINT,
    IN buyPriceIn DECIMAL(10,2),
    IN MSRPIn DECIMAL(10,2)
)
BEGIN
	INSERT INTO PRODUCTS (
		productCode,
		productName,
		productLine,
		productScale,
		productVendor,
		productDescription,
		quantityInStock,
		buyPrice,
		MSRP)
    VALUE (
		productCodeIn,
        productNameIn,
        productLineIn,
        productScaleIn,
        productVendorIn,
        productDescriptionIn,
        quantityInStockIn,
        buyPriceIn,
        MSRPIn
    );
    
END //
DELIMITER ;

SELECT*FROM PRODUCTS;
CALL insertPoduct('S10_7978', '1969 Harley Davidson Ultimate Chopper', 'Motorcycles', '1:10', 'Min Lin Diecast', 'This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.', '7133', '48.81', '95.70'
);

DELIMITER //
CREATE PROCEDURE updatePoduct(
	IN productCodeIn VARCHAR(15),
	IN productNameIn VARCHAR(70),
    IN productLineIn VARCHAR(50),
    IN productScaleIn VARCHAR(10),
    IN productVendorIn VARCHAR(50),
    IN productDescriptionIn TEXT,
    IN quantityInStockIn SMALLINT,
    IN buyPriceIn DECIMAL(10,2),
    IN MSRPIn DECIMAL(10,2)
)
BEGIN
	UPDATE PRODUCTS 
    SET 
        productName = productNameIn,
        productLine = productLineIn,
        productScale = productScaleIn,
        productVendor = productVendorIn,
        productDescription = productDescriptionIn,
        quantityInStock =quantityInStockIn,
        buyPrice = buyPriceIn,
        MSRP = MSRP
    
    WHERE productCode = productCodeIn;
    
END //
DELIMITER ;

CALL updatePoduct('S10_7978', '1969 Harley ', 'Motorcycles', '1:10', 'Min Lin Diecast', 'This replica features working kickstand, front suspension, gear-shift lever, footbrake lever, drive chain, wheels and steering. All parts are particularly delicate due to their precise scale and require special care and attention.', '7133', '48.81', '95.70'
);

DELIMITER //
CREATE PROCEDURE deleteProducts(IN productCodeIn VARCHAR(15))
BEGIN
	DELETE FROM PRODUCTS WHERE  productCode = productCodeIn;
END //
DELIMITER ;

CALL deleteProducts('S10_7978');