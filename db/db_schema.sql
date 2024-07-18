CREATE DATABASE superbowl;

-- Utiliser la base de données
USE superbowl_db;

-- Créez la table users si elle n'existe pas
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(255)
);

-- Insérez des utilisateurs de test
INSERT INTO users (firstname, lastname, email, password) VALUES
('John', 'Doe', 'john@example.com', 'password1'),
('Jane', 'Smith', 'jane@example.com', 'password2'),
('Alice', 'Johnson', 'alice@example.com', 'password3'),
('Bob', 'Brown', 'bob@example.com', 'password4'),
('Charlie', 'Davis', 'charlie@example.com', 'password5'),
('David', 'Wilson', 'david@example.com', 'password6'),
('Eve', 'Miller', 'eve@example.com', 'password7'),
('Frank', 'Moore', 'frank@example.com', 'password8'),
('Grace', 'Taylor', 'grace@example.com', 'password9'),
('Hank', 'Anderson', 'hank@example.com', 'password10');

-- Créez la table matches si elle n'existe pas
CREATE TABLE IF NOT EXISTS matches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team1 VARCHAR(50),
    team2 VARCHAR(50),
    date DATE,
    time TIME,
    status ENUM('À venir', 'En cours', 'Terminé'),
    score VARCHAR(20)
);

-- Insérez des matchs de test
INSERT INTO matches (team1, team2, date, time, status, score) VALUES
('Team A', 'Team B', '2024-07-05', '15:00:00', 'À venir', NULL),
('Team C', 'Team D', '2024-07-06', '18:00:00', 'En cours', '1-0'),
('Team E', 'Team F', '2024-07-07', '12:00:00', 'À venir', NULL),
('Team G', 'Team H', '2024-07-08', '16:00:00', 'À venir', NULL),
('Team I', 'Team J', '2024-07-09', '14:00:00', 'À venir', NULL),
('Team K', 'Team L', '2024-07-10', '17:00:00', 'À venir', NULL),
('Team M', 'Team N', '2024-07-11', '13:00:00', 'À venir', NULL),
('Team O', 'Team P', '2024-07-12', '15:00:00', 'À venir', NULL),
('Team Q', 'Team R', '2024-07-13', '11:00:00', 'À venir', NULL),
('Team S', 'Team T', '2024-07-14', '10:00:00', 'À venir', NULL),
('Team U', 'Team V', '2024-07-15', '16:00:00', 'À venir', NULL),
('Team W', 'Team X', '2024-07-16', '14:00:00', 'À venir', NULL),
('Team Y', 'Team Z', '2024-07-17', '18:00:00', 'À venir', NULL),
('Team AA', 'Team BB', '2024-07-18', '12:00:00', 'À venir', NULL),
('Team CC', 'Team DD', '2024-07-19', '15:00:00', 'À venir', NULL),
('Team EE', 'Team FF', '2024-07-20', '13:00:00', 'À venir', NULL),
('Team GG', 'Team HH', '2024-07-21', '17:00:00', 'À venir', NULL),
('Team II', 'Team JJ', '2024-07-22', '14:00:00', 'À venir', NULL),
('Team KK', 'Team LL', '2024-07-23', '12:00:00', 'À venir', NULL),
('Team MM', 'Team NN', '2024-07-24', '16:00:00', 'À venir', NULL),
('Team OO', 'Team PP', '2024-07-25', '13:00:00', 'À venir', NULL),
('Team QQ', 'Team RR', '2024-07-26', '17:00:00', 'À venir', NULL),
('Team SS', 'Team TT', '2024-07-27', '14:00:00', 'À venir', NULL);

-- Créez la table bets si elle n'existe pas
CREATE TABLE IF NOT EXISTS bets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    match_id INT,
    amount DECIMAL(10, 2),
    team VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (match_id) REFERENCES matches(id) ON DELETE CASCADE
);

-- Insérez des paris de test
INSERT INTO bets (user_id, match_id, amount, team) VALUES
(1, 1, 50.00, 'Team A'),
(1, 2, 30.00, 'Team D'),
(2, 1, 20.00, 'Team B'),
(2, 3, 40.00, 'Team E'),
(3, 4, 60.00, 'Team G'),
(3, 5, 70.00, 'Team I'),
(4, 6, 10.00, 'Team K'),
(4, 7, 15.00, 'Team M'),
(5, 8, 25.00, 'Team O'),
(5, 9, 35.00, 'Team Q'),
(6, 10, 45.00, 'Team S'),
(6, 11, 55.00, 'Team U'),
(7, 12, 65.00, 'Team W'),
(7, 13, 75.00, 'Team Y'),
(8, 14, 85.00, 'Team AA'),
(8, 15, 95.00, 'Team CC'),
(9, 16, 105.00, 'Team EE'),
(9, 17, 115.00, 'Team GG'),
(10, 18, 125.00, 'Team II'),
(10, 19, 135.00, 'Team KK');

-- Ajout de la colonne weather dans la table matches
ALTER TABLE matches ADD weather VARCHAR(255);

-- Création de la table players
CREATE TABLE players (
    id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT,
    team VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    FOREIGN KEY (match_id) REFERENCES matches(id)
);

-- Création de la table team_odds
CREATE TABLE team_odds (
    id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT,
    team VARCHAR(255),
    odds DECIMAL(5, 2),
    FOREIGN KEY (match_id) REFERENCES matches(id)
);

