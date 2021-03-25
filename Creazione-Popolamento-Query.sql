CREATE TABLE Utente(
	Username varchar(30),
	Password varchar(16),
	eMail varchar(30),
	Nome varchar(30),
	Cognome varchar(30),
	Sesso enum('M', 'F'),
	DataDiNascita date,
	PRIMARY KEY(Username)
);

CREATE TABLE UtenteCliente(
	Username varchar(30),
	MetodoPagamento enum('CartaDiCredito', 'CartaPrepagata'),
	CodiceCarta varchar(16),
	Nazione varchar(20),
	Via varchar(50),
	NumeroCivico int,
	CAP int(5),
	Provincia varchar(20),
	PRIMARY KEY(Username),
	FOREIGN KEY(Username) REFERENCES Utente(Username) ON DELETE CASCADE ON UPDATE CASCADE  
);

CREATE TABLE Giocatore(
	Codice int AUTO_INCREMENT,
	Nome varchar(30),
	Cognome varchar(30),
	Nazionalita varchar(30),
	DataDiNascita date,
	Squadra varchar(30),
	Ruolo enum('Portiere', 'Difensore', 'Centrocampista', 'Attaccante'),
	GoalFatti int,
	MediaVoto int,
	MediaFantaVoto int,
	PRIMARY KEY(Codice)
);

