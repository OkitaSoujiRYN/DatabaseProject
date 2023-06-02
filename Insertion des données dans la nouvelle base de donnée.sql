-- Partie 1 Etape 2
INSERT INTO Prefet (prefet_name) select DISTINCT prefet FROM student_info; 

SELECT * from Prefet;

INSERT INTO House (house_name, prefet_id) SELECT Distinct house, prefet_id 
FROM student_info, Prefet where prefet_name = prefet;
select * from House;

INSERT INTO Course (course_name) SELECT DISTINCT registered_course 
FROM student_info;
SELECT * from Course order by course_id;


INSERT INTO student (student_name, email, house_id)
SELECT student_name, email, house_id FROM student_info, House 
WHERE house = house_name Group By student_name, email, house_id;

SELECT * from student;


INSERT INTO course_stud (student_id, course_name, course_id)
SELECT student_id, course_name, course_id FROM student_info, student, course 
WHERE student.student_name = student_info.student_name 
AND student_info.registered_course = course.course_name
GROUP BY student_id, course_name, course_id;

SELECT * FROM  course_stud;

INSERT INTO School_year (student_id, school_year) select student_id, school_year
from student_info, student where student_info.student_name = student.student_name 
group by school_year, student_id;

SELECT school_year, student_name from School_year, Student 
where Student.student_id = School_year.student_id ;

SELECT * FROM School_year;

-- DROP TABLE IF EXISTS student_info