-- Création de la table comments
CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    match_id INT,
    commentator VARCHAR(255),
    comment TEXT,
    score VARCHAR(50),
    FOREIGN KEY (match_id) REFERENCES matches(id)
);
INSERT INTO players (match_id, team, first_name, last_name) VALUES
-- Match 1 - Team A
(1, 'Team A', 'John', 'Doe'),
(1, 'Team A', 'James', 'Smith'),
(1, 'Team A', 'David', 'Johnson'),
(1, 'Team A', 'Chris', 'Lee'),
(1, 'Team A', 'Daniel', 'Clark'),
(1, 'Team A', 'Mark', 'Wright'),
(1, 'Team A', 'Steve', 'Walker'),
(1, 'Team A', 'Kevin', 'White'),
(1, 'Team A', 'Paul', 'Green'),
(1, 'Team A', 'Peter', 'Hall'),
-- Match 1 - Team B
(1, 'Team B', 'Robert', 'Brown'),
(1, 'Team B', 'Michael', 'Davis'),
(1, 'Team B', 'James', 'Miller'),
(1, 'Team B', 'William', 'Wilson'),
(1, 'Team B', 'Joseph', 'Moore'),
(1, 'Team B', 'Thomas', 'Taylor'),
(1, 'Team B', 'Charles', 'Anderson'),
(1, 'Team B', 'Matthew', 'Thomas'),
(1, 'Team B', 'Brian', 'Jackson'),
(1, 'Team B', 'George', 'Martinez'),

-- Match 2 - Team C
(2, 'Team C', 'William', 'Jones'),
(2, 'Team C', 'David', 'Wilson'),
(2, 'Team C', 'Richard', 'Taylor'),
(2, 'Team C', 'Joseph', 'Anderson'),
(2, 'Team C', 'Charles', 'Harris'),
(2, 'Team C', 'Christopher', 'Martin'),
(2, 'Team C', 'Daniel', 'Thompson'),
(2, 'Team C', 'Matthew', 'Garcia'),
(2, 'Team C', 'Anthony', 'Martinez'),
(2, 'Team C', 'Donald', 'Robinson'),
-- Match 2 - Team D
(2, 'Team D', 'Richard', 'Taylor'),
(2, 'Team D', 'Joseph', 'Anderson'),
(2, 'Team D', 'George', 'Lee'),
(2, 'Team D', 'Paul', 'Walker'),
(2, 'Team D', 'Steven', 'White'),
(2, 'Team D', 'Andrew', 'Green'),
(2, 'Team D', 'Kenneth', 'Hall'),
(2, 'Team D', 'Joshua', 'Allen'),
(2, 'Team D', 'Kevin', 'Young'),
(2, 'Team D', 'Brian', 'Hernandez'),

-- Match 3 - Team E
(3, 'Team E', 'Chris', 'Evans'),
(3, 'Team E', 'Samuel', 'Jackson'),
(3, 'Team E', 'John', 'Doe'),
(3, 'Team E', 'James', 'Smith'),
(3, 'Team E', 'David', 'Johnson'),
(3, 'Team E', 'Chris', 'Lee'),
(3, 'Team E', 'Daniel', 'Clark'),
(3, 'Team E', 'Mark', 'Wright'),
(3, 'Team E', 'Steve', 'Walker'),
(3, 'Team E', 'Kevin', 'White'),
-- Match 3 - Team F
(3, 'Team F', 'Mark', 'Ruffalo'),
(3, 'Team F', 'Scarlett', 'Johansson'),
(3, 'Team F', 'Robert', 'Brown'),
(3, 'Team F', 'Michael', 'Davis'),
(3, 'Team F', 'James', 'Miller'),
(3, 'Team F', 'William', 'Wilson'),
(3, 'Team F', 'Joseph', 'Moore'),
(3, 'Team F', 'Thomas', 'Taylor'),
(3, 'Team F', 'Charles', 'Anderson'),
(3, 'Team F', 'Matthew', 'Thomas'),

-- Match 4 - Team G
(4, 'Team G', 'Kevin', 'Durant'),
(4, 'Team G', 'Stephen', 'Curry'),
(4, 'Team G', 'Klay', 'Thompson'),
(4, 'Team G', 'Draymond', 'Green'),
(4, 'Team G', 'James', 'Harden'),
(4, 'Team G', 'Russell', 'Westbrook'),
(4, 'Team G', 'Chris', 'Paul'),
(4, 'Team G', 'Damian', 'Lillard'),
(4, 'Team G', 'Kyrie', 'Irving'),
(4, 'Team G', 'Blake', 'Griffin'),
-- Match 4 - Team H
(4, 'Team H', 'LeBron', 'James'),
(4, 'Team H', 'Anthony', 'Davis'),
(4, 'Team H', 'Paul', 'George'),
(4, 'Team H', 'Kawhi', 'Leonard'),
(4, 'Team H', 'Luka', 'Doncic'),
(4, 'Team H', 'Giannis', 'Antetokounmpo'),
(4, 'Team H', 'Nikola', 'Jokic'),
(4, 'Team H', 'Joel', 'Embiid'),
(4, 'Team H', 'Jimmy', 'Butler'),
(4, 'Team H', 'Zion', 'Williamson'),

