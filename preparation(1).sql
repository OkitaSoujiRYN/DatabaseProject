Create DATABASE project;

DROP TABLE IF EXISTS student_info;

Create Table student_info (
	student_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    registered_course VARCHAR(50) NOT NULL,
    school_year FLOAT(1.2) NOT NULL,
    house VARCHAR(50) NOT NULL,
    prefet VARCHAR(50) NOT NULL
);

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/project1.csv"
INTO TABLE student_info
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;