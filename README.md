# SQL_Portfolio_Project

README
Link to Dataset: https://ourworldindata.org/covid-deaths

This repository contains SQL code for analyzing COVID-19 data and vaccination data. The code provides various queries to gain insights into the pandemic's impact, including death data, vaccination rates, and population statistics. Below is a numbered list summarizing the SQL queries and their purpose:

1. QUICK GLANCE OF THE DEATH DATA IN Alphabetical order and the earliest recorded case**:
   - Retrieves the first 100 records from the `covid_data` table, sorted alphabetically by location and date.

2. QUICK GLANCE OF THE VACCINATIONS DATA IN Alphabetical order and the earliest recorded case**:
   - Retrieves the first 10 records from the `covidvaccinations` table, sorted alphabetically by location and date.

3. INSERTING THE COLUMN THAT GOING TO BE USE FOR THE MAJORITY OF ANALYSIS INTO A CTE**:
   - Creates a Common Table Expression (CTE) named `deathCase_report` to store selected columns from the `covid_data` table, sorted by date.

4. CALCULATE THE POPULATION OF EACH CONTINENT USING AGGREGATE FUNCTION USING GROUP BY**:
   - Calculates the maximum population for each continent from the `deathCase_report` CTE, excluding null values, and orders the results in descending order of population.

5. LOOKING AT TOTAL CASES VS TOTAL DEATHS**:
   - Retrieves the location, date, total cases, total deaths, and death percentage for each record in the `covid_data` table, ordered by location and date.

6. LOOKING AT TOTAL CASES VS TOTAL POPULATION**:
   - Retrieves the location, date, total cases, population, and percentage of population infected for records in the `covid_data` table where the location contains "States" and total cases are not null, ordered by location and date.

7. LOOKING AT CONTINENT WITH HIGHEST INFECTION RATES COMPARED TO POPULATION**:
   - Retrieves the continent, maximum total cases, population, and population infected percentage for each continent from the `covid_data` table, excluding null values, grouped by continent and population, and ordered by       population infected percentage in descending order.

8. LOOKING AT COUNTRY WITH HIGHEST INFECTION RATES COMPARED TO POPULATION**:
   - Retrieves the location, maximum total cases, population, and population infected percentage for each country from the `covid_data` table, excluding null values, grouped by location and population, and ordered by           population infected percentage in descending order.

9. LOOKING AT COUNTRY WITH THE HIGHEST DEATH RATE PERCENTAGE**:
   - Retrieves the location and maximum total deaths for each country from the `covid_data` table, excluding null values, grouped by location, and ordered by the number of total deaths in descending order.

10. **LOOKING AT THE CONTINENT WITH THE HIGHEST DEATH COUNT**:
    - Retrieves the continent and maximum total deaths for each continent from the `covid_data` table, excluding null values, grouped by continent, and ordered by the number of total deaths in descending order.

11. GLOBAL NUMBER**:
    - Retrieves the date, sum of new cases, sum of new deaths, and the percentage of total deaths for each date from the `covid_data` table, excluding null values, where new deaths and new cases are not zero, grouped by date, and ordered by date and the sum of new cases.

12. QUICK GLANCE OF BOTH TABLE JOIN TOGETHER USING AN INNER JOIN**:
    - Retrieves all columns from the `covid_data` and `covidvaccinations` tables where the date and location match.

13. LOOKING AT CONTINENT WITH THE HIGHEST VACCINATION RATE COMPARED TO POPULATION**:
    - Retrieves the continent, location, date, population, and new vaccinations for each record in the `covid_data` and `covidvaccinations` tables, where new vaccinations are not null and the continent is not null, ordered by date in ascending order.

14. LOOKING AT VACCINATION ROLLING COUNT**:
    - Retrieves the continent, location, date, population, new vaccinations, and rolling vaccination count for each record in the `covid_data` and `covidvaccinations` tables, where new vaccinations are not null and the continent is not null, ordered by location and date in ascending order.

15. **TEMP TABLE AND ROLLING VACCINATION PERCENTAGE**:
    - Creates a temporary table named `PopulationVac_percentage` to store the results of the previous query and calculates the rolling vaccination percentage for each record.

16. VIEW TABLE AND VISUALIZATIONS**:
    - Creates a view named `PopulationVac_per_View` to provide easy access to the combined COVID-19 and vaccination data from the `covid_data` and `covidvaccinations` tables.
