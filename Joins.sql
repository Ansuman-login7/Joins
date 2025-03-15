use examples; // Using a database to create and operate the queries //
-- Creating Customer table --

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

-- Creating Products table --

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

-- Creating Orders Table --

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Creating Order_items Table --

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Inserting Sample data  to respective tables --

INSERT INTO customers VALUES
(1, 'Amit Sharma', 'amit.sharma@example.in', 'Delhi'),
(2, 'Priya Iyer', 'priya.iyer@example.in', 'Mumbai'),
(3, 'Rajesh Kumar', 'rajesh.kumar@example.in', 'Bangalore'),
(4, 'Sneha Verma', 'sneha.verma@example.in', 'Chennai'),
(5, 'Vikram Singh', 'vikram.singh@example.in', 'Kolkata'),
(6, 'Ananya Reddy', 'ananya.reddy@example.in', 'Hyderabad'),
(7, 'Rohan Das', 'rohan.das@example.in', 'Pune'),
(8, 'Neha Joshi', 'neha.joshi@example.in', 'Ahmedabad');


INSERT INTO products VALUES
(101, 'Laptop', 120000.00),
(102, 'Smartphone', 45000.00),
(103, 'Tablet', 25000.00),
(104, 'Headphones', 5000.00),
(105, 'Monitor', 20000.00);

INSERT INTO orders VALUES
(1001, 1, '2024-03-01', 125000.00),
(1002, 2, '2024-03-02', 45000.00),
(1003, 3, '2024-03-03', 140000.00),
(1004, 1, '2024-03-04', 25000.00),
(1005, 4, '2024-03-05', 120000.00),
(1006, 5, '2024-03-06', 5000.00),
(1007, 6, '2024-03-07', 60000.00),
(1008, 7, '2024-03-08', 70000.00);

INSERT INTO order_items VALUES
(1, 1001, 101, 1),
(2, 1001, 104, 1),
(3, 1002, 102, 1),
(4, 1003, 101, 1), 
(5, 1003, 105, 2),  
(6, 1004, 103, 1),  
(7, 1005, 101, 1),  
(8, 1006, 104, 1),  
(9, 1007, 102, 1),  
(10, 1008, 105, 1);

-- Find Customers with their orders--
-- Basically Inner Join--

SELECT c.customer_name, o.order_id, o.order_date, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- Find all the customers with their orders(including the ones didn't order)--
-- Left Join --

SELECT c.customer_name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- Find the customers with their orders(including the orders having no customer)--
-- Right Join --
SELECT c.customer_name, o.order_id, o.total_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- Find All customers and orders even if their is no match--
-- Full Join--
SELECT c.customer_name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
union
SELECT c.customer_name, o.order_id, o.total_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- Display Every Customer data with every product--
-- Cross join --

SELECT c.customer_name, p.product_name
FROM customers c
CROSS JOIN products p;

-- SELF JOIN (Find customers in the same city)
SELECT a.customer_name AS Customer1, b.customer_name AS Customer2, a.city
FROM customers a
JOIN customers b ON a.city = b.city AND a.customer_id <> b.customer_id;

