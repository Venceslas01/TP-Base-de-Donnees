
###################################################### Exercice 1 ################################

SHOW DATABASES;
CREATE DATABASE Cinema;
Use Cinema;

CREATE TABLE Film (
ID_Film int,
Titre varchar(30),
Annee decimal (4,0),
Genre varchar (300),
Realisateur varchar(300),
Note float,
Duree int
);
CREATE TABLE Realisateur (
ID_Realisateur INTEGER AUTO_INCREMENT,
Nom varchar(30),
Age int (4),
Adresse varchar (300),
PRIMARY KEY(ID_Realisateur)
);

ALTER TABLE Film
DROP COLUMN Realisateur;

ALTER TABLE Film
ADD ID_Realisateur int;

ALTER TABLE Film
ADD CONSTRAINT fk_realisateur
FOREIGN KEY (ID_Realisateur) REFERENCES Realisateur(ID_Realisateur);


ALTER TABLE Film
ADD CONSTRAINT pk_realisateur
PRIMARY KEY (ID_FILM);

CREATE TABLE Seance (
ID_Seance INTEGER AUTO_INCREMENT,
Titre varchar(30),
Horaire time,
version varchar(20),
prix int,
ID_Film int,
PRIMARY KEY(ID_Seance),
CONSTRAINT fk_film
FOREIGN KEY (ID_Film) REFERENCES Film(ID_Film)
);
INSERT INTO Realisateur (Nom, Age, Adresse) VALUES
('Christopher Nolan', 50, 'Adresse de Christopher Nolan'),
('Francis Ford Coppola', 82, 'Adresse de Francis Ford Coppola'),
('Quentin Tarantino', 58, 'Adresse de Quentin Tarantino'),
('James Cameron', 67, 'Adresse de James Cameron'),
('David Fincher', 59, 'Adresse de David Fincher'),
('Robert Zemeckis', 70, 'Adresse de Robert Zemeckis'),
('Ridley Scott', 84, 'Adresse de Ridley Scott'),
('The Wachowskis', NULL, 'Adresse des Wachowskis'),
('Frank Darabont', 62, 'Adresse de Frank Darabont'),
('Steven Spielberg', 75, 'Adresse de Steven Spielberg'),
('Jonathan Demme', NULL, 'Adresse de Jonathan Demme'),
('Stanley Kubrick', NULL, 'Adresse de Stanley Kubrick'),
('Martin Scorsese', 79, 'Adresse de Martin Scorsese');

