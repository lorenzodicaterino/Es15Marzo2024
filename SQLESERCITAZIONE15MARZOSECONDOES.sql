DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Product_Supplier;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Maintenance;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Vending_Machine;

CREATE TABLE Vending_Machine(
vendingID INT PRIMARY KEY IDENTITY(1,1),
posizione VARCHAR(250) NOT NULL,
modello VARCHAR(250) NOT NULL
);

CREATE TABLE Product (
productID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(250) NOT NULL,
prezzo DECIMAL(5,2) NOT NULL,
quantita INT NOT NULL,
vendingRIF INT,
FOREIGN KEY (vendingRIF) REFERENCES Vending_Machine(vendingID) ON DELETE SET NULL,
UNIQUE (productID, vendingRIF)
);

CREATE TABLE Transactions (
transactionID INT PRIMARY KEY IDENTITY(1,1),
data_e_ora DATETIME NOT NULL,
importo DECIMAL(5,2) NOT NULL,
productRIF INT NOT NULL,
vendingRIF INT NOT NULL,
FOREIGN KEY (productRIF) REFERENCES Product(productID) ON DELETE CASCADE,
FOREIGN KEY (vendingRIF) REFERENCES Vending_Machine(vendingID) ON DELETE CASCADE
);

CREATE TABLE Maintenance (
maintenanceID INT PRIMARY KEY IDENTITY(1,1),
data_maintenance DATE NOT NULL,
descrizione TEXT,
vendingRIF INT NOT NULL,
FOREIGN KEY (vendingRIF) REFERENCES Vending_Machine(vendingID) ON DELETE CASCADE
);

CREATE TABLE Supplier (
supplierID INT PRIMARY KEY IDENTITY(1,1),
nome VARCHAR(250) NOT NULL,
telefono VARCHAR(50) NOT NULL
);

CREATE TABLE Product_Supplier(
product_supplierID INT PRIMARY KEY IDENTITY(1,1),
productRIF INT NOT NULL,
supplierRIF INT NOT NULL,
FOREIGN KEY (productRIF) REFERENCES Product(productID) ON DELETE CASCADE,
FOREIGN KEY (supplierRIF) REFERENCES Supplier(supplierID) ON DELETE CASCADE
);

INSERT INTO Vending_Machine(posizione, modello) VALUES
('Roma','A1'),
('Napoli','A2'),
('Milano','A1'),
('Torino','B1'),
('Palermo','B2');

INSERT INTO Product(nome, prezzo, quantita, vendingRIF) VALUES
('Snack di Patate', 1.50, 20, 1),
('Acqua Minerale 0.5L', 1.00, 30, 2),
('Cioccolato al Latte', 1.20, 25, 3),
('Biscotti Integrali', 2.00, 15, 4),
('Succo di Frutta 0.33L', 1.80, 18, 5),
('Barretta Energetica', 1.70, 22, 5),
('Birra in Lattina', 2.50, 12, 5),
('Patatine Salate', 1.30, 28, 4),
('Gomme da Masticare', 0.50, 35, 3),
('Barretta di Cereali', 1.60, 20, 2),
('Coca-Cola in Lattina', 1.50, 24, null),
('Energy Drink', 2.20, 16, null),
('Gelato al Cioccolato', 2.80, 10, 2),
('Mars', 1.40, 30, 2),
('Acqua Frizzante 0.5L', 1.00, 25, 1);

INSERT INTO Transactions (vendingRIF, productRIF, data_e_ora, importo) VALUES 
(1, 5, '2024/17/03 08:30:00', 1.50),
(2, 10, '2024/17/03 09:15:00', 2.00),
(3, 15, '2024/17/03 10:00:00', 1.20),
(4, 2, '2024/17/03 10:45:00', 1.80),
(5, 1, '2024/13/03 11:30:00', 1.70),
(1, 6, '2024/16/03 12:15:00', 2.50),
(2, 11, '2024/12/03 13:00:00', 1.30),
(3, 11, '2024/18/03 13:45:00', 0.50),
(4, 2, '2024/12/03 14:30:00', 1.60),
(5, 7, '2024/14/03 15:15:00', 1.50),
(1, 12, '2024/15/03 16:00:00', 2.20),
(2, 12, '2024/14/03 16:45:00', 2.80),
(3, 3, '2024/12/03 17:30:00', 1.40),
(4, 8, '2024/10/03 18:15:00', 1.00),
(5, 13, '2024/1/03 19:00:00', 1.00),
(1, 11, '2024/1/03 19:45:00', 1.80),
(2, 4, '2024/21/03 20:30:00', 1.70),
(3, 9, '2024/23/03 21:15:00', 1.90),
(4, 14, '2024/13/03 22:00:00', 2.40),
(5, 10, '2024/12/03 22:45:00', 1.60);

INSERT INTO Supplier(nome, telefono) VALUES
('Mario Giordano','123456'),
('Giovanni Pace','345678'),
('Lorenzo Di Caterino','3345643'),
('I&M','111111'),
('Valeria Verdi','343434');

INSERT INTO	Product_Supplier (productRIF, supplierRIF)VALUES
(1,1),
(2,2),
(2,3),
(2,4),
(3,5),
(4,1),
(5,2),
(6,3),
(7,4),
(8,5),
(10,5),
(9,4),
(11,3),
(12,4),
(13,5),
(14,5),
(15,4);

