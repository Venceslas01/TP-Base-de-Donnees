 ************************* Exercice 1 ***********************************************
1-
SELECT Titre, Genre FROM Film;
2-
SELECT Titre FROM Film 
WHERE Genre = 'Science-Fiction' AND Annee > 2000;
3-
SELECT Film.Titre, Film.Annee, Film.Note FROM Film
JOIN Realisateur ON Film.ID_Realisateur = Realisateur.ID_Realisateur
WHERE Realisateur.Nom = 'Christopher Nolan';
4-
SELECT Nom FROM Realisateur ORDER BY Nom ASC;
5-
SELECT Film.Titre, Seance.Horaire, Seance.Prix, Seance.Version FROM Seance
JOIN Film ON Seance.ID_Film = Film.ID_Film
ORDER BY Seance.Prix ASC;
6-
SELECT AVG(Duree) AS Duree_Moyenne FROM Film;
7-
SELECT Genre, AVG(Note) AS Note_Moyenne FROM Film
GROUP BY Genre;
8-	
SELECT Genre, COUNT(Genre) AS Nombre_De_Genre FROM Film
GROUP BY Genre
HAVING COUNT(Genre) = (SELECT COUNT(Genre) AS Nombre
FROM Film 
GROUP BY Genre
ORDER BY Nombre DESC LIMIT 1);	
9- 
SELECT Realisateur.Nom, COUNT(Film.ID_Realisateur) AS Nombre_De_Films FROM Film
JOIN Realisateur ON Film.ID_Realisateur = Realisateur.ID_Realisateur
GROUP BY Film.ID_Realisateur, Realisateur.Nom
HAVING COUNT(Film.ID_Realisateur) = (
    SELECT COUNT(ID_Realisateur) AS nombres_film FROM Film
        GROUP BY ID_Realisateur
        ORDER BY nombres_film DESC LIMIT 1 ); 
   


************* Exercice2 ****************************************************************************************

1- 
SELECT Nom, Prenom FROM etudiant
WHERE Date_de_Naissance > '2000-01-01' AND (adresse LIKE '%Amiens%' OR adresse LIKE '%Rivery%');

2-
SELECT Professeur.Nom, Professeur.Date_de_Naissance FROM Professeur 
JOIN Matière ON Professeur.ID_Professeur = Matière.ID_Professeur 
WHERE Matière.Nom = 'Intelligence artificielle';

3-
SELECT ID_Professeur FROM Professeur 
WHERE ID_Professeur NOT IN (SELECT DISTINCT ID_Professeur FROM Matière);

4-
SELECT Matière.Nom, COUNT(Inscription.ID_Etudiant) AS Nombre_Etudiants FROM Matière
LEFT JOIN Inscription ON Matière.ID_Matière = Inscription.ID_Matière
GROUP BY Matière.Nom;

5- 
SELECT DISTINCT etudiant.Nom, etudiant.Prenom FROM etudiant 
JOIN Inscription ON etudiant.ID_Etudiant = Inscription.ID_Etudiant
JOIN Matière  ON Inscription.ID_Matière = Matière.ID_Matière
JOIN Professeur  ON Matière.ID_Professeur = Professeur.ID_Professeur
WHERE Professeur.Nom = 'Garcia' AND Professeur.Prénom = 'Maria';

6-
SELECT etudiant.ID_Etudiant, etudiant.Nom, etudiant.Prenom FROM etudiant 
JOIN Inscription  ON etudiant.ID_Etudiant = Inscription.ID_Etudiant
GROUP BY etudiant.ID_Etudiant, etudiant.Nom, etudiant.Prenom
HAVING COUNT(DISTINCT Inscription.ID_Matière) = (SELECT COUNT(DISTINCT ID_Matière) FROM Matière);

7-
SELECT Professeur.ID_Professeur, Professeur.Nom, Professeur.Prénom, COUNT(Matière.ID_Matière) AS Nombre_Cours FROM Professeur 
LEFT JOIN Matière  ON Professeur.ID_Professeur = Matière.ID_Professeur
GROUP BY Professeur.ID_Professeur, Professeur.Nom, Professeur.Prénom;

##################################### Exercice 3 #################################################
1- SELECT Auteur, Titre FROM Livres WHERE Genre ='Recette'; 