CREATE TABLE Squadra(
	Nome varchar(30),
	Allenatore varchar(30),
	Stadio varchar(20),
	AnnoFondazione int(4),
	Capitano int,
	GoalFatti int,
	GoalSubiti int,
	Vittorie int,
	Sconfitte int, 
	Pareggi int,
	Punti int,
	PRIMARY KEY (Nome),
	FOREIGN KEY (Capitano) REFERENCES Giocatore(Codice) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE Giocatore ADD CONSTRAINT fk_Squadra FOREIGN KEY (Squadra) REFERENCES Squadra(Nome);

CREATE TABLE Partita(
	Codice int AUTO_INCREMENT,
	Stadio varchar(20),
	DataOra timestamp,
	GoalSquadraCasa int DEFAULT 0,
	GoalSquadraOspite int DEFAULT 0,
	Passata boolean,
	SquadraCasa varchar(30),
	SquadraOspite varchar(30),
	PRIMARY KEY (Codice),
	FOREIGN KEY (SquadraCasa) REFERENCES Squadra(Nome) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (SquadraOspite) REFERENCES Squadra(Nome) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Biglietto(
	Codice int AUTO_INCREMENT,
	Cliente varchar(30),
	CodPartita int,
	NumAnello int,
	NumFila int,
	NumPosto int,
	Prezzo decimal,
	UNIQUE(CodPartita, NumAnello, NumFila, NumPosto),
	PRIMARY KEY(Codice),
	FOREIGN KEY(Cliente) REFERENCES UtenteCliente (Username) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(CodPartita) REFERENCES Partita (Codice) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE F_Lega(
	Codice int AUTO_INCREMENT,
	NumeroPartecipanti int DEFAULT 0,
	Nome varchar(20),
	Admin varchar(30),
	DataCreazione date,
	PRIMARY KEY(Codice),
	FOREIGN KEY(Admin) REFERENCES Utente(Username) ON DELETE CASCADE ON UPDATE CASCADE  
);

CREATE TABLE F_Fantasquadra(
	Codice int AUTO_INCREMENT,
	Utente varchar(30),
	Nome varchar(30),
	CodLega int,
	Punteggio int,
	PRIMARY KEY (Codice),
	FOREIGN KEY(CodLega) REFERENCES F_Lega(Codice) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(Utente) REFERENCES Utente(Username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE F_Asta(
	CodLega int,
	Giocatore int,
	CodFantasquadra int,
	Prezzo int,
	PRIMARY KEY (CodLega, Giocatore),
	FOREIGN KEY (CodLega) REFERENCES F_Lega(Codice) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Giocatore) REFERENCES Giocatore(Codice) ON DELETE CASCADE ON UPDATE CASCADE, 
	FOREIGN KEY (CodFantasquadra) REFERENCES F_Fantasquadra(Codice) ON DELETE CASCADE ON UPDATE CASCADE
);


INSERT INTO Utente (Username, Password, eMail, Nome, Cognome, Sesso, DataDiNascita)VALUES
('Ale.Pugliesi','password123','ale.pugliesi@gmail.com','Alessandro','Pugliesi','M','1973-01-26'),
('Carla.Costa','password123','carla.costa@gmail.com','Carla','Costa','F','1987-04-16'),
('Ros.Trevisan','password123','rosario.trevisan@gmail.com','Rosario','Trevisan','M','1981-03-11'),
('Lui.Ferri','password123','luigi.ferri@gmail.com','Luigi','Ferri','M','1992-11-03'),
('Bianca.Siciliano','password123','bianca.siciliano@gmail.com','Bianca','Siciliano','F','1967-04-19'),
('Ale.Lucchese','password123','ale.lucchese@gmail.com','Alessio','Lucchese','M','1990-10-29'),
('Dome.Conti','password123','dome.conti@gmail.com','Domenica','Conti','F','1979-04-28'),
('Luca.Esposito','password123','luca.esposito@gmail.com','Luca','Esposito','M','1993-02-04'),
('Anna.Rizzo','password123','anna.rizzo@gmail.com','Anna','Rizzo','F','1989-10-01'),
('Giuse.Bianchi','password123','giuse.bianchi@gmail.com','Giuseppe','Bianchi','M','1985-06-26'),
('Giu.Repezza','password123','giu.repezza@gmail.com','Giulio','Repezza','M','1960-10-18'),
('Rodrigo.Grimaccia','password123','rodrigo.grimaccia@gmail.com','Rodrigo','Grimaccia','M','1993-10-06'),
('Ali.Ricciardelli','password123','ali.ricciardelli@gmail.com','Alice','Ricciardelli','F','1972-03-19'),
('Andrea.Peragina','password123','andrea.peragina@gmail.com','Andrea','Peragina','M','1971-01-27'),
('Leo.Bisognini','password123','leo.bisognini@gmail.com','Leonardo','Bisognini','M','1977-02-24'),
('Giacomo.Frazzarin','password123','giacomo.frazzarin@gmail.com','Giacomo','Frazzarin','M','1998-11-07'),
('Silvio.Botros','password123','silvio.botros@gmail.com','Silvio','Botros','M','1974-08-04'),
('Cri.Trincilla','password123','cri.trincilla@gmail.com','Cristina','Trincilla','F','1999-07-13'),
('Allegra.Dolleatti','password123','allegra.dolleatti@gmail.com','Allegra','Dolleatti','F','1995-10-01'),
('Jose.Ghidara','password123','jose.ghidara@gmail.com','Jose','Ghidara','M','1989-04-20'),
('Eva.Riali','password123','eva.riali@gmail.com','Eva','Riali','F','1984-12-13');


INSERT INTO UtenteCliente (Username, MetodoPagamento, CodiceCarta, Nazione, Via, NumeroCivico, CAP, Provincia)VALUES
('Ale.Pugliesi','CartaDiCredito','5108132787846511','Italia','De Varda',45,38017,'TN'),
('Carla.Costa','CartaPrepagata','5108138462586447','Italia','Maranesi',6,63900,'FM'),
('Lui.Ferri','CartaDiCredito','5108137732775251','Italia','Ponte Albano',8,40037,'BO'),
('Ale.Lucchese','CartaDiCredito','5108138733155665','Italia','Secchia',12,24030,'BG'),
('Ros.Trevisan','CartaDiCredito','5108134337161554','Italia','Vittorio Veneto',11,59100,'PO'),
('Luca.Esposito','CartaPrepagata','5108137752616156','Italia','Papa Celestion V',58,86038,'CB'),
('Anna.Rizzo','CartaDiCredito',' 5108134666657423','Italia','Frassino',17,53018,'SI'),
('Giuse.Bianchi','CartaDiCredito','5108136622365134','Italia','Filippo Grandi',26,29122,'PC');


INSERT INTO Squadra (Nome, Allenatore, Stadio, AnnoFondazione, GoalSubiti, Vittorie, Sconfitte, Pareggi, Punti) VALUES
('Juventus','Sarri','Allianz',1897,17,13,1,3,42),
('Atalanta','Gasperini','Gewiss',1907,25,9,4,4,31),
('Roma','Fonesca','Olimpico',1927,17,10,2,5,35),
('Milan','Pioli','San Siro',1899,24,6,8,3,21),
('Inter','Conte','San Siro',1908,14,13,1,3,42),
('Napoli','Gattuso','San Paolo',1926,22,6,5,6,24),
('Lazio','Inzaghi','Olimpico',1900,16,11,2,3,36),
('Fiorentina','Montella','Artemio Franchi',1926,28,4,8,5,17),
('Torino','Mazzarri','Grande Torino',1906,26,6,8,3,21),
('Cagliari','Maran','Sardegna Arena',1920,23,8,4,5,29);


INSERT INTO Giocatore (Nome, Cognome, Nazionalita, DataDiNascita, Squadra, Ruolo, GoalFatti, MediaVoto, MediaFantavoto) VALUES
('Cristiano','Ronaldo','Portogallo','1985-02-05','Juventus','Attaccante',5,6.5,8.9),
('Blaise','Matuidi','Francia','1987-04-09','Juventus','Centrocampista',3,6,6.7),
('Leonardo','Bonucci','Italia','1987-05-01','Juventus','Difensore',1,5.9,6.5),
('Gianluigi','Buffon','Italia','1978-01-28','Juventus','Portiere',0,6,5.2),
('Pau','Lopez','Spagna','1994-12-13','Roma','Portiere',0,6.5,5.7),
('Alessandro','Florenzi','Italia','1991-03-11','Roma','Difensore',2,5.8,6.2),
('Jordan','Veretout','Francia','1993-03-01','Roma','Centrocampista',0,6,7.2),
('Diego','Perotti','Italia','1988-07-26','Roma','Attaccante',4,6.5,8.1),
('Pierluigi','Gollini','Italia','1995-03-18','Atalanta','Portiere',0,5.8,5),
('Timothy','Castagne','Belgio','1995-12-05','Atalanta','Difensore',3,6.5,7.1),
('Dario','Gomez','Argentina','1988-02-15','Atalanta','Centrocampista',5,6.3,8.6),
('Luis','Muriel','Colombia','1991-04-16','Atalanta','Attaccante',8,6.9,8.4),
('Samir','Handanovic','Slovenia','1984-07-14','Inter','Portiere',0,6.5,6),
('Milan','Skriniar','Slovacchia','1995-02-11','Inter','Difensore',1,7,6.8),
('Borja','Valero','Spagna','1985-01-12','Inter','Centrocampista',2,5.6,4.9),
('Romelu','Lukaku','Belgio','1993-05-13','Inter','Attaccante',7,6.5,9.4),
('Gianluigi','Donnarumma','Italia','1999-02-25','Milan','Portiere',0,5.8,5.1),
('Alessio','Romagnoli','Italia','1995-01-12','Milan','Difensore',0,6.2,6),
('Samu','Castillejo','Spagna','1995-01-18','Milan','Centrocampista',3,5.5,6.4),
('Rafael','Leao','Portogallo','1999-06-10','Milan','Attaccante',6,6.3,7.8),
('Alex','Meret','Italia','1997-03-22','Napoli','Portiere',0,6.4,5.8),
('Giovanni','Di Lorenzo','Italia','1993-08-04','Napoli','Difensore',2,6.6,6.3),
('Jose','Callejon','Spagna','1987-02-11','Napoli','Centrocampista',6,5.9,6.5),
('Lorenzo','Insigne','Italia','1991-06-04','Napoli','Attaccante',10,6.1,7.2),
('Thomas','Strakosha','Albania','1995-03-19','Lazio','Portiere',0,6.4,6),
('Francesco','Acerbi','Italia','1988-02-10','Lazio','Difensore',0,6.4,6.5),
('Luis','Alberto','Spagna','1992-09-28','Lazio','Centrocampista',2,6.4,7.9),
('Ciro','Immobile','Italia','1990-02-20','Lazio','Attaccante',9,6.9,10.2),
('Bartlomiej','Dragowski','Polonia','1997-08-19','Fiorentina','Portiere',0,6,4.6),
('Nikola','Milenkovic','Serbia','1997-10-12','Fiorentina','Difensore',1,6.1,6.5),
('Gaetano','Castrovilli','Italia','1997-02-17','Fiorentina','Centrocampista',3,6.5,7),
('Dusan','Vlahovic','Serbia','2000-01-28','Fiorentina','Attaccante',8,6,6.6),
('Salvatore','Sirigu','Italia','1987-01-12','Torino','Portiere',0,6.5,5.1),
('Armando','Izzo','Italia','1992-03-02','Torino','Difensore',0,6,6),
('Sasa','Lukic','Serbia','1996-08-13','Torino','Centrocampista',4,5.7,5.7),
('Andrea','Belotti','Italia','1993-12-20','Torino','Attaccante',9,6.3,7.8),
('Alex','Rafael','Brasile','1982-03-03','Cagliari','Portiere',0,6,4.2),
('Fabio','Pisacane','Italia','1986-01-28','Cagliari','Difensore',0,5.8,5.9),
('Radja','Nainggolan','Belgio','1988-05-04','Cagliari','Centrocampista',4,6.6,7.7),
('Joao','Pedro','Brasile','1992-03-09','Cagliari','Attaccante',4,6.5,8.6);


UPDATE Squadra
SET Capitano=4, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Juventus')
WHERE Nome="Juventus";

UPDATE Squadra
SET Capitano=11, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Atalanta')
WHERE Nome="Atalanta";

UPDATE Squadra
SET Capitano=6, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Roma')
WHERE Nome="Roma";

UPDATE Squadra
SET Capitano=17, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Milan')
WHERE Nome="Milan";

UPDATE Squadra
SET Capitano=13, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Inter')
WHERE Nome="Inter";

UPDATE Squadra
SET Capitano=24, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Napoli')
WHERE Nome="Napoli";

UPDATE Squadra
SET Capitano=28, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Lazio')
WHERE Nome="Lazio";

UPDATE Squadra
SET Capitano=31, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Fiorentina')
WHERE Nome="Fiorentina";

UPDATE Squadra
SET Capitano=36, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Torino')
WHERE Nome="Torino";

UPDATE Squadra
SET Capitano=39, GoalFatti=(SELECT sum(goalFatti) FROM Giocatore WHERE Squadra='Cagliari')
WHERE Nome="Cagliari";

INSERT INTO Partita (Stadio, DataOra, GoalSquadraCasa, GoalSquadraOspite, Passata, SquadraCasa, SquadraOspite) VALUES
('Allianz','2019-03-12 20:45:00',1,2,true,'Juventus','Inter'),
('San Siro','2019-03-12 21:00:00',3,0,true,'Milan','Lazio'),
('Olimpico','2019-12-28 21:00:00',NULL,NULL,false,'Roma','Cagliari'),
('Gewiss','2019-06-12 20:30:00',1,2,true,'Atalanta','Roma'),
('San Paolo','2019-09-13 21:00:00',3,3,true,'Napoli','Fiorentina'),
('Grande Torino','2019-01-28 12:30:00',1,2,true,'Torino','Inter'),
('San Siro','2019-04-04 13:00:00',2,3,true,'Milan','Inter'),
('Sardegna Arena','2019-10-01',1,1,true,'Cagliari','Atalanta'),
('Artemio Franchi','2020-01-10',NULL,NULL,false,'Fiorentina','Napoli');

INSERT INTO Biglietto (Cliente, CodPartita, NumAnello, NumFila, NumPosto, Prezzo) VALUES
('Ale.Pugliesi',1,4,10,123,50),
('Carla.Costa',1,3,11,127,60),
('Lui.Ferri',2,5,1,150,50),
('Ale.Lucchese',4,4,15,43,35),
('Ros.Trevisan',5,3,12,76,70),
('Luca.Esposito',7,1,4,106,45),
('Giuse.Bianchi',7,5,7,59,50),
('Giuse.Bianchi',8,6,8,175,60),
('Luca.Esposito',8,4,13,112,45),
('Giuse.Bianchi',5,3,3,78,40);

INSERT INTO F_Lega (Nome, Admin, DataCreazione) VALUES
('Fantaboom','Ale.Pugliesi','2019-07-23'),
('FantaSerieA','Carla.Costa','2019-08-12'),
('Ultimate','Ros.Trevisan','2019-09-01'),
('I master','Lui.Ferri','2019-08-20'),
('Gli incapaci','Bianca.Siciliano','2019-06-30'),
('Fantaboom','Ale.Lucchese','2019-07-11'),
('LegaFanta','Dome.Conti','2019-09-10'),
('Le bestie','Luca.Esposito','2019-09-02'),
('LegaUniPD','Anna.Rizzo','2019-07-27'),
('Fantamici','Giuse.Bianchi','2019-08-17');

INSERT INTO F_Fantasquadra (Utente, Nome, CodLega, Punteggio) VALUES
('Ale.Pugliesi','Pro Secco',1,642),
('Ros.Trevisan','All Scars',3,540),
('Ale.Lucchese','Livercool',6,1040),
('Giu.Repezza','Birrareal',8,961),
('Anna.Rizzo','Fun Cool',9,933),
('Luca.Esposito','Atletico',8,1054),
('Rodrigo.Grimaccia','Liverpolli',9,1075),
('Lui.Ferri','Livercool',4,790),
('Carla.Costa','Manzoteam',2,810),
('Ali.Ricciardelli','Patetico Madrid',2,845),
('Andrea.Peragina','Real Mente',1,707),
('Eva.Riali','Sarrizza',4,851),
('Bianca.Siciliano','Sarrizza',5,980),
('Dome.Conti','Atletico',7,860),
('Allegra.Dolleatti','Amaro Luciano',5,1090),
('Giuse.Bianchi','Cheassea',10,989),
('Giacomo.Frazzarin','Chessea',9,1104),
('Jose.Ghidara','Dinamo',10,870),
('Silvio.Botros','All Scars',10,915);


UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=1)
WHERE Codice=1;

UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=2)
WHERE Codice=2;

UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=3)
WHERE Codice=3;

UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=4)
WHERE Codice=4;

UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=5)
WHERE Codice=5;

UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=6)
WHERE Codice=6;

UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=7)
WHERE Codice=7;

UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=8)
WHERE Codice=8;

UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=9)
WHERE Codice=9;

UPDATE F_Lega
SET NumeroPartecipanti=(SELECT count(*) FROM F_Fantasquadra WHERE CodLega=10)
WHERE Codice=10;

INSERT INTO F_Asta (CodLega, Giocatore, CodFantasquadra, Prezzo)VALUES
(1,2,1,100),     
(1,7,11,90),
(2,2,10,80),
(2,8,9,69),
(3,15,2,61),
(4,2,12,70),
(4,1,8,83),
(5,15,13,59),
(5,14,15,40),
(6,3,3,23),
(7,3,14,64),
(8,17,4,82),
(8,16,6,42),
(9,9,5,68),
(9,19,17,95),
(9,23,7,101),
(10,4,16,46),
(10,10,18,64),
(10,12,19,55);




SELECT UtenteCliente.Username, Nazione, Provincia, CAP, Via, NumeroCivico
FROM Biglietto, UtenteCliente
WHERE Biglietto.Cliente=UtenteCliente.Username AND Biglietto.CodPartita IN (
	SELECT Partita.Codice
	FROM Partita
	WHERE SquadraCasa="Juventus" OR SquadraOspite="Juventus"
);




