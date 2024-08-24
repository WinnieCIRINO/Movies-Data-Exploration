
-- Viewing data
SELECT * FROM Movies_Project

-- Extract column from released column
--- SUBSTRING(string, start position, number of characters)
SELECT *, 
SUBSTRING(
	released, -- string
	CHARINDEX('(', released ) + 1, --start position
	CHARINDEX(')', released)- CHARINDEX('(', released) -1
	) AS ReleasedCountry
	INTO Movies_Prep
FROM Movies_Project 

SELECT * FROM Movies_Prep
-- 1.	What are the top 3 ratings for movies released in the United States.

SELECT TOP(3) rating, COUNT(rating) AS Number_of_ratings
INTO United_States_Top_3_Ratings
FROM Movies_Prep
WHERE ReleasedCountry = 'United States'
GROUP BY rating
ORDER BY Number_of_ratings DESC;

-- 2.	What are the top 10 companies based on number of movies
SELECT TOP(10) company, COUNT(name) AS No_of_movies
INTO Top_10_Companies
FROM Movies_Prep
GROUP BY company
ORDER BY No_of_movies DESC;

-- 3. What are the top 10 companies in the United Kingdom based on movie revenue
SELECT TOP (10) company, SUM(gross) AS Total_Revenue
INTO UnitedKingdom_Top_10_companies
FROM Movies_Prep
WHERE ReleasedCountry = 'United Kingdom'
GROUP BY company
ORDER BY Total_Revenue DESC;

-- 4. What are the top 10 compaines in the countries that begin with "I"  based on the movie revenue? (released country)
SELECT TOP(10) company, SUM(gross) AS TotalRevenue
INTO Top_10_Companies_with_I_Countries
FROM Movies_Prep
WHERE ReleasedCountry LIKE 'I%'
GROUP BY company
ORDER BY TotalRevenue DESC;


-- 5. What is the average movie time for movies in France and any country that contains Germany (released country)
SELECT AVG(runtime) AS AverageTime
INTO Average_Movie_Time
FROM Movies_Prep
WHERE ReleasedCountry = 'France' OR ReleasedCountry LIKE '%Germany&'

-- 6. As a single analyst, what is the average movie time for moviews with title that contain 'love'?
SELECT ROUND(AVG(runtime),2) AS AverageTime
INTO Love_Average_Movie_Time
FROM Movies_Prep
WHERE name LIKE '%love%'

-- 7. Which company has generated most revenue? How much did they make in 2018?
SELECT company, SUM(gross) AS TotalRevenue
FROM Movies_Prep
-- WHERE year = 2018
GROUP BY company
ORDER BY TotalRevenue DESC;

SELECT SUM(gross) AS 'Warner Bros Revenue (2018)'
FROM Movies_Prep
WHERE company = 'Warner Bros.' AND year = 2018

-- Which star has been featured in most movies? What are the top 3 movies genre he/she has acted in?
SELECT star, COUNT(name) AS 'No of time star appeared'
FROM Movies_Prep
GROUP BY star
ORDER BY COUNT(name) DESC

SELECT TOP(3) COUNT(genre) AS 'Total Genre'
FROM Movies_Prep
WHERE star = 'Nicolas Cage'
GROUP BY genre
ORDER BY COUNT(genre) DESC;


-- Which movie genre is most popular in India? What is the average revenue generated for this genre in India? (Country of origin)
SELECT genre, COUNT(genre)
FROM Movies_Prep
WHERE country = 'India'
GROUP BY genre
ORDER BY COUNT(genre) DESC

SELECT AVG(gross) AS TotalRevenue
FROM Movies_Prep
WHERE genre = 'Action' AND country = 'India'


-- How many movies start with a consonant letter?
SELECT COUNT(name) AS 'Number of Movies'
FROM Movies_Prep
WHERE name LIKE '[bcdfghjklmnpqrstvwxyz]%'

SELECT COUNT(name) AS 'Number of Movies'
FROM Movies_Prep
WHERE name LIKE '[aeiou]%'

SELECT COUNT(name) AS 'Number of Movies'   --- This would be an alternative, but there are names starting with numbers instead
FROM Movies_Prep
WHERE name NOT LIKE '[aeiou]%'




SELECT *
FROM Movies_Prep