-- Match 5 - Team I
(5, 'Team I', 'Lionel', 'Messi'),
(5, 'Team I', 'Cristiano', 'Ronaldo'),
(5, 'Team I', 'Neymar', 'Junior'),
(5, 'Team I', 'Kylian', 'Mbappe'),
(5, 'Team I', 'Luka', 'Modric'),
(5, 'Team I', 'Kevin', 'De Bruyne'),
(5, 'Team I', 'Mohamed', 'Salah'),
(5, 'Team I', 'Virgil', 'Van Dijk'),
(5, 'Team I', 'Sergio', 'Ramos'),
(5, 'Team I', 'Robert', 'Lewandowski'),
-- Match 5 - Team J
(5, 'Team J', 'Harry', 'Kane'),
(5, 'Team J', 'Raheem', 'Sterling'),
(5, 'Team J', 'Paul', 'Pogba'),
(5, 'Team J', 'Bruno', 'Fernandes'),
(5, 'Team J', 'Eden', 'Hazard'),
(5, 'Team J', 'Antoine', 'Griezmann'),
(5, 'Team J', 'Romelu', 'Lukaku'),
(5, 'Team J', 'Jadon', 'Sancho'),
(5, 'Team J', 'Timo', 'Werner'),
(5, 'Team J', 'Philippe', 'Coutinho'),

-- Match 6 - Team K
(6, 'Team K', 'Manuel', 'Neuer'),
(6, 'Team K', 'Joshua', 'Kimmich'),
(6, 'Team K', 'Leon', 'Goretzka'),
(6, 'Team K', 'Thomas', 'Muller'),
(6, 'Team K', 'Robert', 'Lewandowski'),
(6, 'Team K', 'Serge', 'Gnabry'),
(6, 'Team K', 'Alphonso', 'Davies'),
(6, 'Team K', 'David', 'Alaba'),
(6, 'Team K', 'Lucas', 'Hernandez'),
(6, 'Team K', 'Niklas', 'Sule'),
-- Match 6 - Team L
(6, 'Team L', 'Jan', 'Oblak'),
(6, 'Team L', 'Koke', 'Resurreccion'),
(6, 'Team L', 'Saul', 'Niguez'),
(6, 'Team L', 'Marcos', 'Llorente'),
(6, 'Team L', 'Luis', 'Suarez'),
(6, 'Team L', 'Joao', 'Felix'),
(6, 'Team L', 'Angel', 'Correa'),
(6, 'Team L', 'Yannick', 'Carrasco'),
(6, 'Team L', 'Stefan', 'Savic'),
(6, 'Team L', 'Jose', 'Gimenez'),

-- Match 7 - Team M
(7, 'Team M', 'Sergio', 'Aguero'),
(7, 'Team M', 'Gabriel', 'Jesus'),
(7, 'Team M', 'Kevin', 'De Bruyne'),
(7, 'Team M', 'Bernardo', 'Silva'),
(7, 'Team M', 'Raheem', 'Sterling'),
(7, 'Team M', 'Riyad', 'Mahrez'),
(7, 'Team M', 'Ilkay', 'Gundogan'),
(7, 'Team M', 'Phil', 'Foden'),
(7, 'Team M', 'Fernandinho', 'Luis'),
(7, 'Team M', 'Aymeric', 'Laporte'),
-- Match 7 - Team N
(7, 'Team N', 'Thibaut', 'Courtois'),
(7, 'Team N', 'Sergio', 'Ramos'),
(7, 'Team N', 'Raphael', 'Varane'),
(7, 'Team N', 'Marcelo', 'Vieira'),
(7, 'Team N', 'Toni', 'Kroos'),
(7, 'Team N', 'Luka', 'Modric'),
(7, 'Team N', 'Casemiro', 'Carlos'),
(7, 'Team N', 'Eden', 'Hazard'),
(7, 'Team N', 'Karim', 'Benzema'),
(7, 'Team N', 'Vinicius', 'Junior'),

-- Match 8 - Team O
(8, 'Team O', 'Alisson', 'Becker'),
(8, 'Team O', 'Virgil', 'Van Dijk'),
(8, 'Team O', 'Trent', 'Alexander-Arnold'),
(8, 'Team O', 'Andy', 'Robertson'),
(8, 'Team O', 'Fabinho', 'Tavares'),
(8, 'Team O', 'Jordan', 'Henderson'),
(8, 'Team O', 'Georginio', 'Wijnaldum'),
(8, 'Team O', 'Sadio', 'Mane'),
(8, 'Team O', 'Roberto', 'Firmino'),
(8, 'Team O', 'Mohamed', 'Salah'),
-- Match 8 - Team P
(8, 'Team P', 'Gianluigi', 'Donnarumma'),
(8, 'Team P', 'Leonardo', 'Bonucci'),
(8, 'Team P', 'Giorgio', 'Chiellini'),
(8, 'Team P', 'Alessandro', 'Florenzi'),
(8, 'Team P', 'Marco', 'Verratti'),
(8, 'Team P', 'Jorginho', 'Frello'),
(8, 'Team P', 'Nicolo', 'Barella'),
(8, 'Team P', 'Federico', 'Chiesa'),
(8, 'Team P', 'Lorenzo', 'Insigne'),
(8, 'Team P', 'Ciro', 'Immobile'),

-- Match 9 - Team Q
(9, 'Team Q', 'Kasper', 'Schmeichel'),
(9, 'Team Q', 'Simon', 'Kjaer'),
(9, 'Team Q', 'Andreas', 'Christensen'),
(9, 'Team Q', 'Thomas', 'Delaney'),
(9, 'Team Q', 'Pierre-Emile', 'Hojbjerg'),
(9, 'Team Q', 'Christian', 'Eriksen'),
(9, 'Team Q', 'Yussuf', 'Poulsen'),
(9, 'Team Q', 'Martin', 'Braithwaite'),
(9, 'Team Q', 'Jonas', 'Wind'),
(9, 'Team Q', 'Mikkel', 'Damsgaard'),
-- Match 9 - Team R
(9, 'Team R', 'Hugo', 'Lloris'),
(9, 'Team R', 'Raphael', 'Varane'),
(9, 'Team R', 'Benjamin', 'Pavard'),
(9, 'Team R', 'Presnel', 'Kimpembe'),
(9, 'Team R', 'Paul', 'Pogba'),
(9, 'Team R', 'N\'Golo', 'Kante'),
(9, 'Team R', 'Adrien', 'Rabiot'),
(9, 'Team R', 'Antoine', 'Griezmann'),
(9, 'Team R', 'Kylian', 'Mbappe'),
(9, 'Team R', 'Karim', 'Benzema'),

