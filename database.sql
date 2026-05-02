
-- This file creates the MySQL database required by the WAD homework.

-- This line creates the database only if it does not already exist.
CREATE DATABASE IF NOT EXISTS ecommerce_project;

-- This line selects the project database so the next commands affect it.
USE ecommerce_project;

-- This line removes old order rows first because orders depend on products and customers.
DROP TABLE IF EXISTS orders;

-- This line removes old products so product_id can use the corrected text ids from the website.
DROP TABLE IF EXISTS product;

-- This line removes old accounts so demo login data can be recreated cleanly.
DROP TABLE IF EXISTS account;

-- This line removes old customers after dependent tables are removed.
DROP TABLE IF EXISTS customer;

-- This table stores login credentials required by the homework.
CREATE TABLE account (
    -- This column stores the login email and is the primary key.
    login VARCHAR(100) PRIMARY KEY,
    -- This column stores the password used by login.php.
    password VARCHAR(100) NOT NULL
);

-- This table stores customer profile information required by the homework.
CREATE TABLE customer (
    -- This column uniquely identifies each customer.
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    -- This column stores the customer's full name.
    name VARCHAR(100) NOT NULL,
    -- This column stores the customer's address.
    address VARCHAR(150) NOT NULL,
    -- This column stores the customer's phone number.
    phone_number VARCHAR(20) NOT NULL,
    -- This column stores the customer's email and must be unique.
    email VARCHAR(100) NOT NULL UNIQUE
);

-- This table stores products required by the homework.
CREATE TABLE product (
    -- This column stores ids like electronics-001, matching the JavaScript cart.
    product_id VARCHAR(40) PRIMARY KEY,
    -- This column stores the product name shown on the page.
    name VARCHAR(140) NOT NULL,
    -- This column stores the product price as a number.
    price DECIMAL(10,2) NOT NULL,
    -- This column stores the category name.
    category VARCHAR(50) NOT NULL,
    -- This column stores the image path used by the HTML/JavaScript.
    image VARCHAR(255) NOT NULL,
    -- This column stores a short explanation of the product.
    description TEXT NOT NULL
);

