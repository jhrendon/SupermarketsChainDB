CONNECT SUPERMARKETCHAIN;

-- Creating the VENDORS table and filling it with data 
CREATE TABLE VENDORS
(
  V_ID NUMBER(10) NOT NULL,
  VENDOR_NAME NVARCHAR2(100),
  CONSTRAINT PK_VENDOR_ID PRIMARY KEY (V_ID)
);

CREATE SEQUENCE VENDORS_SEQ
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE OR REPLACE TRIGGER TRIG_VEND
BEFORE INSERT ON VENDORS
FOR EACH ROW
  BEGIN 
    SELECT VENDORS_SEQ.NEXTVAL
    INTO :new.V_ID
    FROM dual;
  END;
 
BEGIN  
  INSERT ALL
    INTO VENDORS (VENDOR_NAME) VALUES ('Coca-Cola Company')
    INTO VENDORS (VENDOR_NAME) VALUES ('James B. Beam Distilling Co.')
    INTO VENDORS (VENDOR_NAME) VALUES ('John Walker and Sons 2015')
    INTO VENDORS (VENDOR_NAME) VALUES ('Kamenitza Ltd.')
    INTO VENDORS (VENDOR_NAME) VALUES ('Zagorka Ltd.')
    INTO VENDORS (VENDOR_NAME) VALUES ('Nestle Corp.')
    INTO VENDORS (VENDOR_NAME) VALUES ('Prestige 96 Ltd.')
    INTO VENDORS (VENDOR_NAME) VALUES ('Mekler Ltd.')
    INTO VENDORS (VENDOR_NAME) VALUES ('Vereya Corp.')
    INTO VENDORS (VENDOR_NAME) VALUES ('Johnson and Johnson Services, Inc.')
    INTO VENDORS (VENDOR_NAME) VALUES ('LOreal Paris, Inc.')
    INTO VENDORS (VENDOR_NAME) VALUES ('Rauch Fruchtsafte GmbH and Co OG')
    INTO VENDORS (VENDOR_NAME) VALUES ('H.J. Heinz Co. (HNZ)')
    INTO VENDORS (VENDOR_NAME) VALUES ('SuiCo EOOD')
    INTO VENDORS (VENDOR_NAME) VALUES ('Frito-Lay North America, Inc.')
    INTO VENDORS (VENDOR_NAME) VALUES ('DEVIN JSC')
    INTO VENDORS (VENDOR_NAME) VALUES ('Aroma PLC')
    INTO VENDORS (VENDOR_NAME) VALUES ('The Procter and Gamble Company')
    INTO VENDORS (VENDOR_NAME) VALUES ('Beiersdorf Inc (NIVEA)')
    INTO VENDORS (VENDOR_NAME) VALUES ('Costa dOro S.p.A.')
    SELECT * FROM dual
    COMMIT;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX
  THEN ROLLBACK;
END;


-- Creating the MEASURE_UNITS and filling it with data
CREATE TABLE MEASURE_UNITS
(
  M_ID NUMBER(10) NOT NULL,
  MEASURE_NAME NVARCHAR2(100),
  CONSTRAINT PK_MEASURE_ID PRIMARY KEY (M_ID)
);

CREATE SEQUENCE MEASURE_UNITS_SEQ
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE OR REPLACE TRIGGER TRIG_MEASURE_UNITS
BEFORE INSERT ON MEASURE_UNITS
FOR EACH ROW
  BEGIN 
    SELECT MEASURE_UNITS_SEQ.NEXTVAL
    INTO :new.M_ID
    FROM dual;
  END;

BEGIN
  INSERT ALL
    INTO MEASURE_UNITS (MEASURE_NAME) VALUES ('liters')
    INTO MEASURE_UNITS (MEASURE_NAME) VALUES ('kg')
    INTO MEASURE_UNITS (MEASURE_NAME) VALUES ('pieces')
    SELECT * FROM dual
    COMMIT;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX
  THEN ROLLBACK;
END;
    

