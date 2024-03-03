/*
Covid 19 Data Exploration 

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types, Windows Functions , Queries Optimization

*/

-- Query 1 :Data Exploration
-- Simple Select *
Select *
From 
	COVID..DEATHS
Where 
	continent is not null 
order by 
	3,4

-- Query 2 :Main Columns
-- Select Data that we are going to be starting with

Select
	Location,
	date,
	total_cases, 
	new_cases, 
	total_deaths, 
	population
From 
	COVID..DEATHS
Where 
	continent is not null 
order by
	1,2


-- Query 3 :GLOBAL NUMBERS
Select 
	SUM(cast(New_Cases as float)) as total_cases,
	SUM(cast(new_deaths as float)) as total_deaths,
	(SUM(cast(new_deaths as float))/SUM(cast(New_Cases as float)))*100 as DeathPercentage
From 
	COVID..DEATHS

where 
    continent is not null 
order by
	1,2

--Query 4 : BREAKING THINGS DOWN BY CONTINENT
-- Showing contintents with the highest death count per population

Select 
	continent, 
	MAX(cast(Total_deaths as float)) as TotalDeathCount
From 
	COVID..DEATHS
Where 
	continent is not null 
Group by 
	continent
order by 
	TotalDeathCount desc

-- Query 5 : Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select 
	Location,
	date,
	Population, 
	total_cases,  
	(CONVERT(float, total_cases)/population)*100 as PercentPopulationInfected
From 
	COVID..DEATHS
order by
	1,2

--  Query 6 : Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT 
    Location, 
    date, 
    total_cases, 
    total_deaths, 
	(CONVERT(float, total_deaths) / CONVERT(float, total_cases)) * 100 AS DeathPercentage
FROM 
    COVID..DEATHS
WHERE 
    Location LIKE '%states%'
    AND continent IS NOT NULL
ORDER BY 
    1, 2;

--  Query 7 : Countries with Highest Infection rate 
-- Countries with Highest Infection Rate compared to Population
SELECT 
    Location, 
    Population, 
    MAX(total_cases) AS InfectionCount,
    (CONVERT(float, MAX(total_cases)) / Population) * 100 AS PercentPopulationInfected
FROM 
    COVID..DEATHS
GROUP BY 
    Location, 
    Population
ORDER BY 
    PercentPopulationInfected DESC;

--  Query 8 : infection Rate
-- Evolution of Infection Rate per county and per year 

SELECT
    Location,
    YEAR(date) AS Year,
    SUM(cast(new_cases as float)) AS TotalCases,
	SUM(cast(Total_deaths as float)) AS TotalDeathCount,
	max(population) as population,
	(CONVERT(float, SUM(cast(new_cases as float))) / CONVERT(float, MAX(population))) * 100 AS PercentPopulationInfected
FROM
    COVID..DEATHS
WHERE
    continent IS NOT NULL
GROUP BY
    Location,
    YEAR(date)
ORDER BY
    Location,
    YEAR(date);


--  Query 9 :Total Population vs Vaccinations
-- Countries with Highest Death Count per Population

Select 
	Location,
	MAX(cast(Total_deaths as float)) as TotalDeathCount
From 
	COVID..DEATHS
Where
	continent is not null 
Group by 
	Location
order by 
	TotalDeathCount desc

--  Query 10: Covid Impact vs Age
-- Shows the median age group of the population Impacted by Covid per country and per year 

SELECT
    d.location,
    YEAR(d.date) AS Year,
    SUM(CAST(d.new_cases AS FLOAT)) / CAST(v.population AS FLOAT) AS yearly_infection_rate,
    SUM(CAST(d.new_deaths AS FLOAT)) / CAST(v.population AS FLOAT) AS yearly_death_rate,
    CASE
        WHEN CAST(v.median_age AS FLOAT) >= 65 THEN '65>'
		WHEN CAST(v.median_age AS FLOAT) BETWEEN 40 AND 65 THEN '40> and <=65'
        ELSE '<40'
    END AS age_group
FROM
    COVID..DEATHS d
JOIN
    COVID..Vaccination v ON d.location = v.location AND YEAR(d.date) = YEAR(v.date)