-- Match 10 - Team S
(10, 'Team S', 'David', 'De Gea'),
(10, 'Team S', 'Harry', 'Maguire'),
(10, 'Team S', 'Luke', 'Shaw'),
(10, 'Team S', 'Bruno', 'Fernandes'),
(10, 'Team S', 'Paul', 'Pogba'),
(10, 'Team S', 'Scott', 'McTominay'),
(10, 'Team S', 'Fred', 'Rodrigues'),
(10, 'Team S', 'Marcus', 'Rashford'),
(10, 'Team S', 'Mason', 'Greenwood'),
(10, 'Team S', 'Edinson', 'Cavani'),
-- Match 10 - Team T
(10, 'Team T', 'Edouard', 'Mendy'),
(10, 'Team T', 'Thiago', 'Silva'),
(10, 'Team T', 'Antonio', 'Rudiger'),
(10, 'Team T', 'N\'Golo', 'Kante'),
(10, 'Team T', 'Mateo', 'Kovacic'),
(10, 'Team T', 'Mason', 'Mount'),
(10, 'Team T', 'Jorginho', 'Frello'),
(10, 'Team T', 'Timo', 'Werner'),
(10, 'Team T', 'Kai', 'Havertz'),
(10, 'Team T', 'Christian', 'Pulisic'),

-- Match 11 - Team U
(11, 'Team U', 'Gianluigi', 'Buffon'),
(11, 'Team U', 'Leonardo', 'Bonucci'),
(11, 'Team U', 'Giorgio', 'Chiellini'),
(11, 'Team U', 'Alex', 'Sandro'),
(11, 'Team U', 'Juan', 'Cuadrado'),
(11, 'Team U', 'Rodrigo', 'Bentancur'),
(11, 'Team U', 'Federico', 'Chiesa'),
(11, 'Team U', 'Paulo', 'Dybala'),
(11, 'Team U', 'Cristiano', 'Ronaldo'),
(11, 'Team U', 'Alvaro', 'Morata'),
-- Match 11 - Team V
(11, 'Team V', 'Jan', 'Oblak'),
(11, 'Team V', 'Kieran', 'Trippier'),
(11, 'Team V', 'Jose', 'Gimenez'),
(11, 'Team V', 'Saul', 'Niguez'),
(11, 'Team V', 'Koke', 'Resurreccion'),
(11, 'Team V', 'Thomas', 'Partey'),
(11, 'Team V', 'Marcos', 'Llorente'),
(11, 'Team V', 'Joao', 'Felix'),
(11, 'Team V', 'Angel', 'Correa'),
(11, 'Team V', 'Luis', 'Suarez'),

-- Match 12 - Team W
(12, 'Team W', 'Keylor', 'Navas'),
(12, 'Team W', 'Sergio', 'Ramos'),
(12, 'Team W', 'Marquinhos', 'Correra'),
(12, 'Team W', 'Juan', 'Bernat'),
(12, 'Team W', 'Ander', 'Herrera'),
(12, 'Team W', 'Marco', 'Verratti'),
(12, 'Team W', 'Angel', 'Di Maria'),
(12, 'Team W', 'Neymar', 'Junior'),
(12, 'Team W', 'Kylian', 'Mbappe'),
(12, 'Team W', 'Mauro', 'Icardi'),
-- Match 12 - Team X
(12, 'Team X', 'Gianluigi', 'Donnarumma'),
(12, 'Team X', 'Simon', 'Kjaer'),
(12, 'Team X', 'Alessio', 'Romagnoli'),
(12, 'Team X', 'Theo', 'Hernandez'),
(12, 'Team X', 'Franck', 'Kessie'),
(12, 'Team X', 'Ismael', 'Bennacer'),
(12, 'Team X', 'Samu', 'Castillejo'),
(12, 'Team X', 'Hakan', 'Calhanoglu'),
(12, 'Team X', 'Zlatan', 'Ibrahimovic'),
(12, 'Team X', 'Rafael', 'Leao'),

-- Match 13 - Team Y
(13, 'Team Y', 'Ederson', 'Santana'),
(13, 'Team Y', 'Kyle', 'Walker'),
(13, 'Team Y', 'John', 'Stones'),
(13, 'Team Y', 'Ruben', 'Dias'),
(13, 'Team Y', 'Joao', 'Cancelo'),
(13, 'Team Y', 'Rodri', 'Hernandez'),
(13, 'Team Y', 'Kevin', 'De Bruyne'),
(13, 'Team Y', 'Phil', 'Foden'),
(13, 'Team Y', 'Raheem', 'Sterling'),
(13, 'Team Y', 'Sergio', 'Aguero'),
-- Match 13 - Team Z
(13, 'Team Z', 'Marc-Andre', 'Ter Stegen'),
(13, 'Team Z', 'Gerard', 'Pique'),
(13, 'Team Z', 'Jordi', 'Alba'),
(13, 'Team Z', 'Sergio', 'Busquets'),
(13, 'Team Z', 'Frenkie', 'De Jong'),
(13, 'Team Z', 'Pedri', 'Gonzalez'),
(13, 'Team Z', 'Lionel', 'Messi'),
(13, 'Team Z', 'Antoine', 'Griezmann'),
(13, 'Team Z', 'Ousmane', 'Dembele'),
(13, 'Team Z', 'Ansu', 'Fati'),

