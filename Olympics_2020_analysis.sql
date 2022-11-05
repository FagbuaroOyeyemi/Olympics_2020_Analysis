--To view the contents of the datasets individually
SELECT *
FROM athletes
SELECT *
FROM gender
SELECT *
FROM coaches
SELECT *
FROM medals
SELECT *
FROM teams

--Checking for duplicate values in the datasets
SELECT name,country,discipline,count(*)
FROM athletes
GROUP BY name,country,discipline
HAVING count(*) > 1;
SELECT name, country, discipline, event, count(*)
FROM coaches
GROUP BY name, country, discipline, event
HAVING count(*) > 1
SELECT discipline,female,male,total,count(*)
FROM gender
GROUP BY discipline,female,male,total
HAVING count(*) > 1
SELECT country, gold, silver,bronze,total, rank_by_total, count(*)
FROM medals
GROUP BY country, gold, silver, bronze, total, rank_by_total
HAVING count(*) > 1;
SELECT country, discipline, event, count(*)
FROM teams
GROUP BY country, discipline, event
HAVING count(*) > 1;

--Checking for null values in the datasets
SELECT *
FROM athletes
WHERE name IS null
SELECT *
FROM athletes
WHERE country IS null
SELECT *
FROM athletes
WHERE discipline IS null
SELECT *
FROM coaches
WHERE name IS null
SELECT *
FROM coaches
WHERE country IS null
SELECT *
FROM coaches
WHERE discipline IS null
SELECT *
FROM coaches
WHERE event IS null
SELECT *
FROM gender
WHERE discipline IS null
SELECT *
FROM gender
WHERE female IS null
SELECT *
FROM gender
WHERE male IS null
SELECT *
FROM gender
WHERE total IS null
SELECT *
FROM medals
WHERE country IS null
SELECT *
FROM medals
WHERE gold IS null
SELECT *
FROM medals
WHERE silver IS null
SELECT *
FROM medals
WHERE bronze IS null
SELECT *
FROM medals
WHERE total IS null
SELECT *
FROM medals
WHERE rank_by_total IS null
SELECT *
FROM teams
WHERE country IS null
SELECT *
FROM teams
WHERE discipline IS null
SELECT *
FROM teams
WHERE event IS null

--Checking for the number of participating countries
SELECT COUNT(DISTINCT country) AS number_of_countries
FROM athletes

--Checking for the number of Discipline
SELECT COUNT(DISTINCT discipline) AS number_of_discipline
FROM athletes

--Checking for the number of participants
SELECT SUM(total) AS number_of_participants
FROM gender

--Gender Distribution
SELECT SUM(male) AS total_male_participants, SUM(female) AS total_female_participants
FROM gender

--Top 10 Countries by number of participants
SELECT DISTINCT a.country, SUM(g.male)total_male, 
SUM(g.female)total_female, SUM(g.total)total_participants
FROM athletes a
LEFT JOIN gender g
on a.discipline = g.discipline
GROUP BY a.country
ORDER BY total_participants DESC LIMIT 10

--Top 10 Countries by their participation in discipline
SELECT a.country, COUNT(DISTINCT g.discipline) AS total_discipline
FROM athletes a
LEFT JOIN gender g
on a.discipline = g.discipline
GROUP BY a.country
ORDER BY total_discipline DESC LIMIT 10

--Top 10 Countries by number of medals won
SELECT country, total
FROM medals
ORDER BY total DESC LIMIT 10

--Top 10 Discipline by Male Gender
SELECT discipline, SUM(male) total_male
FROM gender
GROUP BY discipline 
ORDER BY total_male DESC LIMIT 10

--Top 10 Discipline by Female Gender
SELECT discipline, SUM(female) total_female
FROM gender
GROUP BY discipline 
ORDER BY total_female DESC LIMIT 10

-- Top 10 Discipline with the Highest number of Participants
SELECT discipline, total
FROM gender
ORDER BY total DESC LIMIT 10

--Top 10 Countries by the number of Coaches
SELECT DISTINCT country, COUNT(name) number_of_coaches
FROM coaches
GROUP BY country
ORDER BY number_of_coaches DESC LIMIT 10

--Medal distribution of the United States of America (THE CHAMPION OF OLYMPICS 2020)
SELECT country, gold, silver, bronze
FROM medals
WHERE country = 'United States of America'