-- Creating the PRODUCTS table and filling with data
CREATE TABLE PRODUCTS
(
  P_ID NUMBER(10) NOT NULL,
  VENDOR_ID NUMBER(10),
  PRODUCT_NAME NVARCHAR2(100),
  MEASURE_ID NUMBER(10),
  PRICE DECIMAL(19,4),
  QUANTITY NUMBER(10),
  PRODUCT_TYPE NVARCHAR2(100),
  CONSTRAINT PK_PRODUCT_ID PRIMARY KEY (P_ID),
  CONSTRAINT FK_VENDORS FOREIGN KEY (VENDOR_ID) REFERENCES VENDORS(V_ID),
  CONSTRAINT FK_MEASURES FOREIGN KEY (MEASURE_ID) REFERENCES MEASURE_UNITS(M_ID)
);

CREATE SEQUENCE PROD_SEQ
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE OR REPLACE TRIGGER TRIG_PROD
  BEFORE INSERT ON PRODUCTS
  FOR EACH ROW
    BEGIN 
      SELECT PROD_SEQ.NEXTVAL
      INTO :new.P_ID
      FROM dual;
    END;
    
BEGIN
  INSERT ALL
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (1, 'Coca-Cola 2l', 3, 2.50, 100, 'non-alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (1, 'Pepsi 2l', 3, 2.30, 210, 'non-alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (2, 'Jim Beam', 3, 20, 20, 'alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (4, 'Kamenitza 0.700l', 3, 1.25, 200, 'alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (5, 'Zagorka 0.700l', 3, 1.52, 350, 'alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (6, 'Nesquik 200g', 3, 4.15, 1000, 'non-alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (6, 'Kit-Kat 90g', 3, 1.00, 100, 'sweets')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (6, 'Nescafe 250g', 3, 9.50, 525, 'non-alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (7, 'Cereal with chocolate', 2, 2.00, 50, 'food')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (7, 'Oatmeal cereal', 2, 2.10, 60, 'food')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (7, 'Cereal with apple and walnut', 2, 2.00, 50, 'food')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (8, 'Rodopsko Chudo cheese', 2, 8.60, 40, 'food')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (8, 'Ovcho Narodno cheese', 2, 8.40, 48, 'food')         
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (17, 'Aroma Vital Exfoliating soap 100g', 3, 0.99, 40, 'body care')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (16, 'Devin Mineral Water 10l', 3, 3.99, 150, 'non-alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (16, 'Devin Mineral Water 1.5l', 3, 0.85, 150, 'non-alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (10, 'JOHNSONíS baby HEAD-TO-TOE wash shampoo 444ml', 
                    3, 3.15, 20, 'body care')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (10, 'JOHNSONíS baby moisture wash with honey apple shampoo 444ml', 
                    3, 3.15, 20, 'body care')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (20, 'Costa d`Oro 1l', 3, 13.59, 40, 'food')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (9, 'Yoghurt 2% 500g', 3, 0.85, 150, 'food')    
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (9, 'Yoghurt 0.1% 450g', 3, 0.90, 150, 'food')  
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (18, 'Head ' || chr(38) || ' Shoulders', 3, 5.35, 120, 'body care')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (12, 'Happy Day 100% Orange 1l', 3, 2.30, 30, 'non-alcohol drinks')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (6, 'Heinz Tomato Ketchup', 3, 4.80, 50, 'food')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (19, 'NIVEA honey ' || chr(38) || ' oil soap', 3, 0.90, 20, 'body care')
    INTO PRODUCTS (VENDOR_ID, PRODUCT_NAME, MEASURE_ID, PRICE, QUANTITY, PRODUCT_TYPE) 
          VALUES  (17, 'Natural Elements Red Fruits soap 100g', 3, 0.99, 50, 'body care')            
    SELECT * FROM dual  
    COMMIT;
EXCEPTION
  WHEN DUP_VAL_ON_INDEX
  THEN ROLLBACK;
END;

CREATE VIEW PRODUCTS_VENDORS_MEASURES
AS
  SELECT p.P_ID, p.PRODUCT_NAME, p.PRICE, p.QUANTITY, m.MEASURE_NAME, p.PRODUCT_TYPE, v.VENDOR_NAME
  FROM PRODUCTS p
  INNER JOIN MEASURE_UNITS m ON m.M_ID = p.MEASURE_ID
  INNER JOIN VENDORS v ON v.V_ID = p.VENDOR_ID
  ORDER BY p.P_ID;
  
-- SELECT * FROM PRODUCTS_VENDORS_MEASURES;  