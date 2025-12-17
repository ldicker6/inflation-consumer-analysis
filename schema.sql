CREATE TABLE Household_Types(
household_type_code VARCHAR(10) PRIMARY KEY,
description VARCHAR(50) NOT NULL
);
CREATE TABLE Income_Brackets(
income_bracket_code VARCHAR(10) PRIMARY KEY,
description VARCHAR(50) NOT NULL,
min_income DECIMAL(10,2),
max_income DECIMAL(10,2)
);
CREATE TABLE Store_Types(
store_type_code VARCHAR(10) PRIMARY KEY,
description VARCHAR(50) NOT NULL
);
CREATE TABLE Product_Categories(
category_main VARCHAR(20),
category_detail VARCHAR(30),
description VARCHAR(50),
PRIMARY KEY (category_main, category_detail)
);
CREATE TABLE Households(
household_id VARCHAR(6) PRIMARY KEY,
household_type_code VARCHAR(10) NOT NULL,
income_bracket_code VARCHAR(10) NOT NULL,
region VARCHAR(20) NOT NULL,
city VARCHAR(30),
postal_code VARCHAR(10),
num_children INT,
vehicle_access VARCHAR(15),
housing_type VARCHAR(20),
FOREIGN KEY (household_type_code)
REFERENCES Household_Types(household_type_code),
FOREIGN KEY (income_bracket_code)
REFERENCES Income_Brackets(income_bracket_code)
);
CREATE TABLE Persons(
person_id VARCHAR(6) PRIMARY KEY,
household_id VARCHAR(6) NOT NULL,
age_group VARCHAR(20),
gender VARCHAR(10),
employment_status VARCHAR(20),
role_in_household VARCHAR(30),
is_primary_shopper INT,
FOREIGN KEY (household_id)
REFERENCES Households(household_id)
);
CREATE TABLE Stores(
store_id VARCHAR(6) PRIMARY KEY,
store_name VARCHAR(50) NOT NULL,
store_type_code VARCHAR(10) NOT NULL,
region VARCHAR(20),
city VARCHAR(30),
is_discount_store INT,
FOREIGN KEY (store_type_code)
REFERENCES Store_Types(store_type_code)
);
CREATE TABLE Products(
product_id VARCHAR(6) PRIMARY KEY,
product_name VARCHAR(50) NOT NULL,
category_main VARCHAR(20) NOT NULL,
category_detail VARCHAR(30) NOT NULL,
brand_type VARCHAR(20),
package_size VARCHAR(20),
unit_measure VARCHAR(10),
FOREIGN KEY (category_main, category_detail)
REFERENCES Product_Categories(category_main, category_detail)
);
CREATE TABLE Purchases(
purchase_id VARCHAR(6) PRIMARY KEY,
household_id VARCHAR(6) NOT NULL,
buyer_person_id VARCHAR(6) NOT NULL,
store_id VARCHAR(6) NOT NULL,
purchase_datetime DATETIME NOT NULL,
payment_method VARCHAR(20),
total_amount DECIMAL(10,2),
FOREIGN KEY (household_id)
REFERENCES Households(household_id),
FOREIGN KEY (buyer_person_id)
REFERENCES Persons(person_id),
FOREIGN KEY (store_id)
REFERENCES Stores(store_id)
);
CREATE TABLE Purchase_Items(
purchase_id VARCHAR(6),
line_number INT,
product_id VARCHAR(6),
quantity INT,
unit_price DECIMAL(10,2),
discount_amount DECIMAL(10,2),
promo_applied INT,
PRIMARY KEY (purchase_id, line_number),
FOREIGN KEY (purchase_id)
REFERENCES Purchases(purchase_id),
FOREIGN KEY (product_id)
REFERENCES Products(product_id)
);
CREATE TABLE Price_History(
product_id VARCHAR(6),
store_id VARCHAR(6),
price_date DATE,
regular_price DECIMAL(10,2),
promo_price DECIMAL(10,2),
price_source VARCHAR(30),
PRIMARY KEY (product_id, store_id, price_date),
FOREIGN KEY (product_id)
REFERENCES Products(product_id),
FOREIGN KEY (store_id)
REFERENCES Stores(store_id)
);
CREATE TABLE Inflation_Indicators(
month_start DATE PRIMARY KEY,
cpi_overall DECIMAL(6,2),
cpi_food DECIMAL(6,2),
cpi_energy DECIMAL(6,2),
gas_price_avg DECIMAL(6,2)
);
