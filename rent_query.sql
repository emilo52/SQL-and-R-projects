--view table

SELECT * FROM house_rent_data;

--view rent by number of bathrooms
SELECT AVG(Rent) as "Average Rent", Bathroom as "Number of Bathrooms" FROM house_rent_data GROUP BY Bathroom ORDER BY Bathroom;

--view rent by square feet of apartment, view by number of bathrooms in apartment
SELECT AVG(Rent/Size) AS "Rent per square feet", Bathroom AS "Number of Bathrooms" FROM house_rent_data GROUP BY Bathroom ORDER BY Bathroom;

--view rent and tenant preferred over furnishing_status
SELECT AVG(Rent) AS "Average Rent", Tenant_Preferred,
    CASE 
        WHEN Furnishing_Status='Unfurnished' THEN 'Not Furnished'
        WHEN Furnishing_Status= 'Semi-Furnished' THEN 'Some Furnishing'
        WHEN Furnishing_Status='Furnished' THEN 'Fully Furnished'
        ELSE 'NA'

    END AS "apartment furnishings"
FROM house_rent_data
GROUP BY Furnishing_status, Tenant_Preferred
ORDER BY AVG(Rent);

-- make up a table that we can join together

IF OBJECT_ID('fake_rent_stats', 'U') IS NOT NULL 
    DROP TABLE fake_rent_stats;

CREATE TABLE fake_rent_stats
(
id int IDENTITY(1,1) PRIMARY KEY,
Furnishing_Status NVARCHAR (50),
number_of_applications NUMERIC,
tenant_income NUMERIC,
rental_taxes NUMERIC,

);

--insert data into fake rent stats
INSERT INTO fake_rent_stats 
(Furnishing_Status, number_of_applications, tenant_income, rental_taxes)
VALUES ('Furnished', 72, 80000, 200);

INSERT INTO fake_rent_stats 
(Furnishing_Status, number_of_applications, tenant_income, rental_taxes)
VALUES ('Semi-Furnished', 90, 100000, 500);

INSERT INTO fake_rent_stats 
(Furnishing_Status, number_of_applications, tenant_income, rental_taxes)
VALUES ('Unfurnished', 150, 50000, 50);

--view fake rent stats table
SELECT*FROM fake_rent_stats

--do a join to view average number of applications over furnishing_status and average apartment size
SELECT AVG(Size) AS "Average apartment size", AVG(Rent) AS "Average rent", house_rent_data.Furnishing_Status, fake_rent_stats.number_of_applications FROM house_rent_data
LEFT OUTER JOIN fake_rent_stats
ON house_rent_data.Furnishing_Status=fake_rent_stats.Furnishing_Status
GROUP BY house_rent_data.Furnishing_Status, fake_rent_stats.number_of_applications;

--add a column to indicate where we want to delete
ALTER TABLE house_rent_data
ADD col_delete NVARCHAR (50);

-- create a new table where we will delete rows from furnished apartments
select * into new_rent_no_furnish from house_rent_data;

--check to make sure it is a copy
SELECT * FROM new_rent_no_furnish;

--set column delete to equal true where we want to delete rows (furnished apartments)
UPDATE new_rent_no_furnish SET col_delete='TRUE' WHERE Furnishing_Status='Furnished';

--delete rows where col_delete = true
DELETE new_rent_no_furnish WHERE col_delete='TRUE';

--check that furnished apartments are no longer in our data base
SELECT * FROM new_rent_no_furnish WHERE Furnishing_Status='Furnished';