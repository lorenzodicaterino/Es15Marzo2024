DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Showtime;
DROP TABLE IF EXISTS Movie;
DROP TABLE IF EXISTS Theater;
DROP TABLE IF EXISTS Cinema;

CREATE TABLE Cinema (
CinemaID INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Address VARCHAR(255) NOT NULL,
Phone VARCHAR(20)
);

CREATE TABLE Theater (
TheaterID INT PRIMARY KEY,
CinemaID INT,
Name VARCHAR(50) NOT NULL,
Capacity INT NOT NULL,
ScreenType VARCHAR(50),
FOREIGN KEY (CinemaID) REFERENCES Cinema(CinemaID)
);

CREATE TABLE Movie (
MovieID INT PRIMARY KEY,
Title VARCHAR(255) NOT NULL,
Director VARCHAR(100),
ReleaseDate DATE,
DurationMinutes INT,
Rating VARCHAR(5)
);

CREATE TABLE Showtime (
ShowtimeID INT PRIMARY KEY,
MovieID INT,
TheaterID INT,
ShowDateTime DATETIME NOT NULL,
Price DECIMAL(5,2) NOT NULL,
FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
FOREIGN KEY (TheaterID) REFERENCES Theater(TheaterID)
);

CREATE TABLE Customer (
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100),
PhoneNumber VARCHAR(20)
);

