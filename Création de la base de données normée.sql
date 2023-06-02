DROP TABLE IF EXISTS School_year;
DROP TABLE IF EXISTS Course_stud;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS House;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Prefet;

CREATE TABLE Prefet (
prefet_id INT PRIMARY KEY AUTO_INCREMENT,
prefet_name VARCHAR(50) NOT NULL
);

CREATE TABLE Course (
	course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(50) NOT NULL UNIQUE
    );

CREATE TABLE House (
	house_id INT PRIMARY KEY AUTO_INCREMENT,
    house_name VARCHAR(50) NOT NULL UNIQUE,
    prefet_id INT,
    FOREIGN KEY (prefet_id) REFERENCES Prefet(prefet_id)
    );

CREATE TABLE Student (
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    house_id INT,
    FOREIGN KEY (house_id) REFERENCES House(house_id)
    );

CREATE TABLE Course_stud (
    student_id INT,
    course_name VARCHAR(50) NOT NULL,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
    );

CREATE TABLE School_year (
	student_id INT NOT NULL,
    school_year FLOAT NOT NULL,
    PRIMARY KEY (student_id, school_year),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
    );



