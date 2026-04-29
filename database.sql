CREATE DATABASE IF NOT EXISTS ecommerce_project;
USE ecommerce_project;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS product;

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    login VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL,
    image VARCHAR(255),
    description TEXT
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    line_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO customer (name, address, phone_number, email) VALUES
('Rym', 'Algiers, Algeria', '0600000007', 'rym@gmail.com');

INSERT INTO account (customer_id, login, password) VALUES
(1, 'rym', '123456');

INSERT INTO product (name, price, category, image, description) VALUES
('MacBook Pro', 28000.00, 'Electronics', 'images/mac.jpg', 'High-performance laptop'),
('HP Elite Dragonfly', 125000.00, 'Electronics', 'images/hp.jpg', 'Business laptop'),
('Atomic Habits', 2200.00, 'Books', 'images/atomic .jpg', 'Self-development book'),
('Burgundy Ruched Midi Dress', 4990.00, 'Clothing', 'images/red dress.jpg', 'Elegant burgundy dress');