-- Match 14 - Team AA
(14, 'Team AA', 'David', 'Ospina'),
(14, 'Team AA', 'Kalidou', 'Koulibaly'),
(14, 'Team AA', 'Giovanni', 'Di Lorenzo'),
(14, 'Team AA', 'Fabian', 'Ruiz'),
(14, 'Team AA', 'Lorenzo', 'Insigne'),
(14, 'Team AA', 'Dries', 'Mertens'),
(14, 'Team AA', 'Victor', 'Osimhen'),
(14, 'Team AA', 'Piotr', 'Zielinski'),
(14, 'Team AA', 'Matteo', 'Politano'),
(14, 'Team AA', 'Eljif', 'Elmas'),
-- Match 14 - Team BB
(14, 'Team BB', 'Samir', 'Handanovic'),
(14, 'Team BB', 'Milan', 'Skriniar'),
(14, 'Team BB', 'Stefan', 'De Vrij'),
(14, 'Team BB', 'Alessandro', 'Bastoni'),
(14, 'Team BB', 'Nicolo', 'Barella'),
(14, 'Team BB', 'Marcelo', 'Brozovic'),
(14, 'Team BB', 'Arturo', 'Vidal'),
(14, 'Team BB', 'Achraf', 'Hakimi'),
(14, 'Team BB', 'Lautaro', 'Martinez'),
(14, 'Team BB', 'Romelu', 'Lukaku'),

-- Match 15 - Team CC
(15, 'Team CC', 'Wojciech', 'Szczesny'),
(15, 'Team CC', 'Leonardo', 'Bonucci'),
(15, 'Team CC', 'Giorgio', 'Chiellini'),
(15, 'Team CC', 'Alex', 'Sandro'),
(15, 'Team CC', 'Juan', 'Cuadrado'),
(15, 'Team CC', 'Rodrigo', 'Bentancur'),
(15, 'Team CC', 'Federico', 'Chiesa'),
(15, 'Team CC', 'Paulo', 'Dybala'),
(15, 'Team CC', 'Cristiano', 'Ronaldo'),
(15, 'Team CC', 'Alvaro', 'Morata'),
-- Match 15 - Team DD
(15, 'Team DD', 'David', 'De Gea'),
(15, 'Team DD', 'Harry', 'Maguire'),
(15, 'Team DD', 'Luke', 'Shaw'),
(15, 'Team DD', 'Bruno', 'Fernandes'),
(15, 'Team DD', 'Paul', 'Pogba'),
(15, 'Team DD', 'Scott', 'McTominay'),
(15, 'Team DD', 'Fred', 'Rodrigues'),
(15, 'Team DD', 'Marcus', 'Rashford'),
(15, 'Team DD', 'Mason', 'Greenwood'),
(15, 'Team DD', 'Edinson', 'Cavani'),

-- Match 16 - Team EE
(16, 'Team EE', 'Keylor', 'Navas'),
(16, 'Team EE', 'Sergio', 'Ramos'),
(16, 'Team EE', 'Marquinhos', 'Correra'),
(16, 'Team EE', 'Juan', 'Bernat'),
(16, 'Team EE', 'Ander', 'Herrera'),
(16, 'Team EE', 'Marco', 'Verratti'),
(16, 'Team EE', 'Angel', 'Di Maria'),
(16, 'Team EE', 'Neymar', 'Junior'),
(16, 'Team EE', 'Kylian', 'Mbappe'),
(16, 'Team EE', 'Mauro', 'Icardi'),
-- Match 16 - Team FF
(16, 'Team FF', 'Manuel', 'Neuer'),
(16, 'Team FF', 'Joshua', 'Kimmich'),
(16, 'Team FF', 'Leon', 'Goretzka'),
(16, 'Team FF', 'Thomas', 'Muller'),
(16, 'Team FF', 'Robert', 'Lewandowski'),
(16, 'Team FF', 'Serge', 'Gnabry'),
(16, 'Team FF', 'Alphonso', 'Davies'),
(16, 'Team FF', 'David', 'Alaba'),
(16, 'Team FF', 'Lucas', 'Hernandez'),
(16, 'Team FF', 'Niklas', 'Sule'),

-- Match 17 - Team GG
(17, 'Team GG', 'Jan', 'Oblak'),
(17, 'Team GG', 'Koke', 'Resurreccion'),
(17, 'Team GG', 'Saul', 'Niguez'),
(17, 'Team GG', 'Marcos', 'Llorente'),
(17, 'Team GG', 'Luis', 'Suarez'),
(17, 'Team GG', 'Joao', 'Felix'),
(17, 'Team GG', 'Angel', 'Correa'),
(17, 'Team GG', 'Yannick', 'Carrasco'),
(17, 'Team GG', 'Stefan', 'Savic'),
(17, 'Team GG', 'Jose', 'Gimenez'),
-- Match 17 - Team HH
(17, 'Team HH', 'David', 'De Gea'),
(17, 'Team HH', 'Harry', 'Maguire'),
(17, 'Team HH', 'Luke', 'Shaw'),
(17, 'Team HH', 'Bruno', 'Fernandes'),
(17, 'Team HH', 'Paul', 'Pogba'),
(17, 'Team HH', 'Scott', 'McTominay'),
(17, 'Team HH', 'Fred', 'Rodrigues'),
(17, 'Team HH', 'Marcus', 'Rashford'),
(17, 'Team HH', 'Mason', 'Greenwood'),
(17, 'Team HH', 'Edinson', 'Cavani'),

