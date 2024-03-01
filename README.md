![COVID](https://scwcontent.affino.com/AcuCustom/Sitename/DAM/022/data_graph__virus_Adobe.jpg)

# Covid Historical Data Analysis Using SQL

This repo contains an analysis of the Covid Historical Dataset from 2020 until 2024 using SQL queries, the repo showcases the usage of a diversified range of Sql queries, starting from simple and basic queries until  medium and complex queries using joins, windows functions, CTE, Views, and queries optimization.

## 1. Objectives
the main objective of this project is to Analyse the Covid Dataset and answer different Questions using SQL queries. 

## 2. Data Sources

The data analyzed in this project are public data from [ourworldindata](https://ourworldindata.org/covid-deaths).

### **Sample Data** 
 1. **Death table** 

|       | iso_code   | continent     | location      | date                |      total_cases |   new_cases |   new_cases_smoothed |   total_deaths |   new_deaths |   new_deaths_smoothed |   total_cases_per_million |   new_cases_per_million |   new_cases_smoothed_per_million |   total_deaths_per_million |   new_deaths_per_million |   new_deaths_smoothed_per_million |   reproduction_rate |   icu_patients |   icu_patients_per_million |   hosp_patients |   hosp_patients_per_million |   weekly_icu_admissions |   weekly_icu_admissions_per_million |   weekly_hosp_admissions |   weekly_hosp_admissions_per_million |   new_tests |   total_tests |   total_tests_per_thousand |   new_tests_per_thousand |   new_tests_smoothed |   new_tests_smoothed_per_thousand |   positive_rate |   tests_per_case | tests_units   |   total_vaccinations |   people_vaccinated |   people_fully_vaccinated |   new_vaccinations |   new_vaccinations_smoothed |   total_vaccinations_per_hundred |   people_vaccinated_per_hundred |   people_fully_vaccinated_per_hundred |   new_vaccinations_smoothed_per_million |   stringency_index |   population |   population_density |   median_age |   aged_65_older |   aged_70_older |   gdp_per_capita |   extreme_poverty |   cardiovasc_death_rate |   diabetes_prevalence |   female_smokers |   male_smokers |   handwashing_facilities |   hospital_beds_per_thousand |   life_expectancy |   human_development_index |
|------:|:-----------|:--------------|:--------------|:--------------------|-----------------:|------------:|---------------------:|---------------:|-------------:|----------------------:|--------------------------:|------------------------:|---------------------------------:|---------------------------:|-------------------------:|----------------------------------:|--------------------:|---------------:|---------------------------:|----------------:|----------------------------:|------------------------:|------------------------------------:|-------------------------:|-------------------------------------:|------------:|--------------:|---------------------------:|-------------------------:|---------------------:|----------------------------------:|----------------:|-----------------:|:--------------|---------------------:|--------------------:|--------------------------:|-------------------:|----------------------------:|---------------------------------:|--------------------------------:|--------------------------------------:|----------------------------------------:|-------------------:|-------------:|---------------------:|-------------:|----------------:|----------------:|-----------------:|------------------:|------------------------:|----------------------:|-----------------:|---------------:|-------------------------:|-----------------------------:|------------------:|--------------------------:|
| 35866 | IDN        | Asia          | Indonesia     | 2021-03-25 00:00:00 |      1.48256e+06 |        6107 |             5529.43  |          40081 |           98 |               134.143 |                   5420.22 |                  22.327 |                           20.216 |                    146.536 |                    0.358 |                             0.49  |                0.92 |            nan |                    nan     |             nan |                     nan     |                     nan |                                 nan |                      nan |                                  nan |       53162 |   8.22968e+06 |                     30.088 |                    0.194 |                45983 |                             0.168 |           0.12  |              8.3 | people tested |          9.74565e+06 |         6.73046e+06 |               3.01519e+06 |                nan |                      422623 |                             3.56 |                            2.46 |                                   1.1 |                                    1545 |              68.98 |  2.73524e+08 |              145.725 |         29.3 |           5.319 |           3.053 |         11188.7  |               5.7 |                 342.864 |                  6.32 |              2.8 |           76.1 |                   64.204 |                         1.04 |             71.72 |                     0.718 |
| 32577 | GNB        | Africa        | Guinea-Bissau | 2020-09-30 00:00:00 |   2324           |           0 |                0     |             39 |            0 |                 0     |                   1180.9  |                   0     |                            0     |                     19.817 |                    0     |                             0     |                0.27 |            nan |                    nan     |             nan |                     nan     |                     nan |                                 nan |                      nan |                                  nan |         nan | nan           |                    nan     |                  nan     |                  nan |                           nan     |         nan     |            nan   | nan           |        nan           |       nan           |             nan           |                nan |                         nan |                           nan    |                          nan    |                                 nan   |                                     nan |             nan    |  1.968e+06   |               66.191 |         19.4 |           3.002 |           1.565 |          1548.67 |              67.1 |                 382.474 |                  2.42 |            nan   |          nan   |                    6.403 |                       nan    |             58.32 |                     0.48  |
| 58947 | PSE        | Asia          | Palestine     | 2020-07-25 00:00:00 |  10306           |         213 |              300.286 |             75 |            5 |                 2.286 |                   2020.22 |                  41.753 |                           58.863 |                     14.702 |                    0.98  |                             0.448 |                0.87 |            nan |                    nan     |             nan |                     nan     |                     nan |                                 nan |                      nan |                                  nan |         nan | nan           |                    nan     |                  nan     |                  nan |                           nan     |         nan     |            nan   | nan           |        nan           |       nan           |             nan           |                nan |                         nan |                           nan    |                          nan    |                                 nan   |                                     nan |              83.33 |  5.10142e+06 |              778.202 |         20.4 |           3.043 |           1.726 |          4449.9  |               1   |                 265.91  |                 10.59 |            nan   |          nan   |                  nan     |                       nan    |             74.05 |                     0.708 |
| 33978 | HND        | North America | Honduras      | 2021-03-12 00:00:00 | 177168           |         741 |              655.857 |           4325 |           14 |                13.429 |                  17887.4  |                  74.814 |                           66.217 |                    436.665 |                    1.413 |                             1.356 |                1.02 |            nan |                    nan     |             nan |                     nan     |                     nan |                                 nan |                      nan |                                  nan |         nan | nan           |                    nan     |                  nan     |                  nan |                           nan     |         nan     |            nan   | nan           |        nan           |       nan           |             nan           |                nan |                         276 |                           nan    |                          nan    |                                 nan   |                                      28 |              82.41 |  9.90461e+06 |               82.805 |         24.9 |           4.652 |           2.883 |          4541.8  |              16   |                 240.208 |                  7.21 |              2   |          nan   |                   84.169 |                         0.7  |             75.27 |                     0.634 |
| 28176 | FRA        | Europe        | France        | 2021-01-14 00:00:00 |      2.90972e+06 |       21431 |            17834.3   |          69452 |          284 |               353.857 |                  42697.3  |                 314.479 |                          261.701 |                   1019.14  |                    4.167 |                             5.193 |                1.11 |           2716 |                     39.855 |           24983 |                     366.601 |                     nan |                                 nan |                      nan |                                  nan |      327255 | nan           |                    nan     |                    4.802 |               282839 |                             4.15  |           0.065 |             15.4 | people tested |     341401           |    341401           |             nan           |              79498 |                       42040 |                             0.5  |                            0.5  |                                 nan   |                                     617 |              63.89 |  6.81477e+07 |              122.578 |         42   |          19.718 |          13.079 |         38605.7  |             nan   |                  86.06  |                  4.77 |             30.1 |           35.6 |                  nan     |                         5.98 |             82.66 |                     0.901 |

 2. **Vaccination table**  

|       | iso_code   | continent     | location                         | date                |   new_tests |   total_tests |   total_tests_per_thousand |   new_tests_per_thousand |   new_tests_smoothed |   new_tests_smoothed_per_thousand |   positive_rate |   tests_per_case | tests_units     |   total_vaccinations |   people_vaccinated |   people_fully_vaccinated |   new_vaccinations |   new_vaccinations_smoothed |   total_vaccinations_per_hundred |   people_vaccinated_per_hundred |   people_fully_vaccinated_per_hundred |   new_vaccinations_smoothed_per_million |   stringency_index |   population_density |   median_age |   aged_65_older |   aged_70_older |   gdp_per_capita |   extreme_poverty |   cardiovasc_death_rate |   diabetes_prevalence |   female_smokers |   male_smokers |   handwashing_facilities |   hospital_beds_per_thousand |   life_expectancy |   human_development_index |
|------:|:-----------|:--------------|:---------------------------------|:--------------------|------------:|--------------:|---------------------------:|-------------------------:|---------------------:|----------------------------------:|----------------:|-----------------:|:----------------|---------------------:|--------------------:|--------------------------:|-------------------:|----------------------------:|---------------------------------:|--------------------------------:|--------------------------------------:|----------------------------------------:|-------------------:|---------------------:|-------------:|----------------:|----------------:|-----------------:|------------------:|------------------------:|----------------------:|-----------------:|---------------:|-------------------------:|-----------------------------:|------------------:|--------------------------:|
| 64891 | VCT        | North America | Saint Vincent and the Grenadines | 2020-04-04 00:00:00 |         nan |           nan |                     nan    |                  nan     |                  nan |                           nan     |         nan     |            nan   | nan             |                  nan |                 nan |                       nan |                nan |                         nan |                              nan |                             nan |                                   nan |                                     nan |             nan    |              281.787 |         31.8 |           7.724 |           4.832 |        10727.1   |             nan   |                 252.675 |                 11.62 |            nan   |          nan   |                  nan     |                         2.6  |             72.53 |                     0.738 |
|   998 | ALB        | Europe        | Albania                          | 2020-06-27 00:00:00 |         355 |         22419 |                       7.79 |                    0.123 |                  335 |                             0.116 |           0.187 |              5.3 | tests performed |                  nan |                 nan |                       nan |                nan |                         nan |                              nan |                             nan |                                   nan |                                     nan |              68.52 |              104.871 |         38   |          13.188 |           8.643 |        11803.4   |               1.1 |                 304.195 |                 10.08 |              7.1 |           51.2 |                  nan     |                         2.89 |             78.57 |                     0.795 |
| 12706 | BDI        | Africa        | Burundi                          | 2020-07-07 00:00:00 |         nan |           nan |                     nan    |                  nan     |                  nan |                           nan     |         nan     |            nan   | nan             |                  nan |                 nan |                       nan |                nan |                         nan |                              nan |                             nan |                                   nan |                                     nan |              13.89 |              423.062 |         17.5 |           2.562 |           1.504 |          702.225 |              71.7 |                 293.068 |                  6.05 |            nan   |          nan   |                    6.144 |                         0.8  |             61.58 |                     0.433 |
| 29701 | DEU        | Europe        | Germany                          | 2020-07-10 00:00:00 |         nan |           nan |                     nan    |                  nan     |                73343 |                             0.875 |         nan     |            nan   | tests performed |                  nan |                 nan |                       nan |                nan |                         nan |                              nan |                             nan |                                   nan |                                     nan |              55.09 |              237.016 |         46.6 |          21.453 |          15.957 |        45229.2   |             nan   |                 156.139 |                  8.31 |             28.2 |           33.1 |                  nan     |                         8    |             81.33 |                     0.947 |
| 30289 | GHA        | Africa        | Ghana                            | 2021-01-01 00:00:00 |         nan |           nan |                     nan    |                  nan     |                 1874 |                             0.06  |           0.068 |             14.8 | samples tested  |                  nan |                 nan |                       nan |                nan |                         nan |                              nan |                             nan |                                   nan |                                     nan |              38.89 |              126.719 |         21.1 |           3.385 |           1.948 |         4227.63  |              12   |                 298.245 |                  4.97 |              0.3 |            7.7 |                   41.047 |                         0.9  |             64.07 |                     0.611 |

## 3. Analysis

#### 1. Data Exploration
##### GOAL
This is a simple Query to Explore and discover the Dataset using a Select *
##### Query
Query 1 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
This is Query simply allow to discover the columns of the tables 


#### 2. Main Columns
##### GOAL
This is a simple Query to discover closely the main columns to be used for the Analysis
##### Query
Query 2 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
This is Query simply allow to discover the important columns of the tables 


#### 3. Total Cases vs Total Deaths
##### GOAL
This is a  Query Shows the likelihood of dying if you contract covid in your country
##### Query
Query 3 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation


#### 4. Total Cases vs Total Deaths
##### GOAL
This  Query Shows what percentage of population infected with Covid per each country
##### Query
Query 4 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation


#### 5. Country with Highest Infection rate 
##### GOAL
This  Query Shows the countries with Highest Infection Rate compared to Population
##### Query
Query 5 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

#### 6. Countries with the Highest Death count 
##### GOAL
This  Query Shows the Countries with the Highest Death Count per Population
##### Query
Query 5 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

#### 7. Most Impacted Continents
##### GOAL
This  Query Shows the continents with the highest death count per population
##### Query
Query 7 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

#### 8. Global numbers
##### GOAL
This  Query Shows the death percentage on a global Scope
##### Query
Query 8 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

#### 9-1. Total Population vs Vaccinations
##### GOAL
This  Query Shows Percentage of Population that has recieved at least one Covid Vaccine
##### Query
Query 9-1 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

#### 9-2. Total Population vs Vaccinations Using CTE
##### GOAL
This  Query Shows Percentage of Population that has recieved at least one Covid Vaccine using CTE
##### Query
Query 9-2 in the Project File [PROJECT  SQL File](Link)

#### 9-3. Total Population vs Vaccinations Using TEMP TABLE
##### GOAL
This  Query Shows Percentage of Population that has recieved at least one Covid Vaccine using TEMP TABLZ
##### Query
Query 9-3 in the Project File [PROJECT  SQL File](Link)

#### 10. Vaccination Tracking
##### GOAL
This  Query Shows the Rolling count of people vaccinated inserted in a view that could be used in later visualizations
##### Query
Query 10 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation


#### 11. Year to Year Total Cases Evolution
##### GOAL
This  Query Shows a comparison for each country of the total cases year by year using Windows functions 
##### Query
Query 11 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

#### 12-1. Year to Year Total Cases Evolution
##### GOAL
This  Query Shows a comparison for each country of the total cases year by year using Windows functions 
##### Query
Query 11 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

#### 12-2. Year to Year Total Cases Evolution
##### GOAL
This  Query Shows a comparison for each country of the total cases year by year using Windows functions 
##### Query
Query 12 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

