/* È necessario implementare uno schema che consenta di gestire le anagrafiche degli store di unʼipotetica azienda. 
Uno store è collocato in una precisa area geografica. In unʼarea geografica possono essere collocati store diversi. 
Cosa devi fare: */
-- 1. Crea una tabella Store per la gestione degli store (ID, nome, data apertura, ecc.) 

CREATE TABLE Store (
    StoreID INT NOT NULL AUTO_INCREMENT,
    StoreName VARCHAR(255),
    OpeningDate DATE,
    Street VARCHAR(255),
    PostalCode VARCHAR(20),
    City VARCHAR(100),
    TerritoryID INT,
    CONSTRAINT PK_StoreID PRIMARY KEY (StoreID),
    CONSTRAINT FK_StoreRegionID FOREIGN KEY (TerritoryID)
        REFERENCES Region (TerritoryID)
);

-- 2. Crea una tabella Region per la gestione delle aree geografiche (ID, città, regione, area geografica, …) 

CREATE TABLE Region (
    TerritoryID INT NOT NULL AUTO_INCREMENT,
    Country VARCHAR(25),
    Region VARCHAR(25),
    City VARCHAR(25),
    CONSTRAINT PK_Territory PRIMARY KEY (TerritoryID)
);

-- 3. Popola le tabelle con pochi record esemplificativi 

INSERT INTO Region (Country, Region, City) VALUES
('Germany', 'Bavaria', 'Munich'),
('Italy', 'Lazio', 'Rome'),
('France', 'Île-de-France', 'Paris'),
('Spain', 'Catalonia', 'Barcelona'),
('Netherlands', 'North Holland', 'Amsterdam'),
('Belgium', 'Flanders', 'Antwerp'),
('Austria', 'Vienna', 'Vienna'),
('Poland', 'Masovian Voivodeship', 'Warsaw'),
('Sweden', 'Stockholm County', 'Stockholm'),
('Denmark', 'Capital Region', 'Copenhagen');

INSERT INTO Store (StoreName, OpeningDate, Street, PostalCode, City, TerritoryID) VALUES
('GlobalMart Munich', '2023-05-15', 'Maximilianstraße 35', '80333', 'Munich', (SELECT TerritoryID FROM Region WHERE City = 'Munich')),
('GlobalMart Rome', '2022-08-23', 'Via del Corso 100', '00187', 'Rome', (SELECT TerritoryID FROM Region WHERE City = 'Rome')),
('GlobalMart Paris', '2021-03-30', 'Rue de Rivoli 45', '75001', 'Paris', (SELECT TerritoryID FROM Region WHERE City = 'Paris')),
('GlobalMart Barcelona', '2024-01-10', 'Passeig de Gràcia 78', '08008', 'Barcelona', (SELECT TerritoryID FROM Region WHERE City = 'Barcelona')),
('GlobalMart Amsterdam', '2022-09-15', 'Damstraat 120', '1012', 'Amsterdam', (SELECT TerritoryID FROM Region WHERE City = 'Amsterdam')),
('GlobalMart Antwerp', '2023-06-05', 'Meir 45', '2000', 'Antwerp', (SELECT TerritoryID FROM Region WHERE City = 'Antwerp')),
('GlobalMart Vienna', '2024-04-02', 'Kärntnertorstraße 10', '1010', 'Vienna', (SELECT TerritoryID FROM Region WHERE City = 'Vienna')),
('GlobalMart Warsaw', '2023-12-20', 'Krakowskie Przedmieście 65', '00-071', 'Warsaw', (SELECT TerritoryID FROM Region WHERE City = 'Warsaw')),
('GlobalMart Stockholm', '2021-11-18', 'Drottninggatan 33', '111 51', 'Stockholm', (SELECT TerritoryID FROM Region WHERE City = 'Stockholm')),
('GlobalMart Copenhagen', '2024-02-05', 'Strøget 50', '1000', 'Copenhagen', (SELECT TerritoryID FROM Region WHERE City = 'Copenhagen')),
('GlobalMart Munich - Downtown', '2024-01-07', 'Sendlinger Str. 45', '80331', 'Munich', (SELECT TerritoryID FROM Region WHERE City = 'Munich')),
('GlobalMart Paris - Haussmann', '2023-09-30', 'Boulevard Haussmann 140', '75008', 'Paris', (SELECT TerritoryID FROM Region WHERE City = 'Paris')),
('GlobalMart Barcelona - Claris', '2024-05-12', 'Carrer de Pau Claris 55', '08010', 'Barcelona', (SELECT TerritoryID FROM Region WHERE City = 'Barcelona')),
('GlobalMart Amsterdam - Prinsengracht', '2023-03-22', 'Prinsengracht 85', '1015', 'Amsterdam', (SELECT TerritoryID FROM Region WHERE City = 'Amsterdam')),
('GlobalMart Vienna - Mariahilfer', '2023-11-18', 'Mariahilfer Str. 100', '1060', 'Vienna', (SELECT TerritoryID FROM Region WHERE City = 'Vienna'));

-- 4. Esegui operazioni di aggiornamento, modifica ed eliminazione record 
START TRANSACTION;
UPDATE Store 
SET 
    StoreName = 'GlobalMart Munich'
WHERE
    StoreID = 11
; 
ROLLBACK;

START TRANSACTION;
UPDATE Region 
SET 
    Country = 'Japan'
WHERE
    TerritoryID = 6
; 
ROLLBACK;

START TRANSACTION;
UPDATE Store 
SET 
    StoreName = 'GlobalMart Verona', Street = 'Via Mazzini 74', PostalCode = 37121, City = 'Verona'
WHERE
    StoreID = 2
; 
UPDATE Region 
SET 
    Region = 'Veneto', City = 'Verona'
WHERE
    TerritoryId = 2;
ROLLBACK;

START TRANSACTION;
DELETE FROM Store 
WHERE
    StoreId IN (SELECT 
        s.StoreID
    FROM
        (SELECT 
            StoreID
        FROM
            STORE 
        WHERE
            CITY = 'Paris') as s)
; 
ROLLBACK;

START TRANSACTION;
DELETE FROM
	Store
WHERE
	TerritoryId in (SELECT TerritoryID from Region WHERE TerritoryId in (1, 4 ,5))
    ;
rollback;

SELECT
*
FROM
Region
;

SELECT 
*
FROM
    Store s
        JOIN
    region r ON s.TerritoryID = r.territoryID
;