-- This table stores submitted orders required by the homework.
CREATE TABLE orders (
    -- This column uniquely identifies each order row.
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    -- This column links the order to the customer who bought the product.
    customer_id INT NOT NULL,
    -- This column links the order to the purchased product.
    product_id VARCHAR(40) NOT NULL,
    -- This column stores the chosen quantity.
    quantity INT NOT NULL,
    -- This column stores the date and time of checkout.
    order_date DATETIME NOT NULL,
    -- This column stores the subtotal for that product row.
    total_price DECIMAL(10,2) NOT NULL,
    -- This foreign key protects the customer link.
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    -- This foreign key protects the product link.
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

-- This line inserts the demo account used by login.php and the static fallback.
INSERT INTO account (login, password) VALUES
('rym.khoumeri@email.com', 'rym123456');

-- This line inserts the corrected demo customer name.
INSERT INTO customer (customer_id, name, address, phone_number, email) VALUES
(1, 'Rym Khoumeri', 'Algiers, Algeria', '0600000007', 'rym.khoumeri@email.com');

-- These rows seed the product table so save_order.php can reference all visible products.
INSERT INTO product (product_id, name, price, category, image, description) VALUES
('electronics-001', 'MacBook Pro (Space Black)', 280000.00, 'Electronics', 'images/mac.jpg', 'High-performance laptop for creators featuring Apple M-series power.'),
('electronics-002', 'HP Elite Dragonfly G3', 125000.00, 'Electronics', 'images/hp.jpg', 'Premium slate blue business laptop with an ultra-portable build.'),
('electronics-003', 'Microsoft Surface Laptop Go 3', 49000.00, 'Electronics', 'images/widws.jpg', 'Compact 12.4 inch laptop with a sleek body and balanced Intel i5 performance.'),
('electronics-004', 'Lenovo ThinkPad', 56000.00, 'Electronics', 'images/thinkpad.jpg', 'Durable enterprise laptop built for productivity and office work.'),
('electronics-005', 'Samsung Galaxy Book2 Pro 360', 150000.00, 'Electronics', 'images/sumsung.jpg', 'Ultra-thin 2-in-1 laptop with an AMOLED screen and S-Pen support.'),
('electronics-006', 'Dell Latitude 5430 / 5540', 75000.00, 'Electronics', 'images/dell.jpg', 'Reliable business machine with strong connectivity and security features.'),
('electronics-007', 'Urbanista Los Angeles', 10500.00, 'Electronics', 'images/ver h.jpg', 'Solar-powered wireless headphones that recharge whenever exposed to light.'),
('electronics-008', 'Beribes Bluetooth', 4500.00, 'Electronics', 'images/pink head2.jpg', 'Comfortable Bluetooth headphones with a soft color finish and easy daily use.'),
('electronics-009', 'Beats Studio3 Wireless', 9500.00, 'Electronics', 'images/sleek b.png', 'Stylish wireless headphones with active noise canceling.'),
('electronics-010', 'Generic ANC Headphones', 5500.00, 'Electronics', 'images/black b.jpg', 'Affordable over-ear headphones with noise reduction for study and travel.'),
('electronics-011', 'Apple AirPods Max', 75000.00, 'Electronics', 'images/silver.jpg', 'Premium headphones with spatial audio and active noise cancellation.'),
('electronics-012', 'Sony WH-CH520', 7500.00, 'Electronics', 'images/pink hd1.jpg', 'Lightweight wireless headphones with long battery life.'),
('electronics-013', 'Pink Floral Fashion Watch', 5000.00, 'Electronics', 'images/beg .jpg', 'Budget-friendly smart watch with a floral interface and soft pink strap.'),
('electronics-014', 'Samsung Galaxy Watch (Burgundy)', 12000.00, 'Electronics', 'images/burgandi.jpg', 'Smart watch with fitness tracking, notifications, and a burgundy strap.'),
('electronics-015', 'Apple Watch (Sky Blue)', 7000.00, 'Electronics', 'images/llightblue.jpg', 'High-performance smart watch with a bright Retina display and light blue band.'),
('electronics-016', 'Silver Round Smartwatch', 5200.00, 'Electronics', 'images/gray.jpg', 'Elegant circular watch with a metallic finish and grey silicone strap.'),
('electronics-017', 'Rose Gold Butterfly Watch', 4500.00, 'Electronics', 'images/butterflight.jpg', 'Fashion-focused smart watch with a rose gold case and butterfly theme.'),
('electronics-018', 'Apple Watch (White)', 7500.00, 'Electronics', 'images/white w.jpg', 'Essential Apple Watch style with safety features and a white sport band.'),
('clothing-001', 'Baby Pink Soft Dress', 5000.00, 'Clothing', 'images/softPinkDress.jpg', 'Elegant baby pink floral gown with square neckline, bell sleeves, and a flowing skirt.'),
('clothing-002', 'Floral Bow Strap Dress', 6500.00, 'Clothing', 'images/softDressjpg.jpg', 'Chic floral dress with bow straps and a soft layered skirt.'),
('clothing-003', 'Yellow Summer Dress', 4000.00, 'Clothing', 'images/yellowDress.jpg', 'Light yellow maxi dress with V-neckline, tie-front detail, and long bell sleeves.'),
('clothing-004', 'Elegant Sky Blue Long-Sleeve Suit', 8500.00, 'Clothing', 'images/classic2.png', 'Refined light blue women pantsuit designed with timeless elegance.'),
('clothing-005', 'Elegant Blue Tweed Ensemble', 5200.00, 'Clothing', 'images/classicBlue.png', 'Two-piece outfit with a tweed jacket and flowing off-white trousers.'),
('clothing-006', 'Classic Monochrome Elegance', 4500.00, 'Clothing', 'images/blackClassic.jpg', 'Striped button-up shirt paired with high-waisted black trousers.'),
('clothing-007', 'Saint Laurent Hobo Bag', 12500.00, 'Clothing', 'images/sl bag.jpg', 'Glossy red hobo bag with a gold YSL-style front logo.'),
('clothing-008', 'Lady Dior (White Leather)', 25500.00, 'Clothing', 'images/dior b.jpg', 'Elegant white leather handbag with a structured shape and polished details.'),
('clothing-009', 'Prada Re-Edition 2005 (Black)', 10800.00, 'Clothing', 'images/prada b.jpg', 'Modern black bag with durable leather, chain handle, and triangle logo detail.'),
('clothing-010', 'Deep Burgundy Leather Bag', 15900.00, 'Clothing', 'images/gold b.jpg', 'Structured bag with a fold-over flap and gold-tone lock closure.'),
('clothing-011', 'Hermes Birkin 25', 27900.00, 'Clothing', 'images/birkin bag.jpg', 'Luxury structured tote with dual handles, front flap, and polished hardware.'),
('clothing-012', 'Gladdon Small Crossbody Purse', 17500.00, 'Clothing', 'images/leather b.jpg', 'Small top-handle crossbody purse with a magnetic flap closure.'),
('clothing-013', 'Saint Laurent Opyum Sandals', 12500.00, 'Clothing', 'images/sl h.jpg', 'Black patent leather sandals with a sculpted gold-tone heel.'),
('clothing-014', 'Crystal Queen White Stiletto Sandals', 7500.00, 'Clothing', 'images/white sandl.jpg', 'Bright white stiletto sandals designed for formal outfits.'),
('clothing-015', 'Burgundy Patent Slingback Stiletto Heels', 4800.00, 'Clothing', 'images/b h.jpg', 'Glossy burgundy slingback heels with pointed toes and slim stilettos.'),
('clothing-016', 'Midnight Gloss Pointed-Toe Pumps', 5200.00, 'Clothing', 'images/lbnt.jpg', 'Classic black patent pumps with sharp pointed toes and slim heels.'),
('clothing-017', 'Black Charm Pointed-Toe Heels', 5900.00, 'Clothing', 'images/0dd21fd342a2185768c2d7e37ad0db6e.jpg', 'Sophisticated black heels with a pointed toe and delicate gold-tone charm.'),
('clothing-018', 'Classic Nude Pointed-Toe Stilettos', 7500.00, 'Clothing', 'images/nude h.jpg', 'Glossy nude pumps with high stiletto heels for formal occasions.'),
('books-001', 'Atomic Habits', 2200.00, 'Books', 'images/atomic .jpg', 'Self-development book about building small habits that create big changes.'),
('books-002', 'Can''t Hurt Me', 4600.00, 'Books', 'images/hurt.jpg', 'Autobiography focused on discipline, mental toughness, and pushing beyond limits.'),
('books-003', 'Pistachio Theory', 4200.00, 'Books', 'images/theory.jpg', 'Motivational book about mindset shifts and better daily decisions.'),
('books-004', 'How To Win Friends & Influence People', 3100.00, 'Books', 'images/win.jpg', 'Classic guide to communication, relationships, confidence, and positive influence.'),
('books-005', 'Deep Work', 2900.00, 'Books', 'images/deep.webp', 'Productivity book about focused work without distraction.'),
('books-006', 'The Power Of Now', 2000.00, 'Books', 'images/now.jpg', 'Spiritual guide about living in the present and reducing overthinking.'),
('books-007', 'Clean Code', 1500.00, 'Books', 'images/clean.jpg', 'Foundational guide for writing readable, professional, maintainable code.'),
('books-008', 'AI and Machine Learning For Coders', 4500.00, 'Books', 'images/ani.jpg', 'Practical introduction to machine learning concepts for programmers.'),
('books-009', 'Digital Design & Computer Architecture', 3800.00, 'Books', 'images/computer.jpg', 'Guide to digital logic and the building blocks of modern processors.'),
('books-010', 'C.O.D.E', 5200.00, 'Books', 'images/code .jpg', 'Accessible book explaining how computers work from simple ideas upward.'),
('books-011', 'Algorithms To Live By', 3700.00, 'Books', 'images/mind.jpg', 'Book about applying computer science ideas to everyday decisions.'),
('books-012', 'Computer Organization & Design', 7500.00, 'Books', 'images/archi.jpg', 'Computer architecture book about processors, memory, and system design.'),
('books-013', 'Free To Learn', 5500.00, 'Books', 'images/free.jpg', 'Education book about how play builds curiosity and self-reliance.'),
('books-014', 'Fatima', 3200.00, 'Books', 'images/fatima.jpg', 'Novel-style reading choice for customers who enjoy thoughtful stories.'),
('books-015', 'Why We Sleep', 4100.00, 'Books', 'images/sleep.jpg', 'Scientific book about how sleep affects physical and mental health.'),
('books-016', 'Zero To One', 2500.00, 'Books', 'images/zero.jpg', 'Entrepreneurship book about building unique ideas and future companies.'),
('books-017', 'The Smartest Kids In The World', 1000.00, 'Books', 'images/smart.jpg', 'Education book comparing high-performing school systems around the world.'),
('books-018', 'Why Don''t Students Like School?', 5500.00, 'Books', 'images/kids.jpg', 'Cognitive science book about how students learn and stay engaged.');
