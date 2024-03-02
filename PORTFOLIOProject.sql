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

--  Query 10-1: Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

Select 
	dea.continent,
	dea.location, 
	dea.date,
	dea.population, 
	vac.new_vaccinations, 
	SUM(cast(vac.new_vaccinations as float)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From 
	COVID..DEATHS dea
Join 
	COVID..Vaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where
	dea.continent is not null 
	AND dea.Location LIKE '%United States%'
order by
	2,3

--  Query 10-2: Total Population vs Vaccinations
-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select 
	dea.continent,
	dea.location, 
	dea.date,
	dea.population, 
	vac.new_vaccinations, 
	SUM(cast(vac.new_vaccinations as float)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From 
	COVID..DEATHS dea
Join 
	COVID..Vaccination vac
	On dea.location = vac.location
	   and dea.date = vac.date
where
	dea.continent is not null 
	and  dea.Location LIKE '%United States%'
)
Select 
	*, 
	(RollingPeopleVaccinated/Population)*100 as porcentage_of_population_vaccinated
From 
	PopvsVac

--  Query 10-3: Total Population vs Vaccinations
-- Using Temp Table to perform Calculation on Partition By in previous query

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into
	#PercentPopulationVaccinated
Select 
	dea.continent, 
	dea.location, 
	dea.date, 
	dea.population, 
	vac.new_vaccinations,
	SUM(cast(vac.new_vaccinations as float)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From 
	COVID..DEATHS dea
Join 
	COVID..Vaccination vac
	On dea.location = vac.location
	and dea.date = vac.date


Select 
	*, 
	(RollingPeopleVaccinated/Population)*100
From
	#PercentPopulationVaccinated

--  Query 11: Vaccination Tracking
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

--  Query 12:Year to Year Total Cases Evolution
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


--  Query 13-1. Monthly Increase Status
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

--  Query 13-2. Monthly Increase Status Optimised Query
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