2- 
SELECT Auteur, COUNT(DISTINCT Reservations.N_Reservation) AS Nombre_de_Reservations, COUNT(DISTINCT Emprunts.N_Emprunt) AS Nombre_Emprunts FROM Livres
    LEFT JOIN Reservations ON Reservations.ISBN = Livres.ISBN AND YEAR(Reservations.Date_Reservation) = 2023
    LEFT JOIN Exemplaires ON Exemplaires.ISBN = Livres.ISBN
    LEFT JOIN Emprunts ON Emprunts.Code_Exemplaire = Exemplaires.Code_Exemplaire AND YEAR(Emprunts.Date_Emprunt) = 2023
GROUP BY 
    Livres.Auteur
HAVING (COUNT(DISTINCT Reservations.N_Reservation) + COUNT(DISTINCT Emprunts.N_Emprunt)) =(SELECT COUNT(DISTINCT Reservations.N_Reservation) + COUNT(DISTINCT Emprunts.N_Emprunt) FROM Livres
                LEFT JOIN Reservations ON Reservations.ISBN = Livres.ISBN AND YEAR(Reservations.Date_Reservation) = 2023
                LEFT JOIN Exemplaires ON Exemplaires.ISBN = Livres.ISBN
                LEFT JOIN Emprunts ON Emprunts.Code_Exemplaire = Exemplaires.Code_Exemplaire AND YEAR(Emprunts.Date_Emprunt) = 2023
            GROUP BY Livres.Auteur
            ORDER BY COUNT(DISTINCT Reservations.N_Reservation) + COUNT(DISTINCT Emprunts.N_Emprunt) DESC
   	    LIMIT 1);
   
3- 
SELECT Genre,COUNT(DISTINCT Emprunts.N_Emprunt) AS Nombre_Emprunts FROM Livres
    LEFT JOIN Exemplaires ON Exemplaires.ISBN = Livres.ISBN
    LEFT JOIN Emprunts ON Emprunts.Code_Exemplaire = Exemplaires.Code_Exemplaire AND YEAR(Emprunts.Date_Emprunt) = 2023
GROUP BY Genre
HAVING COUNT(DISTINCT Emprunts.N_Emprunt) =(SELECT COUNT(DISTINCT Emprunts.N_Emprunt ) 
		FROM Livres
                LEFT JOIN Exemplaires ON Exemplaires.ISBN = Livres.ISBN
                LEFT JOIN Emprunts ON Emprunts.Code_Exemplaire = Exemplaires.Code_Exemplaire AND YEAR(Emprunts.Date_Emprunt) = 2023
            GROUP BY Genre
            ORDER BY COUNT(DISTINCT Emprunts.N_Emprunt) DESC
   	    LIMIT 1);

4- 
SELECT Titre FROM Livres
JOIN Exemplaires ON Exemplaires.ISBN = Livres.ISBN
WHERE YEAR(Livres.Annee_Publication) < 2015 AND Exemplaires.Etat = "Neuf"
GROUP BY Titre;

5-
SELECT Emprunteurs.N_Adherent, Emprunteurs.Nom, Emprunteurs.Prenom FROM Emprunteurs
LEFT JOIN Reservations ON Emprunteurs.N_Adherent = Reservations.N_Adherent
LEFT JOIN Emprunts ON Emprunteurs.N_Adherent = Emprunts.N_Adherent
LEFT JOIN Exemplaires ON Emprunts.Code_Exemplaire = Exemplaires.Code_Exemplaire
WHERE (Emprunts.Date_Emprunt = Reservations.Date_Reservation ) AND (Exemplaires.ISBN != Reservations.ISBN);

6-
SELECT Exemplaires.Code_Exemplaire, COUNT(Exemplaires.Code_Exemplaire) AS Nombre_Exemplaire FROM Exemplaires
LEFT JOIN Emprunts ON Exemplaires.Code_Exemplaire = Emprunts.Code_Exemplaire
WHERE YEAR(Emprunts.Date_Emprunt) = 2023
GROUP BY Exemplaires.Code_Exemplaire
HAVING COUNT(Exemplaires.Code_Exemplaire) > 5;

