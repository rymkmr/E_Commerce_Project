CREATE DATABASE IF NOT EXISTS ecommerce_project;
USE ecommerce_project;
CREATE TABLE account (
    login VARCHAR(100) PRIMARY KEY,
    password VARCHAR(100) NOT NULL
);
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(100) NOT NULL,
    phone_number VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL,
    image VARCHAR(255) NOT NULL,
    description TEXT NOT NULL
);
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);
INSERT INTO account (login, password) VALUES
('rym@gmail.com', 'rym');
INSERT INTO customer (name, address, phone_number, email) VALUES
('rym', 'Algiers, Algeria', '0600000007', 'rym@gmail.com');
/*INSERT INTO product (name, price, category, image, description) VALUES
('product', , '', '', ''),
.
.
.
;*/
INSERT INTO orders (customer_id, product_id, quantity, order_date, total_price) VALUES
(1, 1, 2, NOW(), 240000.00);



