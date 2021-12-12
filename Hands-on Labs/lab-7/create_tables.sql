#Test table;
;
CREATE TABLE test (num NUMBER(4,2));

INSERT INTO test (num) VALUES (2);
INSERT INTO test (num) VALUES (2.57);
INSERT INTO test (num) VALUES (4.5);
INSERT INTO test (num) VALUES (1.22);

#Confirming info;
;
SELECT * FROM test;

SELECT num::integer as value FROM test;

#Characters table;
;
CREATE TABLE characters(id INTEGER, name VARCHAR(6), num FLOAT);
INSERT INTO characters VALUES
   (1, 'Thanos', 10.012),
   (2, 'Bess', 3.00),
   (3, 'Tucker', 5),
   (4, 'Moana', 17.003),
   (5, 'Hobson', 123.42124),
   (6, 'Kitty', 14);

#Movies table;
;
CREATE TABLE movies(id NUMBER(4,2), title VARCHAR(25), num INTEGER);
INSERT INTO movies VALUES
   (1, 'Endgame', 13),
   (2, 'Porgy and Bess', 3),
   (3, 'Tucker & Dale vs Evil', 7),
   (4, 'Moana', 5),
   (5, 'Arthur', 14),
   (6, 'Gunsmoke', 22);

#Weekly sales table;
;
CREATE TABLE weekly_sales(name VARCHAR(10), day VARCHAR(3), amount NUMBER(8,2));
INSERT INTO weekly_sales VALUES
   ('Fred', 'MON',  913.24), ('Fred', 'WED', 1256.87), ('Rita', 'THU',   10.45),
   ('Mark', 'TUE',  893.45), ('Mark', 'TUE', 2240.00), ('Fred', 'MON',   43.99),
   ('Mark', 'MON',  257.30), ('Fred', 'FRI', 1000.27), ('Fred', 'WED',  924.34),
   ('Rita', 'WED',  355.60), ('Rita', 'MON',  129.00), ('Fred', 'WED', 3092.56),
   ('Fred', 'TUE',  449.00), ('Mark', 'MON',  289.12), ('Fred', 'FRI',  900.57),
   ('Rita', 'THU', 1200.00), ('Fred', 'THU', 1100.95), ('Fred', 'MON',  523.33),
   ('Fred', 'TUE',  972.33), ('Fred', 'MON', 4500.87), ('Fred', 'WED',   35.90),
   ('Rita', 'MON',   28.90), ('Mark', 'FRI', 1466.02), ('Fred', 'MON', 3022.45),
   ('Mark', 'TUE',  256.88), ('Fred', 'MON',  449.00), ('Rita', 'FRI',  294.56),
   ('Fred', 'MON',  882.56), ('Fred', 'WED', 1193.20), ('Rita', 'WED',   88.90),
   ('Mark', 'WED',   10.37), ('Fred', 'THU', 2345.00), ('Fred', 'TUE', 2638.76),
   ('Rita', 'TUE',  988.26), ('Fred', 'THU', 3400.23), ('Fred', 'MON',  882.45),
   ('Rita', 'THU', 734.527), ('Rita', 'MON', 6011.20), ('Fred', 'FRI',  389.12),
   ('Fred', 'THU',  893.45), ('Mark', 'WED', 2900.13), ('Mark', 'MON',  610.45),
   ('Fred', 'FRI',   45.69), ('Rita', 'FRI', 1092.35), ('Mark', 'MON',   12.56);