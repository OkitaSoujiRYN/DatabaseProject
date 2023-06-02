-- Partie 1 INDEX 2

-- Afficher le nombre d'élèves dans la maison Griffondor :
Select house_name, COUNT(student_name) from House, Student 
where Student.house_id = House.house_id AND house_name = "Gryffondor";

-- Mesurer le temps de la requêtes :
Set profiling = 1; 
Select house_name, COUNT(student_name) from House, Student where Student.house_id = House.house_id AND house_name = "Gryffondor";
Show Profile;
set profiling = 0;

Create INDEX idx_house_id ON Student(house_id);

Set profiling = 1;
Select Count(student_name) from Student where house_id = '1';
Show Profile;
Set profiling = 0;

Set profiling = 1;
Select Count(student_name) from Student IGNORE INDEX (idx_house_id) where house_id = '1';
Show Profile;
Set profiling = 0;

