CREATE DATABASE bus_registration;

USE bus_registration;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'student', 'parent') NOT NULL
);

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    grade VARCHAR(50),
    address TEXT,
    bus_route INT,
    status ENUM('waiting', 'confirmed') DEFAULT 'waiting',
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE buses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    route_number INT NOT NULL,
    route_name VARCHAR(255) NOT NULL,
    driver_name VARCHAR(255)
);

CREATE TABLE schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bus_id INT NOT NULL,
    date DATE NOT NULL,
    time ENUM('morning', 'afternoon') NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY (bus_id) REFERENCES buses(id),
    FOREIGN KEY (student_id) REFERENCES students(id)
);