SELECT G.Nome, G.Cognome, G.GoalFatti
FROM Giocatore G
WHERE NOT EXISTS (SELECT *
          		          FROM Giocatore G1
          	                        WHERE G.GoalFatti = G1.GoalFatti AND G.Codice <> G1.Codice
          	                        GROUP BY G1.GoalFatti)
AND G.GoalFatti > 4 AND (G.Codice) IN (SELECT Giocatore
                                 	   FROM F_Asta)
ORDER BY G.GoalFatti;




SELECT Utente 
FROM F_Fantasquadra JOIN F_Asta ON F_Fantasquadra.Codice=F_Asta.CodFantasquadra
WHERE F_Asta.Giocatore = (
	SELECT Codice 
	FROM Giocatore 
	WHERE GoalFatti = (
		SELECT max(GoalFatti) 
		FROM Giocatore 
		WHERE Codice IN (
			SELECT Giocatore 
			FROM F_Asta
		)
	) 
	AND Codice IN (
		SELECT Giocatore 
		FROM F_Asta
	)
);




SELECT IF(GoalSquadraCasa>GoalSquadraOspite, SquadraCasa, IF(GoalSquadraOspite>GoalSquadraCasa, SquadraOspite, "Pareggio")) AS SquadraVincitrice FROM Partita 
WHERE Codice IN (
	SELECT CodPartita
	FROM Biglietto
	WHERE Cliente = (
		SELECT Utente
		FROM F_Fantasquadra
		WHERE Punteggio = (
			SELECT max(Punteggio)
			FROM F_Fantasquadra 
			WHERE CodLega IN (
				SELECT Codice 
				FROM F_Lega
				WHERE Nome="Fantamici"
			)
		)
	)
);