INSERT INTO Maintenance(data_maintenance, descrizione, vendingRIF) VALUES
('2024-01-01','t''appo',1),
('2024-02-02','mezza scassata',1),
('2024-03-03','precia',2),
('2024-03-03','precia',3),
('2024-04-04',null,3),
('2024-05-05',null,4);

INSERT INTO Maintenance(data_maintenance, descrizione, vendingRIF) VALUES
('2024-05-05',null,1);

--VISTE

--1
--Creare una vista ProductsByVendingMachine che mostri tutti i prodotti disponibili in ciascun
--distributore, includendo l'ID e la posizione del distributore, il nome del prodotto, il prezzo e la
--quantità disponibile.

CREATE VIEW ProductsByVendingMachine AS
	SELECT p.nome, p.prezzo, p.quantita, v.modello, v.posizione 
	FROM Vending_Machine v INNER JOIN Product p ON v.vendingID=p.vendingRIF 
	WHERE p.vendingRIF IS NOT NULL

SELECT * FROM ProductsByVendingMachine ORDER BY modello;

--2
--Generare una vista RecentTransactions che elenchi le ultime transazioni effettuate, mostrando
--l'ID della transazione, la data/ora, il distributore, il prodotto acquistato e l'importo della
--transazione.

CREATE VIEW RecentTransactions AS 
	SELECT t.transactionID, t.data_e_ora, v.modello, v.posizione ,p.nome, t.importo
	FROM Vending_Machine v INNER JOIN Transactions t ON v.vendingID=t.vendingRIF 
	INNER JOIN Product p ON t.productRIF=p.productID

SELECT * FROM RecentTransactions ORDER BY data_e_ora DESC


--3	
--Creare una vista ScheduledMaintenance che mostri tutti i distributori che hanno una
--manutenzione programmata, includendo l'ID e la posizione del distributore e la data dell'ultima e
--della prossima manutenzione.

--manca data ultima manutenzione

CREATE VIEW ScheduledMaintenance AS 
	SELECT v.vendingID, v.posizione, m.data_maintenance 
	FROM Maintenance m LEFT JOIN Vending_Machine v ON m.vendingRIF=v.vendingID	
	WHERE data_maintenance>CURRENT_TIMESTAMP
 
 SELECT * FROM ScheduledMaintenance ORDER BY data_maintenance

 --PROCEDURE

 --1
 --Implementare una stored procedure RefillProduct che consenta di aggiungere scorte di un
--prodotto specifico in un distributore, richiedendo l'ID del distributore, l'ID del prodotto e la
--quantità da aggiungere.

CREATE PROCEDURE RefillProduct
@vendingID INT,
@productID INT,
@quantity INT

AS 
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * FROM Product WHERE productID=@productID AND vendingRIF=@vendingID

			IF(@@ROWCOUNT = 1)
				UPDATE Product SET quantita=quantita+@quantity WHERE productID=@productID
			ELSE
				THROW 50001, 'ERRORE', 1
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION 
	END CATCH
END

EXEC RefillProduct @vendingID = 1, @productID = 1, @quantity = 100	

SELECT * FROM Product


--2
--Sviluppare una stored procedure RecordTransaction che registri una nuova transazione,
--includendo l'ID del distributore, l'ID del prodotto e l'importo pagato, aggiornando
--contemporaneamente la quantità disponibile del prodotto.

--CONSIDERANDO CHE OGNI TRANSIZIONE COMPRENDA UN SOLO PRODOTTO

CREATE PROCEDURE RecordTransaction
@vendingID INT,
@productID INT,
@importo DECIMAL(5,2)

AS 
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * FROM Product WHERE productID=@productID AND vendingRIF=@vendingID AND quantita>0
			IF(@@ROWCOUNT = 1)
				BEGIN
					INSERT INTO Transactions(productRIF, vendingRIF, importo, data_e_ora) VALUES 
					(@productID, @vendingID, @importo, CURRENT_TIMESTAMP);
					UPDATE Product SET quantita=quantita-1 WHERE productID=@productID
				END
			ELSE
				THROW 50001, 'ERRORE', 1
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION 
	END CATCH
END

EXEC RecordTransaction @vendingID = 1, @productID = 1, @importo = 10

SELECT * FROM Product

--3
--Creare una stored procedure ScheduleMaintenance per programmare un intervento di
--manutenzione su un distributore, specificando l'ID del distributore e la data della manutenzione.

CREATE PROCEDURE ScheduleMaintenance 
@vendingID INT,
@data DATE

AS 
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			IF(@data>CURRENT_TIMESTAMP)
				BEGIN
					INSERT INTO Maintenance (data_maintenance, vendingRIF) VALUES
					(@data, @vendingID)
				END
			ELSE
				THROW 50001, 'ERRORE', 1
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION 
	END CATCH
END

EXEC ScheduleMaintenance @vendingID=1, @data='2023-01-01'

SELECT * FROM Maintenance

--4
--Implementare una stored procedure UpdateProductPrice che permetta di aggiornare il prezzo di
--un prodotto specifico, richiedendo l'ID del prodotto e il nuovo prezzo.

CREATE PROCEDURE UpdateProductPrice
@productID INT,
@price DECIMAL(5,2)

AS 
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			SELECT * FROM Product WHERE productID=@productID
			
			IF(@@ROWCOUNT = 1 AND @price>0)
				BEGIN
					UPDATE Product SET prezzo=@price WHERE productID=@productID
				END
			ELSE
				THROW 50001, 'ERRORE', 1
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION 
	END CATCH
END

EXEC UpdateProductPrice @productID = 1, @price = 3

SELECT * FROM Product