-- Match 18 - Team II
(18, 'Team II', 'Lionel', 'Messi'),
(18, 'Team II', 'Cristiano', 'Ronaldo'),
(18, 'Team II', 'Neymar', 'Junior'),
(18, 'Team II', 'Kylian', 'Mbappe'),
(18, 'Team II', 'Luka', 'Modric'),
(18, 'Team II', 'Kevin', 'De Bruyne'),
(18, 'Team II', 'Mohamed', 'Salah'),
(18, 'Team II', 'Virgil', 'Van Dijk'),
(18, 'Team II', 'Sergio', 'Ramos'),
(18, 'Team II', 'Robert', 'Lewandowski'),
-- Match 18 - Team JJ
(18, 'Team JJ', 'Harry', 'Kane'),
(18, 'Team JJ', 'Raheem', 'Sterling'),
(18, 'Team JJ', 'Paul', 'Pogba'),
(18, 'Team JJ', 'Bruno', 'Fernandes'),
(18, 'Team JJ', 'Eden', 'Hazard'),
(18, 'Team JJ', 'Antoine', 'Griezmann'),
(18, 'Team JJ', 'Romelu', 'Lukaku'),
(18, 'Team JJ', 'Jadon', 'Sancho'),
(18, 'Team JJ', 'Timo', 'Werner'),
(18, 'Team JJ', 'Philippe', 'Coutinho'),

-- Match 19 - Team KK
(19, 'Team KK', 'Manuel', 'Neuer'),
(19, 'Team KK', 'Joshua', 'Kimmich'),
(19, 'Team KK', 'Leon', 'Goretzka'),
(19, 'Team KK', 'Thomas', 'Muller'),
(19, 'Team KK', 'Robert', 'Lewandowski'),
(19, 'Team KK', 'Serge', 'Gnabry'),
(19, 'Team KK', 'Alphonso', 'Davies'),
(19, 'Team KK', 'David', 'Alaba'),
(19, 'Team KK', 'Lucas', 'Hernandez'),
(19, 'Team KK', 'Niklas', 'Sule'),
-- Match 19 - Team LL
(19, 'Team LL', 'Jan', 'Oblak'),
(19, 'Team LL', 'Koke', 'Resurreccion'),
(19, 'Team LL', 'Saul', 'Niguez'),
(19, 'Team LL', 'Marcos', 'Llorente'),
(19, 'Team LL', 'Luis', 'Suarez'),
(19, 'Team LL', 'Joao', 'Felix'),
(19, 'Team LL', 'Angel', 'Correa'),
(19, 'Team LL', 'Yannick', 'Carrasco'),
(19, 'Team LL', 'Stefan', 'Savic'),
(19, 'Team LL', 'Jose', 'Gimenez'),

-- Match 20 - Team MM
(20, 'Team MM', 'Sergio', 'Aguero'),
(20, 'Team MM', 'Gabriel', 'Jesus'),
(20, 'Team MM', 'Kevin', 'De Bruyne'),
(20, 'Team MM', 'Bernardo', 'Silva'),
(20, 'Team MM', 'Raheem', 'Sterling'),
(20, 'Team MM', 'Riyad', 'Mahrez'),
(20, 'Team MM', 'Ilkay', 'Gundogan'),
(20, 'Team MM', 'Phil', 'Foden'),
(20, 'Team MM', 'Fernandinho', 'Luis'),
(20, 'Team MM', 'Aymeric', 'Laporte'),
-- Match 20 - Team NN
(20, 'Team NN', 'Thibaut', 'Courtois'),
(20, 'Team NN', 'Sergio', 'Ramos'),
(20, 'Team NN', 'Raphael', 'Varane'),
(20, 'Team NN', 'Marcelo', 'Vieira'),
(20, 'Team NN', 'Toni', 'Kroos'),
(20, 'Team NN', 'Luka', 'Modric'),
(20, 'Team NN', 'Casemiro', 'Carlos'),
(20, 'Team NN', 'Eden', 'Hazard'),
(20, 'Team NN', 'Karim', 'Benzema'),
(20, 'Team NN', 'Vinicius', 'Junior'),

-- Match 21 - Team OO
(21, 'Team OO', 'Alisson', 'Becker'),
(21, 'Team OO', 'Virgil', 'Van Dijk'),
(21, 'Team OO', 'Trent', 'Alexander-Arnold'),
(21, 'Team OO', 'Andy', 'Robertson'),
(21, 'Team OO', 'Fabinho', 'Tavares'),
(21, 'Team OO', 'Jordan', 'Henderson'),
(21, 'Team OO', 'Georginio', 'Wijnaldum'),
(21, 'Team OO', 'Sadio', 'Mane'),
(21, 'Team OO', 'Roberto', 'Firmino'),
(21, 'Team OO', 'Mohamed', 'Salah'),
-- Match 21 - Team PP
(21, 'Team PP', 'Gianluigi', 'Donnarumma'),
(21, 'Team PP', 'Leonardo', 'Bonucci'),
(21, 'Team PP', 'Giorgio', 'Chiellini'),
(21, 'Team PP', 'Alessandro', 'Florenzi'),
(21, 'Team PP', 'Marco', 'Verratti'),
(21, 'Team PP', 'Jorginho', 'Frello'),
(21, 'Team PP', 'Nicolo', 'Barella'),
(21, 'Team PP', 'Federico', 'Chiesa'),
(21, 'Team PP', 'Lorenzo', 'Insigne'),
(21, 'Team PP', 'Ciro', 'Immobile'),

