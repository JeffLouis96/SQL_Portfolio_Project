-- QUICK GLANCE OF THE DEATH DATA IN Alphabetical order and the earliest recorded case
SELECT *
FROM covid_data
ORDER BY 3,4
LIMIT 100;

-- QUICK GLANCE OF THE VACCINATIONS DATA IN Alphabetical order and the earliest recorded case
SELECT *
FROM covidvaccinations
ORDER BY 3,4
LIMIT 10;

-- INSERTING THE COLUMN THAT GOING TO BE USE FOR MAJORITY OF  ANALYSIS INTO A CTE

WITH deathCase_report AS (
	SELECT location, continent, date, total_cases, new_cases, total_deaths,  population
		FROM covid_data
	ORDER BY 3,4
)
-- CALCULATE THE POPULATION OF THE EACH CONTINENT USING AGGREGATE FUNCTION USING GROUPBY 
SELECT continent, max(population)
FROM deathCase_report
Where continent IS NOT NULL
group by continent
order by max(population) desc;

-- LOOKNG AT TOTAL CASES VS TOTALDEATHS
SELECT location,date, total_cases, total_deaths, ROUND(((total_deaths/total_cases)* 100),2) AS Death_Percentage
FROM covid_data
--WHERE LOCATION = 'Haiti'
-- WHERE total_cases IS NOT NULL AND total_deathS IS NOT NULL
ORDER BY 1,2 ;

-- LOOKNG AT TOTAL CASES VS TOTAL POPULATION 
SELECT location, date, total_cases, population, (total_cases/population)* 100 AS population_infected_Percentage
FROM covid_data
WHERE location LIKE '%States%' AND total_cases IS NOT NULL 
ORDER BY 1,2;

-- LOOKING AT CONTINENT WITH HIGHEST INFECTION RATES COMPARE TO POPULATION 

SELECT continent, MAX(total_cases) AS max_cases, population,  MAX((total_cases/population)*100) AS population_infected_Percentage
FROM covid_data
WHERE  total_cases IS NOT NULL and continent IS NOT NULL
GROUP BY continent,population
ORDER BY population_infected_Percentage DESC;

--LOOKING AT country WITH HIGHEST INFECTION RATES COMPARE TO POPULATION

SELECT location, MAX(total_cases) AS max_cases, population,  MAX((total_cases/population)*100) AS population_infected_Percentage
FROM covid_data
WHERE  total_cases IS NOT NULL
GROUP BY location,population
ORDER BY population_infected_Percentage DESC;

-- LOOKING AT COUNTRY WITH THE HIGHEST DEATH RATE PERCENTAGE

SELECT location, MAX(total_deaths) AS max_deaths
FROM covid_data
WHERE total_deaths IS NOT NULL and continent IS NOT NULL
GROUP BY location
ORDER BY max_deaths DESC;

---- LOOKING AT THE CONTINENT WITH THE HIGHEST DEATH COUNT 

SELECT continent, MAX(total_deaths) AS max_deaths
FROM covid_data
WHERE total_deaths IS NOT NULL and continent IS NOT NULL
GROUP BY continent
ORDER BY max_deaths DESC;

-- GLOBAL NUMBER

-- LOOKNG AT TOTAL CASES VS TOTALDEATHS BY CONTINENT
SELECT date, SUM(new_cases) AS sum_cases , SUM(new_deaths) AS sum_death, CAST(SUM(new_deaths) AS NUMERIC) /SUM(new_cases) * 100 AS  TotalDeath_per
FROM covid_data
WHERE  continent IS NOT NULL
AND total_cases IS NOT NULL AND total_deathS IS NOT NULL and new_deaths <>0 and new_cases <> 0 
GROUP BY date
ORDER BY 1,2 ;

-- QUICK GLANCE OF BOTH TABLE JOIN TOGETHER USING A INNER A JOIN
SELECT *
FROM covid_data as cd
 JOIN covidvaccinations as cv
USING(date,location);

-- LOOKING AT CONTINENT WITH HIGHEST VACCINATION RATE  COMPARE TO POPULATION

SELECT cd.continent, cd.location,cd.date,cd.population,cv.new_vaccinations--,  cv.new_vaccinations/cd.population *100 AS PopulationVac_percentage 
FROM covid_data as cd
 JOIN covidvaccinations as cv
USING(date,location) 
WHERE cv.new_vaccinations IS NOT NULL and cd.continent IS NOT NULL
ORDER BY date ASC;

-- LOOKING AT VACCINATION ROLLINg COUNT

SELECT cd.continent, cd.location,cd.date,cd.population,cv.new_vaccinations,
SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.location,cd.date ) as rolling_vac
FROM covid_data as cd
 JOIN covidvaccinations as cv
USING(date,location) 
WHERE cv.new_vaccinations IS NOT NULL and cd.continent IS NOT NULL
ORDER BY 2,3 ASC;

-- ALLOW TEMP TABLE TO RUN INFINITE NUMBER OF TIMES
DROP TABLE IF EXISTS PopulationVac_percentage;
-- TEMP TABLE
CREATE TABLE PopulationVac_percentage (
continent varchar(255) ,
location varchar(255),
date date,
population numeric,
new_vaccinations numeric,
rolling_vac numeric
);

INSERT INTO PopulationVac_percentage(
SELECT cd.continent, cd.location,cd.date,cd.population,cv.new_vaccinations,
SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.location,cd.date ) as rolling_vac
FROM covid_data as cd
 JOIN covidvaccinations as cv
USING(date,location) 
WHERE cv.new_vaccinations IS NOT NULL and cd.continent IS NOT NULL
ORDER BY 2,3 ASC
);
-- TEST TEMP TABLE
SELECT *
FROM PopulationVac_percentage;

-- RETRIVE DATA FROM TEMP TABLE TO CALCULATE ROLLING VACCINATION PERCENTAGE

SELECT *, (rolling_vac/population)* 100
FROM populationVac_percentage;

-- ALLOW VIEW TABLE TO RUN INFINITE NUMBER OF TIMES
DROP VIEW IF EXISTS PopulationVac_per_View;

-- CREATE VIEW FOR VISUALIZATIONS 

CREATE VIEW PopulationVac_per_View AS
SELECT cd.continent, cd.location,cd.date,cd.population,cv.new_vaccinations,
SUM(cv.new_vaccinations) OVER(PARTITION BY cd.location ORDER BY cd.location,cd.date ) as rolling_vac
FROM covid_data as cd
 JOIN covidvaccinations as cv
USING(date,location) 
WHERE cv.new_vaccinations IS NOT NULL and cd.continent IS NOT NULL
--ORDER BY 2,3 ASC
;

-- TEST VIEW 

SELECT *
FROM PopulationVac_per_View