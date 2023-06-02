-- Afficher l'ensemble des tables en SQL
Show tables;

-- Afficher les colonnes de la table student_info
Show columns from student_info;

-- Afficher le nombre d'étudiant dans la base de données
Select COUNT(Distinct student_name) FROM student_info;

-- Afficher les différents cours dans la base de données
Select DISTINCT registered_course from student_info;

-- Afficher les différentes maisons dans la base de données
Select DISTINCT house from student_info;

-- Afficher les différents préfets dans la base de données
SELECT DISTINCT prefet from student_info;

-- Afficher les différents préfets en fonction de leur maison
SELECT DISTINCT prefet, house FROM student_info;

-- Afficher le nombre d'élève par année
Select school_year, COUNT(*) from student_info
GROUP BY school_year;

-- Afficher les noms et les emails des élèves qui suivent le cours de potion
Select student_name, email from student_info
WHERE registered_course = 'potion';

-- Pour les étudiants qui ont une année supérieure à deux
SELECT * from student_info 
where school_year > 2;

-- Afficher les étudiants trier par ordre alphabétique
SELECT * from student_info
Order BY student_name ASC;

-- Afficher le nombre d'élève qui suivent le cours de potions dans chaque maison
Select house, Count(*) from student_info
where registered_course = "potion"
GROUP BY house;

-- Afficher le nombre d'étudiant par maison
Select house, Count(*) from student_info
Group by house;

-- Afficher le nombre de cours pour chaque année
Select school_year, Count(registered_course) from student_info
group by school_year;

-- Afficher le nombre d'élèves inscrit à chaque cours
Select registered_course, Count(*) from student_info
Group by registered_course;


-- Afficher le nombre de cours auxquels les élèves de chaque maison se sont inscrits
Select house, registered_course, Count(*) from student_info
Group by house, registered_course
Order by house,registered_course;

-- Afficher le nombre d'étudiants dans chaque année pour chaque maison
Select house, school_year, Count(*) from student_info
group by house, school_year
Order by house;

-- Afficher les cours auxquels les étudiants de chaque année se sont inscrits
Select school_year, registered_course, Count(*) from student_info
group by school_year, registered_course
order by school_year;

-- Afficher les maisons et le nombre d'étudiants par maison en ordre décroissant
Select house, count(*) as nb from student_info
group by house
order by nb DESC;

-- Afficher le nombre d'étudiant inscrit à chaque cours triés par ordre décroissant
Select registered_course, COUNT(*) as nb from student_info
group by registered_course
order by nb DESC;

-- Afficher les préfets de chaque maison triés par ordre alphabétique des maisons
Select house, prefet from student_info
group by house, prefet
order by house;