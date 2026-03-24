-- 1. Stap uit de 'chinook' database naar het standaard geheugen
USE memory; 

-- 2. Nu kun je hem veilig ontkoppelen
DETACH chinook;

-- 3. Verwijder de oude (mislukte) tabellen uit je hoofd-database
DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS albums;
DROP TABLE IF EXISTS tracks;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS invoice_items;