WHERE
     d.location IS NOT NULL
GROUP BY
    d.location,
    YEAR(d.date),
    v.population,
    v.median_age
ORDER BY
    d.location,
    YEAR(d.date);

--  Query 11-1: Total Population vs Vaccinations
-- Using  Double CTE to perform Calculation on Partition By in previous query

WITH EconomicVaccination AS (
    SELECT
        location,
		population,
        YEAR(date) AS Year,
        CAST(extreme_poverty AS FLOAT) AS extreme_poverty,
        CAST(human_development_index AS FLOAT) AS human_development_index,
        CAST(total_vaccinations AS FLOAT) as total_vaccinations,
        CAST(people_vaccinated AS FLOAT) as people_vaccinated,
        CAST(people_fully_vaccinated AS FLOAT) as people_fully_vaccinated 
    FROM
        COVID..Vaccination
    WHERE
        location IS NOT NULL
),

EconomicVaccinationCondition AS (
    SELECT
        Location,
        Year,
        AVG(total_vaccinations)/max(population)  avg_total_vaccinations,
        AVG(people_vaccinated)/max(population)  avg_people_vaccinated,
        AVG(people_fully_vaccinated)/max(population)  avg_people_fully_vaccinated,
        CASE
            WHEN extreme_poverty >= 30 THEN 'High Extreme Poverty'
            WHEN human_development_index <= 0.5 THEN 'Low Human Development Index'
            ELSE 'Moderate Economic Conditions'
        END AS economic_condition
    FROM
        EconomicVaccination
    GROUP BY
        Location,
        Year,
        extreme_poverty,
        human_development_index
)

SELECT  
    year,
	economic_condition,
    Avg(avg_total_vaccinations),
    Avg(avg_people_vaccinated),
    Avg(avg_people_fully_vaccinated)
FROM
    EconomicVaccinationCondition
GROUP BY
    economic_condition,
    year
ORDER BY
    year,
	economic_condition;

--  Query 11-2: Total Population vs Vaccinations
-- Including Temp Table to perform Calculation on Partition By in previous query

-- Create the temporary table to store EconomicVaccination data
CREATE TABLE #TempEconomicVaccination (
    Location VARCHAR(255),
	Year INT,
    Population FLOAT,
    ExtremePoverty FLOAT,
    HumanDevelopmentIndex FLOAT,
    TotalVaccinations FLOAT,
    PeopleVaccinated FLOAT,
    PeopleFullyVaccinated FLOAT
);

-- Insert data into the temporary table
INSERT INTO #TempEconomicVaccination (Location, Year, Population, ExtremePoverty, HumanDevelopmentIndex, TotalVaccinations, PeopleVaccinated, PeopleFullyVaccinated)
SELECT
    location,
	YEAR(date) AS Year,
    CAST(population AS FLOAT) AS Population,
    CAST(extreme_poverty AS FLOAT) AS ExtremePoverty,
    CAST(human_development_index AS FLOAT) AS HumanDevelopmentIndex,
    CAST(total_vaccinations AS FLOAT) AS TotalVaccinations,
    CAST(people_vaccinated AS FLOAT) AS PeopleVaccinated,
    CAST(people_fully_vaccinated AS FLOAT) AS PeopleFullyVaccinated
FROM
    COVID..Vaccination
WHERE
    location IS NOT NULL;

-- Query using the temporary table to calculate EconomicVaccinationCondition
WITH EconomicVaccinationCondition AS (
    SELECT
        Location,
        Year,
        AVG(TotalVaccinations) / MAX(Population) AS AvgTotalVaccinations,
        AVG(PeopleVaccinated) / MAX(Population) AS AvgPeopleVaccinated,
        AVG(PeopleFullyVaccinated) / MAX(Population) AS AvgPeopleFullyVaccinated,
        CASE
            WHEN ExtremePoverty >= 30 THEN 'High Extreme Poverty'
            WHEN HumanDevelopmentIndex <= 0.5 THEN 'Low Human Development Index'
            ELSE 'Moderate Economic Conditions'
        END AS EconomicCondition
    FROM
        #TempEconomicVaccination
    GROUP BY
        Location,
        Year,
        ExtremePoverty,
        HumanDevelopmentIndex
)

