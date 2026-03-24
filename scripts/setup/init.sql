INSTALL sqlite;
LOAD sqlite;

ATTACH 'data/chinook.sqlite' AS chinook (TYPE SQLITE);


CREATE OR REPLACE TABLE artists AS SELECT * FROM chinook."Artist";
CREATE OR REPLACE TABLE albums  AS SELECT * FROM chinook."Album";
CREATE OR REPLACE TABLE tracks  AS SELECT * FROM chinook."Track";
CREATE OR REPLACE TABLE genres  AS SELECT * FROM chinook."Genre";

CREATE OR REPLACE TABLE customers     AS SELECT * FROM chinook."Customer";
CREATE OR REPLACE TABLE invoices      AS SELECT * FROM chinook."Invoice";
CREATE OR REPLACE TABLE invoice_items AS SELECT * FROM chinook."InvoiceLine";

CREATE OR REPLACE TABLE big_sales AS
SELECT
    range AS sale_id,
    floor(random() * 3500 + 1)::INT AS track_id, -- koppelt aan tracks
    (random() * 20)::DECIMAL(10,2) AS price,
    timestamp '2023-01-01' + (random() * interval '365 days') AS sale_date
FROM range(1000000);

DETACH chinook;