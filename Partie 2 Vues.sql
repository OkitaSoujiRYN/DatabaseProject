-- Partie 2
-- 2

	-- a
	DROP VIEW IF EXISTS potion_stud;
	CREATE VIEW potion_stud AS
	SELECT student.student_name, student.email, student.house_id
	FROM student
    JOIN course_stud ON student.student_id = course_stud.student_id
	JOIN Course ON course_stud.course_id = course.course_id
	where Course.course_name = 'potion'; 

	-- pour le screen sans les nouveaux élèves
    DELETE FROM course_stud WHERE student_id = (SELECT student_id FROM student WHERE student_name = 'Parry Hotter') OR student_id = (SELECT student_id FROM student WHERE student_name = 'Aldric Dumbymore'); 
	delete from student where student_name = 'Parry Hotter' OR student_name = 'Aldric Dumbymore';

	-- b
	SELECT * FROM potion_stud;

	-- c
	INSERT INTO student (student_name, email, house_id)
	VALUES
		('Parry Hotter', 'parry.hotter@poudlard.edu', (Select FLOOR(RAND()*4) + 1 AS rand_it)),
		('Aldric Dumbymore', 'aldric.dumbymore@poudlard.edu', (Select FLOOR(RAND()*4) + 1 AS rand_it));
	INSERT INTO course_stud (student_id, course_name, course_id)
    VALUES
		((Select student_id from student where student_name = 'Parry Hotter'), 'potion', (SELECT course_id FROM course WHERE course_name = 'potion')),
        ((Select student_id from student where student_name = 'Aldric Dumbymore'), 'potion', (SELECT course_id FROM course WHERE course_name = 'potion'));
        

	-- d	
	SELECT * FROM potion_stud;

-- 3
Drop VIEW IF EXISTS house_student_count;

CREATE VIEW house_student_count AS
SELECT house_name, COUNT(DISTINCT student_name) AS student_count 
FROM House, Student 
where student.house_id = house.house_id
group by house_name;

select * from house_student_count;

UPDATE house_student_count SET student_count = 10 WHERE house_name = "Gryffondor";
-- Cette requete ne peut aboutir car on essaie de modifier une vue.

-- si la vue avait été une table normale ça aurait fonctionné
-- mais il faudrait la mettre à jour à chaque que l'on modifie les données de la table student