SELECT SquadraCasa, GoalSquadraCasa, GoalSquadraOspite, SquadraOspite
FROM Partita
WHERE (SquadraCasa IN (
	SELECT Giocatore.Squadra
	FROM (Giocatore JOIN F_Asta ON Giocatore.Codice = F_Asta.Giocatore) JOIN F_Fantasquadra ON F_Asta.CodFantasquadra = F_Fantasquadra.Codice
	WHERE F_Fantasquadra.Utente="Ale.Pugliesi") AND GoalSquadraCasa>GoalSquadraOspite) OR 
	(SquadraOspite IN (
		SELECT Giocatore.Squadra
		FROM (Giocatore JOIN F_Asta ON Giocatore.Codice = F_Asta.Giocatore) JOIN F_Fantasquadra ON F_Asta.CodFantasquadra = F_Fantasquadra.Codice
		WHERE F_Fantasquadra.Utente="Ale.Pugliesi") AND GoalSquadraCasa<GoalSquadraOspite);




DROP VIEW IF EXISTS
   	Users;
CREATE VIEW Users AS
SELECT Cliente 
	FROM (SELECT Biglietto.Codice, Cliente, Biglietto.CodPartita
		  FROM Biglietto JOIN Partita ON Biglietto.CodPartita=Partita.Codice
		  WHERE Partita.GoalSquadraCasa=Partita.GoalSquadraOspite) BigliettiPartitePareggiate
   GROUP BY Cliente HAVING (count(*)>1);

   