7-
SELECT Emprunteurs.N_Adherent, Emprunteurs.Nom, Emprunteurs.Prenom FROM  Emprunteurs 
JOIN Emprunts ON Emprunteurs .N_Adherent = Emprunts.N_Adherent
JOIN Exemplaires  ON Emprunts.Code_Exemplaire = Exemplaires.Code_Exemplaire
JOIN Livres ON Exemplaires.ISBN = Livres.ISBN
GROUP BY Emprunteurs.N_Adherent, Emprunteurs.Nom, Emprunteurs.Prenom
HAVING COUNT(DISTINCT Livres.Genre) = (SELECT COUNT(DISTINCT Genre) FROM Livres);




################################# Exercice 4 ##############################################

1- SELECT Name, Population FROM city 
WHERE Population BETWEEN 5000000 AND 7500000;

2- SELECT Name FROM country 
WHERE Region IN ('Antarctica', 'South America');

3- SELECT Name, MAX(Population) AS Population FROM country
WHERE Population = (SELECT MAX(Population) FROM country);

4- SELECT country.Name FROM country 
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode 
WHERE countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T';

5- SELECT country.Name, country.HeadOfState FROM country 
WHERE country.Region IN ('Europe', 'Southeast Asia');

6- SELECT city.Name FROM city 
JOIN country ON city.CountryCode = country.Code 
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode 
WHERE country.Region = 'Western Europe' AND countrylanguage.Language = 'French';

7- SELECT country.Continent, AVG(country.LifeExpectancy) AS AverageLifeExpectancy FROM country 
GROUP BY country.Continent;

8- SELECT AVG(ci.Population) AS AvgCityPopulation FROM city ci
JOIN country co ON ci.CountryCode = co.Code
WHERE co.LifeExpectancy > 70;

################################### Exercice 5 ######################################################

1- SELECT employees.first_name, employees.last_name, departments.dept_name FROM employees 
   LEFT JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
   LEFT JOIN departments  ON dept_manager.dept_no = departments.dept_no;

2- SELECT  departments.dept_name, AVG(salaries.salary) AS Moyenne_Salaire FROM employees 
   JOIN salaries  ON employees.emp_no = salaries.emp_no
   JOIN dept_emp  ON employees.emp_no = dept_emp.emp_no
   JOIN departments ON dept_emp.dept_no = departments.dept_no
   WHERE employees.hire_date > '1990-01-01'
   GROUP BY departments.dept_name;
   
3- SELECT employees.first_name, employees.last_name, AVG(salaries.salary) AS Salaire_Moyen, departments.dept_name, titles.title, employees.birth_date FROM employees 
   JOIN salaries  ON employees.emp_no = salaries.emp_no
   JOIN dept_emp  ON employees.emp_no = dept_emp.emp_no
   JOIN departments ON dept_emp.dept_no = departments.dept_no
   JOIN titles ON employees.emp_no = titles.emp_no
   WHERE employees.birth_date < '1980-01-01'
   GROUP BY employees.emp_no
   ORDER BY employees.birth_date DESC;

4- SELECT departments.dept_name, AVG(salaries.salary) AS Salaire_Moyen FROM departments
   JOIN dept_emp ON departments.dept_no = dept_emp.dept_no
   JOIN salaries ON dept_emp.emp_no = salaries.emp_no
   GROUP BY departments.dept_name
   HAVING AVG(salaries.salary) = (SELECT AVG(salaries.salary) FROM dept_emp
        JOIN salaries ON dept_emp.emp_no = salaries.emp_no
        GROUP BY dept_emp.dept_no
        ORDER BY AVG(salaries.salary) DESC
        LIMIT 1);

5- SELECT employees.first_name, employees.last_name, departments.dept_name, YEAR(CURDATE()) - YEAR(employees.hire_date) AS Anciennete, SUM(salaries.salary) AS Salaire_Total FROM employees
   JOIN salaries ON employees.emp_no = salaries.emp_no
   JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
   JOIN departments ON dept_emp.dept_no = departments.dept_no
   GROUP BY employees.emp_no
   HAVING SUM(salaries.salary) = (SELECT SUM(salaries.salary) FROM employees
        JOIN salaries ON employees.emp_no = salaries.emp_no
        GROUP BY employees.emp_no
        ORDER BY SUM(salaries.salary) DESC
        LIMIT 1);