CREATE TABLE Ticket (
TicketID INT PRIMARY KEY,
ShowtimeID INT,
SeatNumber VARCHAR(10) NOT NULL,
PurchasedDateTime DATETIME NOT NULL,
CustomerID INT,
FOREIGN KEY (ShowtimeID) REFERENCES Showtime(ShowtimeID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Review (
ReviewID INT PRIMARY KEY,
MovieID INT,
CustomerID INT,
ReviewText TEXT,
Rating INT CHECK (Rating >= 1 AND Rating <= 5),
ReviewDate DATETIME NOT NULL,
FOREIGN KEY (MovieID) REFERENCES Movie(MovieID),
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Employee (
EmployeeID INT PRIMARY KEY,
CinemaID INT,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Position VARCHAR(50),
HireDate DATE,
FOREIGN KEY (CinemaID) REFERENCES Cinema(CinemaID)
);

INSERT INTO Cinema (CinemaID, Name, Address, Phone) VALUES 
(1, 'CineCity', 'Via Roma 123, 00100 Roma', '+39 06 12345678'),
(2, 'MegaPlex', 'Corso Italia 45, 20100 Milano', '+39 02 98765432'),
(3, 'SilverScreen', 'Piazza Garibaldi 1, 40100 Bologna', '+39 051 333444'),
(4, 'StarCinema', 'Via Napoli 87, 80100 Napoli', '+39 081 555666'),
(5, 'CineTopia', 'Via Padova 56, 20100 Milano', '+39 02 12348765');

INSERT INTO Theater (TheaterID, CinemaID, Name, Capacity, ScreenType) VALUES 
(1, 1, 'Sala 1', 150, 'IMAX'),
(2, 1, 'Sala 2', 120, 'Standard'),
(3, 2, 'Room A', 200, '3D'),
(4, 2, 'Room B', 180, 'Standard'),
(5, 3, 'Screen 1', 160, 'IMAX'),
(6, 3, 'Screen 2', 140, 'Standard'),
(7, 4, 'Theater 1', 170, '3D'),
(8, 4, 'Theater 2', 150, 'Standard'),
(9, 5, 'Hall A', 190, 'IMAX'),
(10, 5, 'Hall B', 130, 'Standard');

INSERT INTO Movie (MovieID, Title, Director, ReleaseDate, DurationMinutes, Rating)  VALUES
(1, 'Inception', 'Christopher Nolan', '2010-07-16', 148, 'PG-13'),
(2, 'The Shawshank Redemption', 'Frank Darabont', '1994-10-14', 142, 'R'),
(3, 'The Godfather', 'Francis Ford Coppola', '1972-03-24', 175, 'R'),
(4, 'The Dark Knight', 'Christopher Nolan', '2008-07-18', 152, 'PG-13'),
(5, 'Pulp Fiction', 'Quentin Tarantino', '1994-10-14', 154, 'R'),
(6, 'Schindler''s List', 'Steven Spielberg', '1993-12-15', 195, 'R'),
(7, 'The Lord of the Rings: The Return of the King', 'Peter Jackson', '2003-12-17', 201, 'PG-13'),
(8, 'Forrest Gump', 'Robert Zemeckis', '1994-07-06', 142, 'PG-13'),
(9, 'Fight Club', 'David Fincher', '1999-10-15', 139, 'R'),
(10, 'The Matrix', 'Lana Wachowski, Lilly Wachowski', '1999-03-31', 136, 'R'),
(11, 'Goodfellas', 'Martin Scorsese', '1990-09-19', 146, 'R'), 
(12, 'The Lord of the Rings: The Fellowship of the Ring', 'Peter Jackson', '2001-12-19', 178, 'PG-13'),
(13, 'The Godfather: Part II', 'Francis Ford Coppola', '1974-12-20', 202, 'R'),
(14, 'Inglourious Basterds', 'Quentin Tarantino', '2009-08-21', 153, 'R'),
(15, 'The Silence of the Lambs', 'Jonathan Demme', '1991-02-14', 118, 'R'),
(16, 'The Departed', 'Martin Scorsese', '2006-10-06', 151, 'R'),
(17, 'Gladiator', 'Ridley Scott', '2000-05-05', 155, 'R'),
(18, 'The Green Mile', 'Frank Darabont', '1999-12-10', 189, 'R'),
(19, 'The Dark Knight Rises', 'Christopher Nolan', '2012-07-20', 164, 'PG-13'),
(20, 'The Prestige', 'Christopher Nolan', '2006-10-20', 130, 'PG-13');

INSERT INTO Showtime (ShowtimeID, MovieID, TheaterID, ShowDateTime, Price)  VALUES
(1, 1, 1, '2024-03-2 19:30:00', 10.00),
(2, 2, 2, '2024-03-3 19:30:00', 9.50),
(3, 3, 3, '2024-03-4 19:30:00', 11.00),
(4, 4, 4, '2024-03-5 19:30:00', 10.50),
(5, 5, 5, '2024-03-6 19:30:00', 9.00),
(6, 6, 6, '2024-03-7 19:30:00', 10.00),
(7, 7, 7, '2024-03-8 19:30:00', 11.50),
(8, 8, 8, '2024-03-9 19:30:00', 9.00),
(9, 9, 9, '2024-03-10 19:30:00', 10.50),
(10, 10, 10, '2024-03-11 19:30:00', 11.00),
(11, 11, 1, '2024-03-12 19:30:00', 10.00),
(12, 12, 2, '2024-03-2 19:30:00', 9.50),
(13, 13, 3, '2024-03-3 19:30:00', 11.00),
(14, 14, 4, '2024-03-4 19:30:00', 10.50),
(15, 15, 5, '2024-03-5 19:30:00', 9.00);

INSERT INTO Showtime (ShowtimeID, MovieID, TheaterID, ShowDateTime, Price)  VALUES
(16, 1, 1, '2024-16-03 19:30:00', 29.00);

INSERT INTO Customer (CustomerID, FirstName, LastName, Email, PhoneNumber)  VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '+1234567890'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '+1987654321'),
(3, 'Michael', 'Johnson', 'michael.johnson@example.com', '+1654321890'),
(4, 'Emily', 'Williams', 'emily.williams@example.com', '+1765432980'),
(5, 'William', 'Brown', 'william.brown@example.com', '+1876543210'),
(6, 'Sophia', 'Jones', 'sophia.jones@example.com', '+1543218760'),
(7, 'Daniel', 'Taylor', 'daniel.taylor@example.com', '+1765432189'),
(8, 'Olivia', 'Anderson', 'olivia.anderson@example.com', '+1987654312'),
(9, 'Matthew', 'Harris', 'matthew.harris@example.com', '+1234567890'),
(10, 'Ava', 'Clark', 'ava.clark@example.com', '+1876543219'),
(11, 'Ethan', 'Lewis', 'ethan.lewis@example.com', '+1654321897'),
(12, 'Amelia', 'Walker', 'amelia.walker@example.com', '+1987654321'),
(13, 'James', 'Roberts', 'james.roberts@example.com', '+1234567890'),
(14, 'Isabella', 'Young', 'isabella.young@example.com', '+1987654321'),
(15, 'Benjamin', 'Scott', 'benjamin.scott@example.com', '+1765432980');

INSERT INTO Ticket (TicketID, ShowtimeID, SeatNumber, PurchasedDateTime, CustomerID)  VALUES
(1, 1, 'A1','2024-03-2 19:30:00' , 1),
(2, 2, 'B3','2024-03-3 19:30:00' , 2),
(3, 3, 'C5','2024-03-4 19:30:00' , 3),
(4, 4, 'D7','2024-03-5 19:30:00' , 4),
(5, 5, 'E9','2024-03-6 19:30:00' , 5),
(6, 6, 'F11','2024-03-7 19:30:00' , 6),
(7, 7, 'G13','2024-03-8 19:30:00' , 7),
(8, 8, 'H15','2024-03-9 19:30:00' , 8),
(9, 9, 'I17','2024-03-10 19:30:00' , 9),
(10, 10, 'J19','2024-03-11 19:30:00' , 10),
(11, 11, 'K21','2024-03-12 19:30:00' , 11),
(12, 12, 'L23','2024-03-11 19:30:00' , 12),
(13, 13, 'M25','2024-03-10 19:30:00' , 13),
(14, 14, 'N27','2024-03-9 19:30:00' , 14),
(15, 15, 'O29','2024-03-8 19:30:00' , 15),
(16, 1, 'B2','2024-03-7 19:30:00' , 1),
(17, 1, 'C3','2024-03-6 19:30:00' , 2),
(18, 1, 'D4','2024-03-5 19:30:00' , 3),
(19, 1, 'E5','2024-03-4 19:30:00' , 4),
(20, 1, 'F6','2024-03-3 19:30:00' , 5),
(21, 2, 'G7','2024-03-2 19:30:00' , 6),
(22, 2, 'H8','2024-03-1 19:30:00' , 7),
(23, 2, 'I9','2024-03-2 19:30:00' , 8),
(24, 2, 'J10', '2024-03-3 19:30:00', 9),
(25, 2, 'K11','2024-03-4 19:30:00' , 10);

INSERT INTO Ticket (TicketID, ShowtimeID, SeatNumber, PurchasedDateTime, CustomerID)  VALUES
(26, 16, 'A1','2024-03-2 19:30:00' , 1);

INSERT INTO Review (ReviewID, MovieID, CustomerID, ReviewText, Rating, ReviewDate)  VALUES
(1, 1, 1, 'Un film fantastico! Altamente consigliato.', 5,'2024-03-4 19:30:00'),
(2, 1, 2, 'Incredibile! Uno dei migliori film che abbia mai visto.', 5,'2024-03-4 19:30:00'),
(3, 1, 3, 'Davvero ben fatto. La trama è avvincente e gli attori sono eccezionali.', 4,'2024-03-4 19:30:00'),
(4, 2, 4, 'Un vero capolavoro! Emozionante dall''inizio alla fine.', 5,'2024-03-4 19:30:00'),
(5, 2, 5, 'Ho adorato questo film! La regia e le performance sono incredibili.', 5,'2024-03-4 19:30:00'),
(6, 3, 6, 'Mi è piaciuto molto questo film. Consigliato a tutti.', 4,'2024-03-4 19:30:00'),
(7, 3, 7, 'Un po'' deludente. Mi aspettavo di più dalla trama.', 3,'2024-03-4 19:30:00'),
(8, 3, 8, 'Nonostante qualche difetto, è comunque un film che vale la pena vedere.', 4,'2024-03-4 19:30:00'),
(9, 3, 9, 'Buon film nel complesso. Mi è piaciuto il messaggio.', 4,'2024-03-4 19:30:00'),
(10, 3, 10, 'Un film decente, ma niente di speciale.', 3,'2024-03-4 19:30:00');

INSERT INTO Employee (EmployeeID, CinemaID, FirstName, LastName, Position, HireDate) VALUES
(1, 1, 'Marco', 'Rossi', 'Manager', '2023-05-10'),
(2, 2, 'Giulia', 'Bianchi', 'Cameriera', '2023-07-15'),
(3, 3, 'Luca', 'Verdi', 'Cassiere', '2023-08-20'),
(4, 4, 'Anna', 'Neri', 'Usciere', '2023-09-25'),
(5, 5, 'Simone', 'Gialli', 'Addetto pulizie', '2023-10-30'),
(6, 1, 'Laura', 'Russo', 'Cassiere', '2023-06-05'),
(7, 2, 'Federico', 'Marroni', 'Manager', '2023-07-20'),
(8, 3, 'Alessia', 'Blu', 'Cameriera', '2023-08-25'),
(9, 4, 'Giovanni', 'Viola', 'Addetto pulizie', '2023-10-01'),
(10, 5, 'Chiara', 'Arancioni', 'Usciere', '2023-11-10');


--VISTE

--1
--Creare una vista FilmsInProgrammation che mostri i titoli dei film, la data di inizio
--programmazione, la durata e la classificazione per età. Questa vista aiuterà il personale e i clienti a
--vedere rapidamente quali film sono attualmente in programmazione.

CREATE VIEW FilmsInProgrammation AS
	SELECT m.Title, s.ShowDateTime, m.DurationMinutes, m.Rating 
	FROM Movie m INNER JOIN Showtime s ON m.MovieID=s.MovieID 
	WHERE s.ShowDateTime='2024-16-03 19:30:00';

SELECT * FROM FilmsInProgrammation

--2
--Creare una vista AvailableSeatsForShow che, per ogni spettacolo, mostri il numero totale di
--posti nella sala e quanti sono ancora disponibili. Questa vista è essenziale per il personale alla
--biglietteria per gestire le vendite dei biglietti.

CREATE VIEW AvailableSeatsForShow AS
	SELECT s.ShowtimeID, m.Title, t.Capacity AS Capienza_Massima,  t.Capacity - COUNT(tk.TicketID)  AS Biglietti_Rimanenti 
	FROM Showtime s INNER JOIN Ticket tk ON s.ShowtimeID=tk.ShowtimeID 
	INNER JOIN Theater t ON s.TheaterID=t.TheaterID 
	INNER JOIN Movie m ON m.MovieID=s.MovieID 
	GROUP  BY s.ShowtimeID, s.MovieID, t.Capacity ,m.Title

SELECT * FROM AvailableSeatsForShow

--3
--Generare una vista TotalEarningsPerMovie che elenchi ogni film insieme agli incassi totali
--generati. Questa informazione è cruciale per la direzione per valutare il successo commerciale dei
--film.

CREATE VIEW TotalEarningsPerMovie AS
	SELECT * 
	FROM Movie m INNER JOIN Showtime s ON m.MovieID=s.MovieID 
	LEFT JOIN Ticket t ON s.ShowtimeID=t.ShowtimeID 
	GROUP BY m.Title, m.MovieID;
--INCOMPLETA

--4
--Creare una vista RecentReviews che mostri le ultime recensioni lasciate dai clienti, includendo il
--titolo del film, la valutazione, il testo della recensione e la data. Questo permetterà al personale e
--alla direzione di monitorare il feedback dei clienti in tempo reale.

CREATE VIEW RecentReviews AS
	SELECT m.Title, r.Rating, r.ReviewText, r.ReviewDate 
	FROM Movie m INNER JOIN Review r ON m.MovieID=r.MovieID 

SELECT  * FROM RecentReviews ORDER BY ReviewDate;


--STORED PROCEDURES

--1
--Creare una stored procedure PurchaseTicket che permetta di acquistare un biglietto per uno
--spettacolo, specificando l'ID dello spettacolo, il numero del posto e l'ID del cliente. La procedura
--dovrebbe verificare la disponibilità del posto e registrare l'acquisto.

DROP PROCEDURE IF EXISTS PurchaseTicket
CREATE PROCEDURE PurchaseTicket

@TicketID INT,
@ShowtimeID INT,
@numeroPosto VARCHAR(50),
@CustomerID INT

AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * FROM Ticket t INNER JOIN Showtime s ON t.ShowtimeID=s.ShowtimeID WHERE s.ShowtimeID=@ShowtimeID AND SeatNumber=@numeroPosto;
				IF(@@ROWCOUNT=0)
				BEGIN
					BEGIN TRY
						INSERT INTO Ticket (TicketID, ShowtimeID, SeatNumber, PurchasedDateTime,CustomerID) VALUES
						(@TicketID, @ShowtimeID, @numeroPosto, CURRENT_TIMESTAMP, @CustomerID);
					END TRY
					BEGIN CATCH
						PRINT 'ERRORE NELL''OPERAZIONE DI INSERT'
					END CATCH
				END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
END

EXEC PurchaseTicket @TicketID=28, @ShowtimeID = 3, @numeroPosto='J2', @CustomerID=4; 

SELECT * FROM Ticket

--2
--Implementare una stored procedure UpdateMovieSchedule che permetta di aggiornare gli orari
--degli spettacoli per un determinato film. Questo include la possibilità di aggiungere o rimuovere
--spettacoli dall'agenda.

DROP PROCEDURE IF EXISTS UpdateMovieSchedule;
CREATE PROCEDURE UpdateMovieSchedule
--@rimuoviChoice VARCHAR(2)
@MovieID INT = NULL,
@ShowDateTime DATETIME,
@Price INT = NULL,
@ShowtimeID INT,
@TheaterID INT = NULL

AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			
			SELECT * FROM Showtime WHERE ShowtimeID=@ShowtimeID
			IF(@@ROWCOUNT = 1)
				--SELECT @ShowtimeID = @@IDENTITY
			BEGIN	
				UPDATE Showtime SET ShowDateTime=@ShowDateTime WHERE ShowtimeID=@ShowtimeID
			END
			ELSE
			BEGIN
				SELECT * FROM Showtime WHERE ShowtimeID=@ShowtimeID
				IF(@@ROWCOUNT = 0)
				BEGIN	
				INSERT INTO Showtime (ShowtimeID, MovieID, TheaterID,ShowDateTime, Price) VALUES
				(@ShowtimeID, @MovieID, @TheaterID,@ShowDateTime, @Price)
				END
				ELSE
				PRINT'ERRORE'
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

EXEC UpdateMovieSchedule @ShowtimeID=17, @Movieid=1, @TheaterID=1,@ShowDateTime='2024-31-01 18:00:00', @Price=10.00


SELECT * FROM Showtime s 

--3
--Sviluppare una stored procedure InsertNewMovie che consenta di inserire un nuovo film nel
--sistema, richiedendo tutti i dettagli pertinenti come titolo, regista, data di uscita, durata e
--classificazione.

DROP PROCEDURE IF EXISTS InsertNewMovie
CREATE PROCEDURE InsertNewMovie

@MovieID INT,
@Title VARCHAR(250),
@Director VARCHAR(250) = NULL,
@ReleaseDate DATE = NULL,
@DurationMinutes INT = NULL,
@Rating VARCHAR(10) = NULL

AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * FROM Movie WHERE MovieID=@MovieID
			IF(@@ROWCOUNT = 0)
			BEGIN
				INSERT INTO Movie(MovieID, Title, Director, ReleaseDate, DurationMinutes, Rating) VALUES
				(@MovieID, @Title, @Director, @ReleaseDate, @DurationMinutes, @Rating)
			END
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

EXEC InsertNewMovie @MovieID = 2, @Title='Giovanni Pace' 

SELECT * FROM Movie

--4
--Creare una stored procedure SubmitReview che consenta ai clienti di lasciare una recensione per
--un film, comprensiva di valutazione, testo e data. Questa procedura dovrebbe verificare che il
--cliente abbia effettivamente acquistato un biglietto per il film in questione prima di permettere la
--pubblicazione della recensione.

CREATE PROCEDURE SubmitReview

@ReviewID INT,
@MovieID INT,
@CustomerID INT,
@ReviewText VARCHAR(250) = NULL,
@Rating INT = NULL
AS 
BEGIN 
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * FROM Review WHERE ReviewID=@ReviewID
			IF(@@ROWCOUNT = 0)
					BEGIN
						INSERT INTO Review (ReviewID, MovieID, CustomerID, ReviewText, Rating, ReviewDate) VALUES
						(@ReviewID, @MovieID, @CustomerID, @ReviewText, @Rating, CURRENT_TIMESTAMP)
					END
		COMMIT TRANSACTION
	END TRY 
	BEGIN CATCH
		ROLLBACK TRANSACTION
	END CATCH
END

EXEC SubmitReview @ReviewID = 12, @MovieID = 1, @CustomerID = 1

SELECT * FROM Review