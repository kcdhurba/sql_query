-- this is a sample database to demonstrate how product could be managed
-- in convinient store. It allows to manage product details, supplier info, 
-- sales trasaction, and expenses effectively. It also helps in tracking 
-- inventory levels, sales activities, and supllier info. 


-- create a table for products 

CREATE TABLE Product_info( 
	product_id SERIAL PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL UNIQUE, 
	category VARCHAR(50),
	taxable BOOLEAN NOT NULL, 
	costprice DECIMAL(10,2) NOT NULL,
	sellingprice DECIMAL(5,2) NOT NULL, 
	quantity INT NOT NULL,
	stockquantity INT,
	expdate DATE,
	supplier_id INT,
	FOREIGN KEY(supplier_id) REFERENCES suppliers(supplier_id)
	
)

-- create salesinfo table 

CREATE TABLE sales_info(
	sale_id SERIAL PRIMARY KEY,
	product_id INT, 
	sales_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
	total_amount DECIMAL(10,2) NOT NULL, 
	quantitysold INT NOT NULL, 
	FOREIGN KEY(product_id) REFERENCES Product_info(product_id)


)
 -- create a table for different venders. 
CREATE TABLE suppliers (
	supplier_id SERIAL PRIMARY KEY, 
	supplier_name VARCHAR(50) NOT NULL UNIQUE, 
	salesrepresentative VARCHAR(100) NOT NULL, 
	phonenumber VARCHAR(15) NOT NULL,
	email VARCHAR(100) UNIQUE 

)
 -- table to track the spending. 
CREATE TABLE expenses(
	expense_id SERIAL PRIMARY KEY, 
	description VARCHAR(200) NOT NULL, 
	amount DECIMAL(10,2) NOT NULL, 
	expense_date DATE NOT NULL 
	
)

-- Inserting sample data into the suppliers table

INSERT INTO suppliers (supplier_name, salesrepresentative, phonenumber, email) VALUES
('ABC Suppliers', 'John Doe', '123-456-7890', 'john.doe@abcsuppliers.com'),
('XYZ Distributors', 'Jane Smith', '987-654-3210', 'jane.smith@xyzdistributors.com'),
('123 Wholesale', 'Mike Johnson', '555-123-4567', 'mike.johnson@123wholesale.com'),
('Global Inc.', 'Anna Lee', '111-222-3333', 'anna.lee@globalinc.com'),
('Best Deals Co.', 'Robert Brown', '444-555-6666', 'robert.brown@bestdealsco.com');


-- Inserting sample data into the expenses table
INSERT INTO expenses (description, amount, expense_date) VALUES
('Office Supplies', 150.75, '2024-01-05'),
('Utility Bills', 500.00, '2024-01-10'),
('Marketing Campaign', 1200.50, '2024-01-15'),
('Maintenance Costs', 300.25, '2024-01-20'),
('Employee Salaries', 4500.00, '2024-01-25');

-- Inserting 5 sample data into the Product_info table for a convenience store
INSERT INTO Product_info (product_name, category, taxable, costprice, sellingprice, quantity, stockquantity, expdate, supplier_id) VALUES
('Bottled Water', 'Beverages', FALSE, 0.50, 1.00, 200, 500, '2024-12-31', 1),
('Potato Chips', 'Snacks', TRUE, 0.75, 1.50, 150, 300, '2024-10-31', 2),
('Candy Bar', 'Sweets', TRUE, 0.50, 1.00, 100, 200, '2024-09-30', 3),
('Soft Drink', 'Beverages', TRUE, 0.60, 1.25, 180, 400, '2024-11-30', 1),
('Instant Coffee', 'Beverages', TRUE, 4.00, 6.00, 50, 100, '2025-06-30', 5);

-- Inserting 5 sample sales records into the sales_info table for a convenience store
INSERT INTO sales_info (product_id, total_amount, quantitysold) VALUES
(1, 1.00, 2),
(2, 2.25, 3),
(3, 0.75, 1),
(4, 1.25, 2),
(5, 5.50, 1);

-- some operations on table: 

UPDATE suppliers
SET supplier_name = 'COCA COLA DISTRIBUTORS'
WHERE supplier_name = 'ABC Suppliers';

UPDATE expenses 
SET expense_date = CURRENT_TIMESTAMP 
WHERE expense_date >= '2024-01-15';

DELETE FROM expenses 
WHERE amount<200;

ALTER TABLE expenses
ADD COLUMN payment_method VARCHAR(50);

UPDATE expenses 
SET payment_method = 'CASH'
WHERE amount<500;

ALTER TABLE product_info
DROP COLUMN taxable;

ALTER TABLE sales_info
RENAME TO sales;

ALTER TABLE sales 
RENAME COLUMN quantitysold TO salesquantity;

ALTER TABLE product_info 
ALTER COLUMN quantity DROP NOT NULL;




























