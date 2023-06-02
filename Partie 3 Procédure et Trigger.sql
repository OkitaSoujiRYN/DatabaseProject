-- Partie 3
-- 2
	-- a
    DROP TABLE IF EXISTS house_student_count_materialized;
	CREATE TABLE house_student_count_materialized (
		house_name VARCHAR(50),
		student_count INT
		);

	DROP PROCEDURE IF EXISTS refresh_house_student_count_materialized;

	DELIMITER $$

	CREATE PROCEDURE refresh_house_student_count_materialized()
	BEGIN 
		TRUNCATE TABLE house_student_count_materialized;
		INSERT INTO house_student_count_materialized
		SELECT  house_name, COUNT(DISTINCT student_name) AS student_count
		FROM House, Student where student.house_id = house.house_id
		GROUP BY house_name;
	END $$
	DELIMITER ;

	Select * from house_student_count_materialized;

	CALL refresh_house_student_count_materialized;

-- 3
	-- a
    INSERT INTO student (student_name, email, house_id)
	VALUES
		('Cheryl Williamson', 'cheryl.williamson@poudlard.edu', (Select FLOOR(RAND()*4) + 1));
	SET @course_name := (SELECT Distinct course_name FROM Course
                     ORDER BY RAND() LIMIT 1);
SELECT @course_name;

INSERT INTO course_stud (student_id, course_name, course_id)
VALUES ((SELECT student_id FROM student WHERE student_name = 'Cheryl Williamson'), @course_name, 
(SELECT course_id FROM Course WHERE course_name = @course_name));
    -- b
	SELECT * FROM house_student_count_materialized;

    -- c
    CALL refresh_house_student_count_materialized();

    -- d
    Select * from house_student_count_materialized;
    
    Select * from student inner join course_stud on student.student_id = course_stud.student_id;
    
-- 4
	-- a
    
    DELIMITER $$
    CREATE TRIGGER update_house_student_count_materialized
    AFTER INSERT ON student
    FOR EACH ROW
    BEGIN
		CALL refresh_house_student_count_materialized();
	END;
    DELIMITER ;
    
    DELIMITER $$
    CREATE TRIGGER update_delete_house_student_count
	AFTER DELETE ON student
    FOR EACH ROW
    BEGIN
		CALL refresh_house_student_count_materialized();
	END;
    DELIMITER ; 
    
	CALL refresh_house_student_count_materialized();
    SELECT * FROM house_student_count_materialized;
    
    INSERT INTO student (student_name, email, house_id)
	VALUES
		('John Wick', 'john.wick@poudlard.edu', (Select FLOOR(RAND()*4) + 1));
    
    SET @course_name := (SELECT course_name FROM (SELECT 'potion' AS course_name
                                        UNION SELECT 'sortilege' AS course_name
                                        UNION SELECT 'botanique' AS course_name) AS c
										ORDER BY RAND() LIMIT 1);
	
	INSERT INTO course_stud (student_id, course_name, course_id)

    VALUES
		((Select student_id from student where student_name = 'John Wick'), @course_name,  (SELECT course_id FROM Course where course_name = @course_name));
	
	CALL refresh_house_student_count_materialized();
    
    SELECT * FROM house_student_count_materialized;
    
    SELECT * from student;
    SELECT * from course_stud;

    DELETE FROM course_stud WHERE student_id = (Select student_id FROM student WHERE student_name = 'John Wick');
    DELETE FROM student WHERE student_name = 'John Wick';
	
	DELETE FROM course_stud WHERE student_id = (Select student_id FROM student WHERE student_name = 'Cheryl Williamson' LIMIT 1);
	DELETE FROM student where student_name = 'Cheryl Williamson';

    Select * FROM house_student_count_materialized;
    
	CALL refresh_house_student_count_materialized();
    Select * FROM house_student_count_materialized;
    