-- Match 22 - Team QQ
(22, 'Team QQ', 'Kasper', 'Schmeichel'),
(22, 'Team QQ', 'Simon', 'Kjaer'),
(22, 'Team QQ', 'Andreas', 'Christensen'),
(22, 'Team QQ', 'Thomas', 'Delaney'),
(22, 'Team QQ', 'Pierre-Emile', 'Hojbjerg'),
(22, 'Team QQ', 'Christian', 'Eriksen'),
(22, 'Team QQ', 'Yussuf', 'Poulsen'),
(22, 'Team QQ', 'Martin', 'Braithwaite'),
(22, 'Team QQ', 'Jonas', 'Wind'),
(22, 'Team QQ', 'Mikkel', 'Damsgaard'),
-- Match 22 - Team RR
(22, 'Team RR', 'Hugo', 'Lloris'),
(22, 'Team RR', 'Raphael', 'Varane'),
(22, 'Team RR', 'Benjamin', 'Pavard'),
(22, 'Team RR', 'Presnel', 'Kimpembe'),
(22, 'Team RR', 'Paul', 'Pogba'),
(22, 'Team RR', 'N\'Golo', 'Kante'),
(22, 'Team RR', 'Adrien', 'Rabiot'),
(22, 'Team RR', 'Antoine', 'Griezmann'),
(22, 'Team RR', 'Kylian', 'Mbappe'),
(22, 'Team RR', 'Karim', 'Benzema'),

-- Match 23 - Team SS
(23, 'Team SS', 'David', 'De Gea'),
(23, 'Team SS', 'Harry', 'Maguire'),
(23, 'Team SS', 'Luke', 'Shaw'),
(23, 'Team SS', 'Bruno', 'Fernandes'),
(23, 'Team SS', 'Paul', 'Pogba'),
(23, 'Team SS', 'Scott', 'McTominay'),
(23, 'Team SS', 'Fred', 'Rodrigues'),
(23, 'Team SS', 'Marcus', 'Rashford'),
(23, 'Team SS', 'Mason', 'Greenwood'),
(23, 'Team SS', 'Edinson', 'Cavani'),
-- Match 23 - Team TT
(23, 'Team TT', 'Edouard', 'Mendy'),
(23, 'Team TT', 'Thiago', 'Silva'),
(23, 'Team TT', 'Antonio', 'Rudiger'),
(23, 'Team TT', 'N\'Golo', 'Kante'),
(23, 'Team TT', 'Mateo', 'Kovacic'),
(23, 'Team TT', 'Mason', 'Mount'),
(23, 'Team TT', 'Jorginho', 'Frello'),
(23, 'Team TT', 'Timo', 'Werner'),
(23, 'Team TT', 'Kai', 'Havertz'),
(23, 'Team TT', 'Christian', 'Pulisic');
INSERT INTO team_odds (match_id, team, odds) VALUES
-- Match 1
(1, 'Team A', 1.5),
(1, 'Team B', 2.5),
-- Match 2
(2, 'Team C', 1.8),
(2, 'Team D', 2.2),
-- Match 3
(3, 'Team E', 1.4),
(3, 'Team F', 3.0),
-- Match 4
(4, 'Team G', 1.6),
(4, 'Team H', 2.4),
-- Match 5
(5, 'Team I', 1.7),
(5, 'Team J', 2.3),
-- Match 6
(6, 'Team K', 1.9),
(6, 'Team L', 2.1),
-- Match 7
(7, 'Team M', 1.8),
(7, 'Team N', 2.2),
-- Match 8
(8, 'Team O', 1.5),
(8, 'Team P', 2.5),
-- Match 9
(9, 'Team Q', 1.6),
(9, 'Team R', 2.4),
-- Match 10
(10, 'Team S', 1.7),
(10, 'Team T', 2.3),
-- Match 11
(11, 'Team U', 1.9),
(11, 'Team V', 2.1),
-- Match 12
(12, 'Team W', 1.6),
(12, 'Team X', 2.4),
-- Match 13
(13, 'Team Y', 1.8),
(13, 'Team Z', 2.2),
-- Match 14
(14, 'Team AA', 1.7),
(14, 'Team BB', 2.3),
-- Match 15
(15, 'Team CC', 1.5),
(15, 'Team DD', 2.5),
-- Match 16
(16, 'Team EE', 1.9),
(16, 'Team FF', 2.1),
-- Match 17
(17, 'Team GG', 1.8),
(17, 'Team HH', 2.2),
-- Match 18
(18, 'Team II', 1.6),
(18, 'Team JJ', 2.4),
-- Match 19
(19, 'Team KK', 1.5),
(19, 'Team LL', 2.5),
-- Match 20
(20, 'Team MM', 1.7),
(20, 'Team NN', 2.3),
-- Match 21
(21, 'Team OO', 1.9),
(21, 'Team PP', 2.1),
-- Match 22
(22, 'Team QQ', 1.6),
(22, 'Team RR', 2.4),
-- Match 23
(23, 'Team SS', 1.8),
(23, 'Team TT', 2.2);