SELECT Utente, Punteggio, @riga := IF(@precedente = CodLega, @riga + 1, 1) AS Posizione, @precedente := CodLega AS CodLega
FROM F_Fantasquadra, (SELECT @riga := 0) x, (SELECT @precedente := '') y
WHERE CodLega IN (SELECT Codlega
				  FROM F_Fantasquadra
				  WHERE Utente IN (SELECT * FROM Users)
)
ORDER BY CodLega, Punteggio DESC; 




DROP VIEW IF EXISTS
   	 MediaSquadre;    
CREATE VIEW MediaSquadre AS
   	 SELECT Squadra, AVG(MediaFantaVoto) AS MediaGiocatori
   	 FROM Giocatore
   	 GROUP BY Squadra;
DROP VIEW IF EXISTS
   	 TopScorer;
CREATE VIEW TopScorer AS
   	 SELECT Squadra, MAX(GoalFatti) AS MigliorMarcatore
   	 FROM Giocatore
   	 GROUP BY Squadra;
SELECT T.Squadra, MediaGiocatori, Nome, Cognome, MigliorMarcatore
FROM Giocatore G JOIN TopScorer T ON (G.GoalFatti = T.MigliorMarcatore) 
AND (G.Squadra = T.Squadra) JOIN MediaSquadre M ON T.Squadra = M.Squadra
WHERE MediaGiocatori >= 7
ORDER BY MediaGiocatori DESC;


CREATE INDEX utenti ON Utente (Username);


CREATE INDEX biglietti ON Biglietto (Codice);


CREATE INDEX aste ON F_Asta (CodiceLega, CodiceGiocatore);