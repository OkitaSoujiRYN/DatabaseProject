-- Partie 1 INDEX 3
-- a
--  Affiche le nombre d'élèves dans chaque cours en fonction de leur maison.
SELECT House.house_name, course.course_name, COUNT(*) as num_stud
FROM student
JOIN House ON  student.house_id = house.house_id
JOIN course_stud ON student.student_id = course_stud.student_id
JOIN Course ON course_stud.course_id = course.course_id
Group By house.house_name, course.course_name
ORDER BY num_stud DESC;

Set profiling = 1;
SELECT House.house_name, course.course_name, COUNT(*) as num_stud
FROM student
JOIN House ON  student.house_id = house.house_id
JOIN course_stud ON student.student_id = course_stud.student_id
JOIN Course ON course_stud.course_id = course.course_id
Group By house.house_name, course.course_name
ORDER BY num_stud DESC;
Show profile;
set profiling = 0;

-- l'index existant déjà sur la table house on doit juste regarder le temps en ignorant l'index
Set profiling = 1;
SELECT House.house_name, course.course_name, COUNT(*) as num_stud
FROM student IGNORE INDEX (idx_house_id)
JOIN House ON  student.house_id = house.house_id
JOIN course_stud ON student.student_id = course_stud.student_id
JOIN Course ON course_stud.course_id = course.course_id
Group By house.house_name, course.course_name
ORDER BY num_stud DESC;
Show profile;
set profiling = 0;

-- b
-- Affiche les élèves qui n'ont pas de cours
SELECT student.student_name, student.email
FROM student
JOIN course_stud ON student.student_id = course_stud.student_id
WHERE course_id is NULL;

set profiling = 1;
SELECT student.student_name, student.email
FROM student
JOIN course_stud ON student.student_id = course_stud.student_id
WHERE course_stud.course_id is NULL;
show profile;
set profiling = 0;

CREATE INDEX idx_course_id ON course_stud(course_id);

set profiling = 1;
SELECT student.student_name, student.email
FROM student
JOIN course_stud ON student.student_id = course_stud.student_id
WHERE course_stud.course_id is NULL;
show profile;
set profiling = 0;


-- c
-- Affiche le nombre de cours total suivi par les élèves en fonction de leur maison
SELECT house.house_name, COUNT(*) as num_stud
FROM student
JOIN House ON student.house_id = house.house_id
JOIN course_stud ON student.student_id = course_stud.student_id
JOIN Course ON course_stud.course_id = course.course_id
WHERE EXISTS (
	SELECT *
    FROM course
    join course_stud ON Course.course_id = course_stud.course_id
    WHERE course.course_name IN ('potion', 'sortilege', 'botanique')
		AND course_stud.student_id = student.student_id
        )
	GROUP BY house_name;
    
    
    
    SET PROFILING = 1;
    SELECT house.house_name, COUNT(*) as num_stud
FROM student
JOIN House ON student.house_id = house.house_id
JOIN course_stud ON student.student_id = course_stud.student_id
JOIN Course ON course_stud.course_id = course.course_id
WHERE EXISTS (
	SELECT *
    FROM course
    join course_stud ON Course.course_id = course_stud.course_id
    WHERE course.course_name IN ('potion', 'sortilege', 'botanique')
		AND course_stud.student_id = student.student_id
        )
	GROUP BY house_name;
    SHOW PROFILE;
    SET PROFILING = 0;
    
    
CREATE INDEX idx_student_id ON Student(student_id);
    
    SET PROFILING = 1;
    SELECT house.house_name, COUNT(*) as num_stud
FROM student
JOIN House ON student.house_id = house.house_id
JOIN course_stud ON student.student_id = course_stud.student_id
JOIN Course ON course_stud.course_id = course.course_id
WHERE EXISTS (
	SELECT *
    FROM course
    join course_stud ON Course.course_id = course_stud.course_id
    WHERE course.course_name IN ('potion', 'sortilege', 'botanique')
		AND course_stud.student_id = student.student_id
        )
	GROUP BY house_name;
    SHOW PROFILE;
    SET PROFILING = 0;
-- d
-- Affiche les noms et mails des étudiants qui ont sont inscrits au nombre maximum de cours possible pour leur année.


Select student.student_name, student.email
FROM Student

JOIN (
	Select student.student_name, student.email, School_year.school_year, COUNT(DISTINCT course_id) AS num_course
		FROM Student, School_year, Course_stud where student.student_id = School_year.student_id AND course_stud.student_id = student.student_id
        GROUP BY student.student_name, school_year, student.email
        ) AS sub
	ON student.student_name = sub.student_name
JOIN (
		SELECT school_year.school_year, COUNT(DISTINCT course_id) AS num_course
        FROM Student, School_year, course_stud where student.student_id = school_year.student_id AND course_stud.student_id = student.student_id
        GROUP BY school_year
        ) AS total
	ON sub.num_course = total.num_course
group by student.student_name, student.email;

SET PROFILING = 1;
Select student.student_name, student.email
FROM Student IGNORE INDEX (idx_student_id)

JOIN (
	Select student.student_name, student.email, School_year.school_year, COUNT(DISTINCT course_id) AS num_course
		FROM Student, School_year, Course_stud where student.student_id = School_year.student_id AND course_stud.student_id = student.student_id
        GROUP BY student.student_name, school_year, student.email
        ) AS sub
	ON student.student_name = sub.student_name
JOIN (
		SELECT school_year.school_year, COUNT(DISTINCT course_id) AS num_course
        FROM Student, School_year, course_stud where student.student_id = school_year.student_id AND course_stud.student_id = student.student_id
        GROUP BY school_year
        ) AS total
	ON sub.num_course = total.num_course
group by student.student_name, student.email;
SHOW PROFILE;
SET PROFILING = 0;

SET PROFILING = 1;
Select student.student_name, student.email
FROM Student

JOIN (
	Select student.student_name, student.email, School_year.school_year, COUNT(DISTINCT course_id) AS num_course
		FROM Student, School_year, Course_stud where student.student_id = School_year.student_id AND course_stud.student_id = student.student_id
        GROUP BY student.student_name, school_year, student.email
        ) AS sub
	ON student.student_name = sub.student_name
JOIN (
		SELECT school_year.school_year, COUNT(DISTINCT course_id) AS num_course
        FROM Student, School_year, course_stud where student.student_id = school_year.student_id AND course_stud.student_id = student.student_id
        GROUP BY school_year
        ) AS total
	ON sub.num_course = total.num_course
group by student.student_name, student.email;
SHOW PROFILE;
SET PROFILING = 0;