INSERT INTO Film (ID_Film, Titre, Annee, Genre, ID_Realisateur, Note, Duree) VALUES
(1, 'Inception', 2010, 'Science-Fiction', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Christopher Nolan'), 8.8, 148),
(2, 'Le Parrain', 1972, 'Crime', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Francis Ford Coppola'), 9.2, 175),
(3, 'Pulp Fiction', 1994, 'Crime', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Quentin Tarantino'), 8.9, 154),
(4, 'Avatar', 2009, 'Science-Fiction', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'James Cameron'), 7.8, 162),
(5, 'Fight Club', 1999, 'Drame', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'David Fincher'), 8.8, 139),
(6, 'Forrest Gump', 1994, 'Drame', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Robert Zemeckis'), 8.8, 142),
(7, 'Gladiator', 2000, 'Action', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Ridley Scott'), 8.5, 155),
(8, 'The Matrix', 1999, 'Science-Fiction', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'The Wachowskis'), 8.7, 136),
(9, 'The Dark Knight', 2008, 'Action', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Christopher Nolan'), 9.0, 152),
(10, 'Les Évadés', 1994, 'Drame', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Frank Darabont'), 9.3, 142),
(11, 'Jurassic Park', 1993, 'Science-Fiction', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Steven Spielberg'), 8.1, 127),
(12, 'Le Silence des agneaux', 1991, 'Crime', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Jonathan Demme'), 8.6, 118),
(13, 'The Shining', 1980, 'Horreur', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Stanley Kubrick'), 8.4, 146),
(14, 'Les Infiltrés', 2006, 'Crime', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'Martin Scorsese'), 8.5, 151),
(15, 'Titanic', 1997, 'Drame', (SELECT ID_Realisateur FROM Realisateur WHERE Nom = 'James Cameron'), 7.8, 195);


INSERT INTO Seance (Titre, Horaire, Version, Prix, ID_Film) VALUES
('Inception', '2023-08-10 14:00:00', '2D', 10, 1),
('Le Parrain', '2023-08-10 17:00:00', '2D', 12, 2),
('Pulp Fiction', '2023-08-10 20:00:00', '2D', 11, 3),
('Avatar', '2023-08-11 14:00:00', '3D', 15, 4),
('Fight Club', '2023-08-11 17:00:00', '2D', 10, 5),
('Forrest Gump', '2023-08-11 20:00:00', '2D', 10, 6),
('Gladiator', '2023-08-12 14:00:00', '2D', 12, 7),
('The Matrix', '2023-08-12 17:00:00', '2D', 11, 8),
('The Dark Knight', '2023-08-12 20:00:00', 'IMAX', 18, 9),
('Les Évadés', '2023-08-13 14:00:00', '2D', 10, 10);

##################### Exercice 2 #############################

CREATE DATABASE ecole

Use ecole 

CREATE TABLE etudiant (
    ID_Etudiant INTEGER PRIMARY KEY,
    Nom VARCHAR(255),
    Prenom VARCHAR(255),
    Adresse VARCHAR(255),
    Date_de_Naissance DATE
);

create table if not exists Professeur(
    ID_Professeur int(5) PRIMARY KEY,
    Nom VARCHAR(30),
    Prénom VARCHAR(30),
    Date_de_Naissance DATE
    );
create table if not exists Matière(
     ID_Matière INTEGER ,
     Nom VARCHAR(30),
     ID_Professeur INTEGER,
     CONSTRAINT pk_matière PRIMARY KEY(ID_Matière, ID_Professeur),
     CONSTRAINT fk_id_prof FOREIGN KEY(ID_Professeur)
     REFERENCES Professeur(ID_Professeur) ON DELETE CASCADE
     );
CREATE TABLE IF NOT EXISTS Inscription(
    ID_Inscription INTEGER PRIMARY KEY,
    ID_Etudiant INTEGER,
    ID_Matière INTEGER,
    CONSTRAINT fk_inscription_etudiant FOREIGN KEY(ID_Etudiant)
        REFERENCES etudiant(ID_Etudiant) ON DELETE CASCADE,
    CONSTRAINT fk_inscription_matiere FOREIGN KEY(ID_Matière)
        REFERENCES Matière(ID_Matière) ON DELETE CASCADE
);

INSERT INTO etudiant (ID_Etudiant, Nom, Prenom, Adresse, Date_de_Naissance) VALUES
('01000', 'Smith', 'John', '123 Rue de la République, Amiens', '1997-05-05'),
('01112', 'Johnson', 'Emily', '456 Avenue des Lilas, Camon', '2000-08-21'),
('21211', 'Brown', 'Michael', '789 Chemin du Lac, Rivery', '1998-03-11'),
('02645', 'Lee', 'Sophia', '1010 Boulevard Saint-Michel, Amiens', '2001-09-02'),
('34511', 'Kim', 'David', '234 Rue des Roses, Dury', '1996-07-30'),
('01502', 'Garcia', 'Sofia', '567 Avenue des Chênes, Amiens', '2002-04-14');

INSERT INTO Professeur (ID_Professeur, Nom, Prénom, Date_de_Naissance) VALUES
(1000, 'Davis', 'Robert', '1975-07-10'),
(3310, 'Anderson', 'James', '1869-09-15'),
(0077, 'Garcia', 'Maria', '1993-03-17'),
(8080, 'Smith', 'Laura', '1986-06-19'),
(9000, 'Kim', 'Daniel', '1988-12-14');

INSERT INTO Matière (ID_Matière, Nom, ID_Professeur) VALUES
(10, 'Programmation', 77),
(110, 'Système', 77), 
(32010, 'Base de données', 77),
(32111, 'Sécurité', 3310),
(5000500, 'Intelligence artificielle', 77),
(20, 'Architecture des ordinateurs', 8080);

INSERT INTO Inscription (ID_Inscription, ID_Etudiant, ID_Matière) VALUES
(1, '01000', '10'),   
(2, '01112', '20'),   
(3, '21211', '110'),  
(4, '02645', '32010'),
(5, '34511', '32111'),
(6, '01502', '5000500'); 

 CREATE TABLE IF NOT EXISTS Promotion (
    ID_Promotion INTEGER PRIMARY KEY,
    Nom VARCHAR(30)
    );
ALTER TABLE etudiant ADD COLUMN ID_Promotion INTEGER;

ALTER TABLE etudiant 
ADD CONSTRAINT fk_id_promotion FOREIGN KEY (ID_Promotion) 
REFERENCES Promotion(ID_Promotion);

ALTER TABLE Matière ADD COLUMN Coefficient DECIMAL(3, 2);
ALTER TABLE Matière ADD COLUMN Nombre_Heures INT;

CREATE TABLE IF NOT EXISTS Note (
    ID_Note INTEGER PRIMARY KEY,
    Note DECIMAL(5, 2),
    Date_Evaluation DATE,
    ID_Etudiant INTEGER,
    ID_Matière INTEGER,
    CONSTRAINT fk_id_etudiant  FOREIGN KEY (ID_Etudiant) 
    	REFERENCES etudiant(ID_Etudiant) ON DELETE CASCADE,
    CONSTRAINT fk_id_matière  FOREIGN KEY (ID_Matière) 
    	REFERENCES Matière(ID_Matière) ON DELETE CASCADE
);

DELETE FROM Professeur 
WHERE Date_de_Naissance <= DATE_SUB(CURDATE(), INTERVAL 100 YEAR);

DELETE FROM etudiant 
WHERE Date_de_Naissance <= DATE_SUB(CURDATE(), INTERVAL 100 YEAR);

CREATE TABLE Professeur_Matière (
    ID_Matière INTEGER,
    ID_Professeur INTEGER,
    CONSTRAINT pk_matière_professeur PRIMARY KEY (ID_Matière, ID_Professeur),
    CONSTRAINT fk_id_matière1  FOREIGN KEY (ID_Matière) 
    	REFERENCES Matière(ID_Matière) ON DELETE CASCADE,
    CONSTRAINT fk_id_professeur1  FOREIGN KEY (ID_Professeur) 
    	REFERENCES Professeur(ID_Professeur) ON DELETE CASCADE
);

################## Exercice 3 #################################

CREATE DATABASE concessionaire;
use concessionaire;

CREATE TABLE Voiture (
    ID_Voiture INT PRIMARY KEY AUTO_INCREMENT,
    Marque VARCHAR(255) NOT NULL,
    Modele VARCHAR(255) NOT NULL,
    Annee_Mise_En_Circulation YEAR NOT NULL,
    Couleur VARCHAR(255),
    Kilometrage INT NOT NULL CHECK (Kilometrage >= 10000)
);

CREATE TABLE Proprietaire (
    ID_Proprietaire INT PRIMARY KEY AUTO_INCREMENT,
    Nom VARCHAR(255) NOT NULL,
    Prenom VARCHAR(255) NOT NULL,
    Numero_Telephone VARCHAR(20),
    Adresse_Mail VARCHAR(255) NOT NULL
);

CREATE TABLE Propriété (
    ID_Voiture INT,
    ID_Proprietaire INT,
    Prix DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ID_Voiture, ID_Proprietaire),
    FOREIGN KEY (ID_Voiture) REFERENCES Voiture(ID_Voiture),
    FOREIGN KEY (ID_Proprietaire) REFERENCES 		 Proprietaire(ID_Proprietaire)
);

ALTER TABLE Proprietaire
ADD COLUMN Numero_Permis VARCHAR(255) UNIQUE,
ADD COLUMN Adresse VARCHAR(255) NOT NULL;

CREATE TABLE Clients_Premium (
    ID_Proprietaire INT PRIMARY KEY,
    FOREIGN KEY (ID_Proprietaire) REFERENCES Proprietaire(ID_Proprietaire)
);
INSERT INTO Clients_Premium (ID_Proprietaire)
SELECT DISTINCT p.ID_Proprietaire
FROM Proprietaire p
JOIN Propriété po ON p.ID_Proprietaire = po.ID_Proprietaire
WHERE po.Prix > 100000;

################## Exercice 4  #################################

CREATE DATABASE Bibliotheque;
USE Bibliotheque;
CREATE TABLE Livres (
    ISBN VARCHAR(255) PRIMARY KEY,
    Titre VARCHAR(255) NOT NULL,
    Auteur VARCHAR(255) NOT NULL,
    Annee_Publication YEAR,
    Editeur VARCHAR(255) NOT NULL,
    Genre VARCHAR(255),
    Nombre_Pages INT
);
CREATE TABLE Exemplaires (
    Code_Exemplaire VARCHAR(255) PRIMARY KEY,
    ISBN VARCHAR(255) NOT NULL,
    Etat VARCHAR(255) NOT NULL,
    Emplacement VARCHAR(255) NOT NULL,
    Date_Acquisition DATE,
    FOREIGN KEY (ISBN) REFERENCES Livres(ISBN)
);

CREATE TABLE Emprunteurs (
    N_Adherent INT PRIMARY KEY,
    Nom VARCHAR(255) NOT NULL,
    Prenom VARCHAR(255) NOT NULL,
    Adresse VARCHAR(255),
    Numero_Telephone VARCHAR(20),
    Adresse_Email VARCHAR(255) NOT NULL
);
CREATE TABLE Emprunts (
    N_Emprunt INTEGER PRIMARY KEY,
    N_Adherent INT NOT NULL,
    Code_Exemplaire VARCHAR(255) NOT NULL,
    Date_Emprunt DATE NOT NULL,
    Date_Retour_Prevue DATE NOT NULL,
    FOREIGN KEY (N_Adherent) REFERENCES Emprunteurs(N_Adherent),
    FOREIGN KEY(Code_Exemplaire) REFERENCES Exemplaires(Code_Exemplaire)
);
CREATE TABLE Reservations (
    N_Reservation INTEGER PRIMARY KEY,
    N_Adherent INT NOT NULL,
    ISBN VARCHAR(255) NOT NULL,
    Date_Reservation DATE NOT NULL,
    FOREIGN KEY (N_Adherent) REFERENCES Emprunteurs(N_Adherent),
    FOREIGN KEY (ISBN) REFERENCES Livres(ISBN)
);
CREATE TABLE Emprunts_Adherents (
    ID_Emprunt_Adherent INTEGER PRIMARY KEY,
    ID_Proprietaire INT NOT NULL,
    ID_Emprunteur INT NOT NULL,
    ISBN VARCHAR(255) NOT NULL,
    Date_Emprunt DATE NOT NULL,
    Date_Retour DATE,
    FOREIGN KEY (ID_Proprietaire) REFERENCES Emprunteurs(N_Adherent),
    FOREIGN KEY (ID_Emprunteur) REFERENCES Emprunteurs(N_Adherent),
    FOREIGN KEY (ISBN) REFERENCES Livres(ISBN)
);
ALTER TABLE Emprunts_Adherents
ADD COLUMN Code_Exemplaire VARCHAR(255),
ADD FOREIGN KEY (Code_Exemplaire) REFERENCES Exemplaires(Code_Exemplaire);
DROP TABLE IF EXISTS Emprunts_Adherents;


INSERT INTO Livres (ISBN, Titre, Auteur, Annee_Publication, Editeur, Genre, Nombre_Pages)
VALUES 
('978-1234567890', 'Le Mystère de la Chambre Jaune', 'Gaston Leroux', 1908, 'Pierre Lafitte', 'Roman policier', 300),
('978-0316015844', 'Twilight', 'Stephenie Meyer', 2005, 'Little, Brown and Company', 'Roman', 498),
('978-0553382563', 'Le Guide du voyageur galactique', 'Douglas Adams', 2004, 'Del Rey Books', 'Science-Fiction', 216),
('978-0385514231', 'Da Vinci Code', 'Dan Brown', 2003, 'Doubleday', 'Thriller', 454),
('978-1501110368', 'La Fille du train', 'Paula Hawkins', 2015, 'Riverhead Books', 'Thriller', 336),
('978-2070612758', 'Harry Potter et le Prince de Sang-Mêlé', 'J.K. Rowling', 2005, 'Gallimard Jeunesse', 'Fantastique', 607),
('978-2253124801', 'Millénium, Tome 1 : Les hommes qui n’aimaient pas les femmes', 'Stieg Larsson', 2006, 'Actes Sud', 'Policier', 575),
('978-2081203049', 'Je sais cuisiner', 'Ginette Mathiot', 2008, 'Flammarion', 'Recette', 976),
('978-2035841967', 'Le grand Larousse gastronomique', 'Collectif', 2007, 'Larousse', 'Recette', 992);


INSERT INTO Exemplaires (Code_Exemplaire, ISBN, Etat, Emplacement, Date_Acquisition)
VALUES  ('EX124', '978-0316015844', 'Bon', 'Section B', '2023-01-02'),
	('EX125', '978-0553382563', 'Usé', 'Section C', '2023-01-03'),
	('EX123', '978-1234567890', 'Neuf', 'Section A', '2023-01-01'),
	('EX126', '978-0385514231', 'Neuf', 'Section D', '2023-01-04');

INSERT INTO Emprunteurs (N_Adherent, Nom, Prenom, Adresse, Numero_Telephone, Adresse_Email)
VALUES (1, 'Dupont', 'Jean', '123 rue de Paris', '0123456789', 'jean.dupont@email.com'),
(2, 'Martin', 'Alice', '456 avenue de la Liberté', '0123456790', 'alice.martin@email.com'),
(3, 'Leroy', 'Maxime', '789 boulevard de la République', '0123456791', 'maxime.leroy@email.com'),
(4, 'Bernard', 'Claire', '1011 rue du Château', '0123456792', 'claire.bernard@email.com');

INSERT INTO Emprunts (N_Emprunt, N_Adherent, Code_Exemplaire, Date_Emprunt, Date_Retour_Prevue)
VALUES (1001, 1, 'EX123', '2023-01-10', '2023-02-10'),
(1002, 2, 'EX124', '2023-01-11', '2023-02-11'),
(1003, 3, 'EX125', '2023-01-12', '2023-02-12'),
(1004, 4, 'EX126', '2023-01-13', '2023-02-13');

INSERT INTO Reservations (N_Reservation, N_Adherent, ISBN, Date_Reservation)
VALUES (2001, 1, '978-1234567890', '2023-01-05'),
	(2002, 2, '978-0316015844', '2023-01-07'),
	(2003, 3, '978-0553382563', '2023-01-08'),
	(2004, 4, '978-0385514231', '2023-01-09');