-- Final query to get the desired result
SELECT  
    Year,
	EconomicCondition AS Economic_Condition,
    AVG(AvgTotalVaccinations) AS Avg_Total_Vaccinations,
    AVG(AvgPeopleVaccinated) AS Avg_People_Vaccinated,
    AVG(AvgPeopleFullyVaccinated) AS Avg_People_Fully_Vaccinated
FROM
    EconomicVaccinationCondition
GROUP BY
    Year,
    EconomicCondition
ORDER BY
    Year,
	EconomicCondition;
-- Drop the temporary table after use
DROP TABLE #TempEconomicVaccination;


--  Query 12: Vaccination Tracking
-- Creating View to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT 
    dea.continent, 
    dea.location, 
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS float)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM 
    COVID..DEATHS dea
JOIN 
    COVID..Vaccination vac
ON 
    dea.location = vac.location
    AND dea.date = vac.date
WHERE 
    dea.continent IS NOT NULL;

Select 
	*
from 
	PercentPopulationVaccinated

--  Query 13:Year to Year Total Cases Evolution
-- comparing for each country of the total cases year by year using Windows functions 


WITH YearlyCases AS (
    SELECT
        location,
        YEAR(date) AS Year,
        SUM(COALESCE(cast(new_cases as float), 0)) AS total_cases
    FROM
        COVID..DEATHS
    WHERE
        continent IS NOT NULL
    GROUP BY
        location,
        YEAR(date)
)

SELECT
    location,
    Year AS Current_Year,
    total_cases AS Current_Year_Total_Cases,
    COALESCE(LAG(total_cases) OVER (PARTITION BY location ORDER BY Year), 0) AS Previous_Year_Total_Cases,
    CASE
        WHEN total_cases > COALESCE(LAG(total_cases) OVER (PARTITION BY location ORDER BY Year), 0) THEN 'Increase'
        WHEN total_cases < COALESCE(LAG(total_cases) OVER (PARTITION BY location ORDER BY Year), 0) THEN 'Decrease'
        ELSE 'No Change'
    END AS Evolution
FROM
    YearlyCases
ORDER BY
    location,
    Year;


--  Query 14-1. Monthly Increase Status
-- the count of months where the number of cases increased per country for each year


WITH CasesByMonth AS (
    SELECT
        location,
        YEAR(date) AS Year,
        MONTH(date) AS Month,
        SUM(CAST(new_cases AS FLOAT)) AS total_cases,
        LAG(SUM(CAST(new_cases AS FLOAT))) OVER (PARTITION BY location, YEAR(date) ORDER BY MONTH(date)) AS prev_month_total_cases
    FROM
        COVID..DEATHS
    WHERE
        location IS NOT NULL
    GROUP BY
        location,
        YEAR(date),
        MONTH(date)
)
SELECT
    location AS country,
    Year,
    COUNT(DISTINCT Month) AS distinct_months_with_increase
FROM
    CasesByMonth
WHERE
    total_cases > COALESCE(prev_month_total_cases, 0)  -- Significant increase condition
GROUP BY
    location,
    Year;

--  Query 14-2. Monthly Increase Status Optimised Query
-- the count of months where the number of cases increased per country for each year using an optimized query

WITH CasesByMonth AS (
    SELECT
        location,
        YEAR(date) AS Year,
        MONTH(date) AS Month,
        SUM(CAST(new_cases AS FLOAT)) AS total_cases,
        LAG(SUM(CAST(new_cases AS FLOAT))) OVER (PARTITION BY location, YEAR(date) ORDER BY MONTH(date)) AS prev_month_total_cases
    FROM
        COVID..DEATHS
    WHERE
        location IS NOT NULL
    GROUP BY
        location,
        YEAR(date),
        MONTH(date)
)

SELECT
    location AS country,
    Year,
    cardinality(merge(approx_set(Month))) AS distinct_months_with_increase_approx
FROM
    CasesByMonth
WHERE
    total_cases > COALESCE(prev_month_total_cases, 0)  -- Significant increase condition
GROUP BY
    location,
    Year;