INSERT INTO comments (match_id, commentator, comment, score) VALUES
-- Match 1
(1, 'Commentateur A', 'Un match serré jusqu\'à présent.', '0-0'),
(1, 'Commentateur B', 'L\'équipe A domine le terrain.', '1-0'),
-- Match 2
(2, 'Commentateur C', 'Une superbe passe de l\'équipe C.', '1-1'),
(2, 'Commentateur D', 'L\'équipe D prend l\'avantage.', '2-1'),
-- Match 3
(3, 'Commentateur E', 'L\'équipe E semble bien organisée.', '0-0'),
(3, 'Commentateur F', 'L\'équipe F manque de coordination.', '0-1'),
-- Match 4
(4, 'Commentateur G', 'Team G montre une excellente défense.', '0-0'),
(4, 'Commentateur H', 'But incroyable par Team H!', '0-1'),
-- Match 5
(5, 'Commentateur I', 'Team I joue très offensivement.', '1-0'),
(5, 'Commentateur J', 'Team J répond avec une contre-attaque.', '1-1'),
-- Match 6
(6, 'Commentateur K', 'Match équilibré jusqu\'à présent.', '0-0'),
(6, 'Commentateur L', 'Team L marque juste avant la mi-temps.', '0-1'),
-- Match 7
(7, 'Commentateur M', 'Team M a le contrôle du ballon.', '1-0'),
(7, 'Commentateur N', 'Égalisation impressionnante de Team N.', '1-1'),
-- Match 8
(8, 'Commentateur O', 'Match très tactique et stratégique.', '0-0'),
(8, 'Commentateur P', 'But sur coup franc par Team P.', '0-1'),
-- Match 9
(9, 'Commentateur Q', 'Team Q a une défense solide.', '0-0'),
(9, 'Commentateur R', 'Team R profite d\'une erreur défensive.', '0-1'),
-- Match 10
(10, 'Commentateur S', 'Team S prend l\'avantage rapidement.', '1-0'),
(10, 'Commentateur T', 'Team T riposte avec une belle attaque.', '1-1'),
-- Match 11
(11, 'Commentateur U', 'Match intense et disputé.', '0-0'),
(11, 'Commentateur V', 'But décisif de Team V en fin de match.', '0-1'),
-- Match 12
(12, 'Commentateur W', 'Team W utilise bien les ailes.', '1-0'),
(12, 'Commentateur X', 'Team X répond par un but spectaculaire.', '1-1'),
-- Match 13
(13, 'Commentateur Y', 'Team Y contrôle le milieu de terrain.', '0-0'),
(13, 'Commentateur Z', 'Team Z marque sur un corner.', '0-1'),
-- Match 14
(14, 'Commentateur AA', 'Team AA fait pression haut sur le terrain.', '1-0'),
(14, 'Commentateur BB', 'Réponse immédiate de Team BB.', '1-1'),
-- Match 15
(15, 'Commentateur CC', 'Team CC prend les devants.', '1-0'),
(15, 'Commentateur DD', 'Team DD égalise avec un tir de loin.', '1-1'),
-- Match 16
(16, 'Commentateur EE', 'Team EE joue très bien collectivement.', '1-0'),
(16, 'Commentateur FF', 'Team FF marque contre le cours du jeu.', '1-1'),
-- Match 17
(17, 'Commentateur GG', 'Team GG domine la possession.', '1-0'),
(17, 'Commentateur HH', 'Team HH égalise sur une contre-attaque.', '1-1'),
-- Match 18
(18, 'Commentateur II', 'Team II a une solide défense.', '0-0'),
(18, 'Commentateur JJ', 'Team JJ marque sur une erreur défensive.', '0-1'),
-- Match 19
(19, 'Commentateur KK', 'Team KK commence fort.', '1-0'),
(19, 'Commentateur LL', 'Team LL égalise juste avant la mi-temps.', '1-1'),
-- Match 20
(20, 'Commentateur MM', 'Match très serré.', '0-0'),
(20, 'Commentateur NN', 'But tardif de Team NN.', '0-1'),
-- Match 21
(21, 'Commentateur OO', 'Team OO montre une bonne organisation.', '1-0'),
(21, 'Commentateur PP', 'Team PP égalise avec un beau tir.', '1-1'),
-- Match 22
(22, 'Commentateur QQ', 'Team QQ défend bien.', '0-0'),
(22, 'Commentateur RR', 'Team RR prend l\'avantage sur une erreur.', '0-1'),
-- Match 23
(23, 'Commentateur SS', 'Team SS marque rapidement.', '1-0'),
(23, 'Commentateur TT', 'Team TT égalise sur penalty.', '1-1');

-- Méteo le jour des matchs
UPDATE matches SET weather = 'Ensoleillé' WHERE id = 1;
UPDATE matches SET weather = 'Pluvieux' WHERE id = 2;
UPDATE matches SET weather = 'Nuageux' WHERE id = 3;
UPDATE matches SET weather = 'Venté' WHERE id = 4;
UPDATE matches SET weather = 'Orageux' WHERE id = 5;
UPDATE matches SET weather = 'Brumeux' WHERE id = 6;
UPDATE matches SET weather = 'Partiellement nuageux' WHERE id = 7;
UPDATE matches SET weather = 'Averses' WHERE id = 8;
UPDATE matches SET weather = 'Ensoleillé' WHERE id = 9;
UPDATE matches SET weather = 'Pluvieux' WHERE id = 10;
UPDATE matches SET weather = 'Nuageux' WHERE id = 11;
UPDATE matches SET weather = 'Venté' WHERE id = 12;
UPDATE matches SET weather = 'Orageux' WHERE id = 13;
UPDATE matches SET weather = 'Brumeux' WHERE id = 14;
UPDATE matches SET weather = 'Partiellement nuageux' WHERE id = 15;
UPDATE matches SET weather = 'Averses' WHERE id = 16;
UPDATE matches SET weather = 'Ensoleillé' WHERE id = 17;
UPDATE matches SET weather = 'Pluvieux' WHERE id = 18;
UPDATE matches SET weather = 'Nuageux' WHERE id = 19;
UPDATE matches SET weather = 'Venté' WHERE id = 20;
UPDATE matches SET weather = 'Orageux' WHERE id = 21;
UPDATE matches SET weather = 'Brumeux' WHERE id = 22;
UPDATE matches SET weather = 'Partiellement nuageux' WHERE id = 23;
