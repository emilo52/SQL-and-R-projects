
-- create table of fake game shop titles, prices, profits, etc.
IF OBJECT_ID('game_shop', 'U') IS NOT NULL 
    DROP TABLE game_shop;

CREATE TABLE game_shop
(
id int IDENTITY(1,1) PRIMARY KEY,
title NVARCHAR (50),
price NUMERIC,
genre NVARCHAR (50),
profit NUMERIC,
percent_returned NUMERIC,
suggested_companion_game_id NUMERIC,
);

--insert data into table
INSERT INTO game_shop 
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Wingspan', 56, 'engine builder', 12, 5, 8);

INSERT INTO game_shop 
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Settlers of Catan', 40, 'strategy', 7, 2, 3);

INSERT INTO game_shop 
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Knights and Cities Expansion', 30, 'strategy', 4, 10, 2);

INSERT INTO game_shop 
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Azul', 25, 'strategy', 3, 12, 5);

INSERT INTO game_shop 
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Calico', 45, 'simulation', 10, 5, 4);

INSERT INTO game_shop 
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Mysterium', 60, 'co-op', 12, 15, 7);

INSERT INTO game_shop 
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Betrayal at House on the Hill', 70, 'adventure', 20, 15, 6);

INSERT INTO game_shop
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Trails: A Parks Game', 35, 'adventure', 5, 8, 1);

INSERT INTO game_shop
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('7 Wonders', 30, 'engine builder', 7, 3, 11);

INSERT INTO game_shop
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Gloomhaven', 50, 'simulation', 10, 25, 2);

INSERT INTO game_shop
(title, price, genre, profit, percent_returned, suggested_companion_game_id)
VALUES ('Pandemic', 47, 'co-op', 2, 3, 9);



--view table
SELECT * FROM game_shop;

--view titles of adventure games and order by profit
SELECT title FROM game_shop WHERE genre LIKE 'adventure' ORDER BY profit;

--view genre of most profitable game
SELECT TOP 1 genre FROM game_shop ORDER BY profit DESC;

--find average profit by genre, only showing genres with profit>9
SELECT genre, AVG(profit) AS "Average Profit" FROM game_shop GROUP BY genre HAVING AVG(profit)>9 ORDER BY AVG(profit)

--find most returned game
SELECT TOP 1 title FROM game_shop ORDER BY percent_returned DESC

--- figure out the companion game titles from data base, show most profitable pair
SELECT a.title, b.title, "sum.profit"=a.profit+b.profit FROM game_shop
    JOIN game_shop a
    ON game_shop.id=a.id
    JOIN game_shop b
    ON game_shop.suggested_companion_game_id=b.id
    ORDER BY "sum.profit" DESC


    
