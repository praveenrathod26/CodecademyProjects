use praveen_rathod;

-- Create the user11 table
CREATE TABLE user11 (
  user_id INT PRIMARY KEY,
  email_domain VARCHAR(255),
  country VARCHAR(255),
  postal VARCHAR(255),
  mobile_app VARCHAR(255),
  sign_up_at DATETIME
);

-- Create the progress11 table
CREATE TABLE progress11 (
  user_id INT PRIMARY KEY,
  learn_cpp INT,
  learn_sql INT,
  learn_html INT,
  learn_javascript INT,
  learn_java INT
);

-- Insert sample data into the user11 table
INSERT INTO user11 (user_id, email_domain, country, postal, mobile_app, sign_up_at) VALUES
  (1, 'example1.edu', 'Maharashtra', '400001', 'mobile-user', '2015-01-01 18:33:52'),
  (2, 'example2.edu', 'Karnataka', '560001', NULL, '2015-01-02 10:20:30'),
  (3, 'example3.com', 'Delhi', '110001', 'mobile-user', '2015-01-03 08:45:00'),
  (4, 'example4.edu', 'Tamil Nadu', '600001', NULL, '2015-01-04 16:10:20'),
  (5, 'example5.edu', 'Uttar Pradesh', '226001', 'mobile-user', '2015-01-05 12:30:45'),
  (6, 'example6.edu', 'Gujarat', '380001', NULL, '2015-01-06 09:15:10'),
  (7, 'example7.edu', 'Rajasthan', '302001', 'mobile-user', '2015-01-07 14:20:35'),
  (8, 'example8.edu', 'West Bengal', '700001', NULL, '2015-01-08 11:55:00');

-- Insert sample data into the progress11 table
INSERT INTO progress11 (user_id, learn_cpp, learn_sql, learn_html, learn_javascript, learn_java) VALUES
  (1, 1, 1, 0, 1, 0),
  (2, 0, 1, 1, 0, 1),
  (3, 1, 0, 0, 1, 1),
  (4, 0, 1, 0, 0, 1),
  (5, 1, 1, 1, 1, 1),
  (6, 0, 0, 1, 1, 0),
  (7, 1, 0, 1, 0, 1),
  (8, 0, 1, 0, 1, 0);

-- Task 1: Get to know the data

-- What are the Top 25 schools (.edu domains)?
SELECT email_domain, COUNT(*) AS count
FROM user11
WHERE email_domain LIKE '%.edu'
GROUP BY email_domain
ORDER BY count DESC
LIMIT 25;

-- How many .edu learners are located in Indian states?
SELECT country, COUNT(*) AS count
FROM user11
WHERE email_domain LIKE '%.edu'
GROUP BY country;

-- How many Codecademy learners are using the mobile app?
SELECT COUNT(*) AS count
FROM user11
WHERE mobile_app = 'mobile-user' OR mobile_app IS NULL;

-- Task 2: Query for the sign-up counts for each hour
SELECT DATE_FORMAT(sign_up_at, '%Y-%m-%d %H:00') AS hour, COUNT(*) AS sign_up_count
FROM user11
GROUP BY hour;

-- Task 3: Join the two tables and explore the data

-- Do different schools (.edu domains) prefer different courses?
SELECT u.email_domain, COUNT(*) AS course_count
FROM user11 u
JOIN progress11 p ON u.user_id = p.user_id
GROUP BY u.email_domain
ORDER BY course_count DESC;

-- What courses are the learners from Indian states taking?
SELECT p.user_id, p.learn_cpp, p.learn_sql, p.learn_html, p.learn_javascript, p.learn_java
FROM user11 u
JOIN progress11 p ON u.user_id = p.user_id
WHERE u.country IN ('Maharashtra', 'Karnataka', 'Delhi', 'Tamil Nadu', 'Uttar Pradesh', 'Gujarat', 'Rajasthan', 'West Bengal');

