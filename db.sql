CREATE DATABASE IF NOT EXISTS ecommerce_project CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ecommerce_project;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS product;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE account (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL UNIQUE,
    login VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL,
    image VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_product (name, category, image)
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'confirmed',
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    line_total DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product(product_id) ON DELETE RESTRICT
);

INSERT INTO customer (name, address, phone_number, email) VALUES
('Rym', 'Algiers, Algeria', '0600000007', 'rym@gmail.com');

INSERT INTO account (customer_id, login, password) VALUES
(1, 'rym', '123456');

INSERT INTO product (name, price, category, image, description) VALUES('Burgundy Ruched Midi Dress', 4990, 'Clothing', 'images/red dress.jpg', 'Elegant burgundy midi dress with a ruched bodice, spaghetti straps, and a flowing skirt. Perfect for special occasions.'),
('Floral Bow Strap Dress', 6500, 'Clothing', 'images/summer 2 (1).jpg', 'Chic floral dress with bow straps and a soft layered skirt for a stylish feminine look.'),
('Floral Summer Dress', 3800, 'Clothing', 'images/black d1.jpg', 'Lightweight floral print dress, midi length. Perfect for warm weather and casual outings.'),
('satan dress', 5200, 'Clothing', 'images/download (1).jpg', 'Soft merino wool blend, crew neck, anti-pilling finish. Great for autumn and winter.'),
('Merino Wool Sweater', 5200, 'Clothing', 'images/summer 2.jpg', 'Soft merino wool blend, crew neck, anti-pilling finish. Great for autumn and winter.'),
('Classic Nude Pointed-Toe Stilettos', 7500, 'Clothing', 'images/green d.jpg', 'A timeless pair of glossy nude pumps with a high stiletto heel, perfect for formal occasions.'),
('Saint Laurent Hobo Bag', 12500, 'Clothing', 'images/sl bag.jpg', 'A sleek patent leather hobo in rich glossy red, featuring the iconic gold YSL logo on the front tab.'),
('Lady Dior (White Leather)', 6500, 'Clothing', 'images/dior b.jpg', 'Elegant two-tone handbag in cream and burgundy with gold hardware, a structured silhouette, and a delicate floral scarf tied to the handle.'),
('Prada Re-Edition 2005 (Black)', 2800, 'Clothing', 'images/prada b.jpg', 'Modern bag made from durable Saffiano leather with a detachable chain handle and a signature triangular enamel logo on the front.'),
('Deep Burgandi leather bag', 5900, 'Clothing', 'images/gold b.jpg', 'A structured, architectural silhouette featuring a fold-over flap with a signature gold-tone lock closure.'),
('Hermès Birkin 25', 5900, 'Clothing', 'images/birkin bag.jpg', 'The ultimate symbol of luxury. This structured tote features dual top handles, a signature front flap with a turn-lock closure, and polished gold-tone hardware.'),
('Gladdon Small Crossbody Purse', 7500, 'Clothing', 'images/leather b.jpg', 'A timeless purse with a small top-handle crossbody style with a magnetic flap closure.'),
('Saint Laurent Opyum Sandals', 12500, 'Clothing', 'images/sl h.jpg', 'Iconic black patent leather sandals featuring a unique gold-tone "YSL" sculpted heel.'),
('Crystal Queen White Stiletto Sandals', 6500, 'Clothing', 'images/white sandl.jpg', 'elegant white high-heeled sandals feature thin straps and a gold-tone charm hanging from the ankle buckle.'),
('Burgundy Patent Slingback Stiletto Heels', 2800, 'Clothing', 'images/b h.jpg', 'Chic burgundy slingback heels with a glossy patent finish, pointed toe, and slim stiletto heel.'),
('Midnight Gloss Pointed-Toe Pumps', 5200, 'Clothing', 'images/lbnt.jpg', 'Classic black patent pumps featuring a sleek pointed toe and ultra-slim stiletto heel.'),
('Crystal Queen White Stiletto Sandals', 5900, 'Clothing', 'images/0dd21fd342a2185768c2d7e37ad0db6e.jpg', 'Sophisticated black heels featuring a sharp pointed toe accented with a delicate gold-tone charm hanging from the ankle buckle.'),
('Classic Nude Pointed-Toe Stilettos', 7500, 'Clothing', 'images/nude h.jpg', 'A timeless pair of glossy nude pumps with a high stiletto heel, perfect for formal occasions.'),
('MacBook Pro (Space Black)', 28000, 'Electronics', 'images/mac.jpg', 'High-performance powerhouse for creators featuring Apple’s powerful M-series chips.'),
('HP Elite Dragonfly G3', 125000, 'Electronics', 'images/hp.jpg', 'A high-end business laptop in a deep "Slate Blue" finish, prized for its ultra-portable weight and premium build quality.'),
('Microsoft Surface Laptop Go 3', 49000, 'Electronics', 'images/widws.jpg', 'A compact 12.4" laptop designed for portability, featuring a sleek aluminum body and a balanced Intel i5 processor.'),
('Lenovo ThinkPad', 56000, 'Electronics', 'images/thinkpad.jpg', 'Durable enterprise-grade laptop built for productivity and heavy-duty office use.'),
('Samsung Galaxy Book2 Pro 360', 15000, 'Electronics', 'images/sumsung.jpg', 'Ultra-thin 2-in-1 convertible laptop with a vivid AMOLED screen and S-Pen.'),
('Dell Latitude 5430 / 5540', 7500, 'Electronics', 'images/dell.jpg', 'Reliable business machine featuring versatile connectivity and strong security features.'),
('Urbanista Los Angeles', 10500, 'Electronics', 'images/ver h.jpg', 'Solar-powered headphones that charge themselves whenever exposed to light.'),
('Beribes Bluetooth', 4500, 'Electronics', 'images/pink head2.jpg', 'Budget-friendly wireless headphones with multiple EQ modes and long playtime.'),
('Beats Studio3 Wireless', 9500, 'Electronics', 'images/sleek b.png', 'Iconic stylish headphones optimized for Apple users with active noise canceling.'),
('Generic ANC Headphones', 5500, 'Electronics', 'images/black b.jpg', 'Affordable over-ear Bluetooth headphones designed for comfortable daily listening.'),
('Apple AirPods Max', 7500, 'Electronics', 'images/silver.jpg', 'High-end luxury headphones with premium spatial audio and noise cancellation.'),
('Sony WH-CH520', 7500, 'Electronics', 'images/pink hd1.jpg', 'Lightweight wireless headphones featuring an impressive 50-hour battery life.'),
('Pink Floral Fashion Watch', 5000, 'Electronics', 'images/beg .jpg', 'Budget-friendly lifestyle watch with a vibrant floral interface and soft pink strap.'),
('Samsung Galaxy Watch (Burgundy)', 12000, 'Electronics', 'images/burgandi.jpg', 'Premium round smartwatch with health sensors and a deep wine-colored sport band.'),
('Apple Watch (Sky Blue)', 7000, 'Electronics', 'images/llightblue.jpg', 'High-performance Series watch featuring a bright Retina display and light blue sport band.'),
('Silver Round Smartwatch', 5200, 'Electronics', 'images/gray.jpg', 'Elegant circular watch with a metallic finish and a professional grey silicone strap.'),
('Rose Gold Butterfly Watch', 4500, 'Electronics', 'images/butterflight.jpg', 'Stylish fashion-focused smartwatch with a butterfly theme and rose gold casing.'),
('Apple Watch (White)', 7500, 'Electronics', 'images/white w.jpg', 'The essential SE model with core safety features and a classic white sport band.'),
('Atomic Habits', 2200, 'Books', 'images/atomic .jpg', 'A powerful self-development book that teaches how small daily habits can lead to big life changes. It provides practical strategies to build good habits.'),
('Can''t Hurt Me', 5000, 'Books', 'images/hurt.jpg', 'An inspiring autobiography about David Goggins''s journey to becoming a Navy SEAL. The book focuses on mental toughness, discipline, and pushing beyond limits.'),
('Pistachio Theory', 49000, 'Books', 'images/theory.jpg', 'A motivational book that explores how small mindset shifts can change the way you think and make decisions, helping you improve your daily life.'),
('How To Win Friend & Influence People', 56000, 'Books', 'images/win.jpg', 'A classic guide to communication and social skills.about strong relationships, influence abd positivety, and improving confidence in life.'),
('Deep Work', 15000, 'Books', 'images/deep.webp', 'A productivity book that explains how to focus deeply without distractions. It helps develop concentration skills to produce high-quality work in less time.'),
('The Power Of Now', 7500, 'Books', 'images/now.jpg', 'A spiritual guide that teaches the importance of living in the present moment. It helps reduce stress and overthinking by focusing on mindfulness and inner peace.'),
('Clean Code', 10500, 'Books', 'images/clean.jpg', 'A foundational guide on writing professional, maintainable, and readable software code.'),
('AI and Machine Learning For Coders', 4500, 'Books', 'images/ani.jpg', 'A practical, code-first introduction to building AI models using tools like TensorFlow.'),
('Digital Design & Computer Architecture', 9500, 'Books', 'images/computer.jpg', 'A deep dive into digital logic and the architectural building blocks of modern processors.'),
('C.O.D.E', 5500, 'Books', 'images/code .jpg', 'A fascinating look at how hardware and software communicate through simple electrical systems.'),
('Algorithms To Live By', 7500, 'Books', 'images/mind.jpg', 'A fascinating look at how hardware and software communicate through simple electrical systems.'),
('Computer Organization & Design', 7500, 'Books', 'images/archi.jpg', 'Explores how computer science algorithms can be applied to solve everyday human decision-making.'),
('Free To Learn', 5500, 'Books', 'images/free.jpg', 'Explores how allowing children the freedom to play naturally fosters curiosity and self-reliance.'),
('Fatima', 3200, 'Books', 'images/fatima.jpg', 'A biographical narrative detailing the life and spiritual significance of the daughter of the Prophet.'),
('Why We Sleep', 4100, 'Books', 'images/sleep.jpg', 'A scientific look at how sleep affects every aspect of physical and mental health.'),
('Zero To One', 2500, 'Books', 'images/zero.jpg', 'A guide for entrepreneurs on how to build the future by creating truly unique innovations.'),
('The Smartest Kids In The World', 3800, 'Books', 'images/smart.jpg', 'Investigates high-performing education systems globally to find what truly helps children succeed.'),
('Why Don''t Students Like School?', 5500, 'Books', 'images/kids.jpg', 'Uses cognitive science to explain how the brain learns and how teachers can better engage students.');

