CREATE TABLE testdrop (c1 NUMBER);

SHOW TABLES HISTORY;

DROP TABLE testdrop;

SELECT * FROM testdrop;

SHOW TABLES HISTORY;

UNDROP TABLE testdrop;

SELECT * FROM testdrop;

SHOW TABLES HISTORY;

INSERT INTO testdrop VALUES (1000), (2000), (3000), (4000);

SELECT * FROM testdrop;

DELETE FROM testdrop WHERE c1 IN (2000, 3000);

SELECT * FROM testdrop;

SELECT *
FROM testdrop BEFORE (STATEMENT => '01a0ecc6-0000-3c1f-0000-ebc10007ec8e');

CREATE TABLE testdrop_restored
CLONE testdrop BEFORE (STATEMENT  => '01a0ecc6-0000-3c1f-0000-ebc10007ec96');

SELECT * FROM testdrop_restored;

SELECT * FROM testdrop_restored
LEFT JOIN testdrop ON testdrop.c1 = testdrop_restored.c1;

DROP TABLE testdrop;

SELECT * FROM testdrop;

CREATE TABLE loaddata1 (c1 NUMBER);

INSERT INTO LoadData1 VALUES (1111), (2222), (3333), (4444);

SELECT * FROM loaddata1;

DROP TABLE loaddata1;
SELECT * FROM loaddata1;

CREATE TABLE loaddata1 (c1 NUMBER);
INSERT INTO loaddata1
VALUES (777), (888), (999);

DROP TABLE loaddata1;
CREATE TABLE loaddata1 (c1 NUMBER);

UNDROP TABLE loaddata1;

SHOW TABLES HISTORY;

ALTER TABLE loaddata1 RENAME TO loaddata3;
UNDROP TABLE loaddata1;

SELECT * FROM loaddata1;

SHOW TABLES HISTORY;

ALTER TABLE loaddata1 RENAME TO loaddata2;
UNDROP TABLE loaddata1;

SELECT * FROM loaddata1;

SHOW TABLES HISTORY;

SELECT * FROM loaddata1;
SELECT * FROM loaddata2;
SELECT * FROM loaddata3;

SHOW TABLES HISTORY;