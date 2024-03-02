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
This  Query is used to Explore and discover the Dataset using a Select *
##### Query
Query 1 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
This Query simply illustrate the columns of the dataset 

#### 2. Main Columns
##### GOAL
This is a simple Query to discover closely the main columns to be used for the Analysis
##### Query
Query 2 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
This Query simply illustrate the most important columns of the dataset that we will use frequently for the rest of the analysis

#### 3. Global numbers
##### GOAL
This  Query Shows the death percentage on a global Scope
##### Query
Query 3 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
The death rate of 0.90% suggests that while a significant number of cases were reported (774,561,579), the proportion of deaths relative to the total number of cases is relatively low. This could indicate that although the disease is widespread, it is not as fatal on average compared to some other diseases.
However, it's crucial to consider other factors such as the demographics of the affected population, healthcare infrastructure, availability of treatments, and preventive measures taken.


#### 4. Most Impacted Continents
##### GOAL
This Query Shows the continents with the highest death count per population
##### Query
Query 4 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
We have the total death count for each continent:
North America: 1,170,784
South America: 702,116
Asia: 533,454
Europe: 401,884
Africa: 102,595
Oceania: 24,566
These Results suggest that the continents have experienced varying degrees of impact from the disease, with North and South America being among the hardest hit even though Asia has the highest population.

#### 5. Infection Percentage
##### GOAL
This  Query Shows what percentage of the population is infected with COVID per each country
##### Query
Query 5 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
The Results Illustrate on a daily Level the Evolution of Covid infection throughout time, A common Trend is observed starting from the End of February for the majority of the countries with a high increase during 2020 AND 2021 followed by stability during 2023 and 2024

#### 6. US Total Cases vs Total Deaths 
##### GOAL
This  Query Shows the likelihood of dying if you contract COVID-19 in the United States
##### Query
Query 6 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
The analysis of the death rate in the United States over time reveals a significant fluctuation since the onset of the pandemic.
Initially, following the first infections, the death rate experienced a sharp increase, reaching a peak of 8.69% in May 2020. This surge likely reflects the early stages of the pandemic when healthcare systems were overwhelmed, and effective treatments were limited.
However, following this peak, there was a notable decline in the death rate over time. Since 2021, the death rate has consistently remained below 1%, indicating a significant improvement in managing the impact of the virus.
The sustained decline in the death rate below 1% since 2021 reflects the success of vaccination efforts in mitigating the impact of the virus. It underscores the importance of continued vaccination initiatives to control the pandemic further and protect public health.

#### 7. Countries with Highest Infection rate 
##### GOAL
This  Query Shows the countries with the Highest Infection Rate compared to the Population
##### Query
Query 7 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

The analysis reveals several countries with remarkably high infection rates compared to their population sizes. For instance, Latvia, Niue, and Slovenia exhibit infection rates exceeding 40% of their populations.
This data underscores the severity of the COVID-19 pandemic and the significant impact it has had on various nations worldwide.
###### Factors Contributing to High Infection Rates:

Several factors may have contributed to the high infection rates observed in these countries. These factors could include population density, healthcare infrastructure, adherence to preventive measures, and government response strategies.
Additionally, factors such as international travel, population mobility, and socioeconomic disparities may have also played a role in the spread of the virus within these communities.
###### Regional and Global Trends:

The analysis highlights both regional and global trends in infection rates. Countries across Europe, Oceania, and the Americas appear prominently in the list, suggesting that the pandemic has affected regions worldwide.
Furthermore, the presence of high infection rates in countries with varying income levels and healthcare systems emphasizes the universal impact of the pandemic and the challenges faced by nations in controlling its spread.
###### Public Health Implications:

High infection rates pose significant public health challenges, including strain on healthcare systems, increased mortality, and long-term health implications for affected individuals.
Understanding the factors contributing to high infection rates can inform public health strategies aimed at mitigating the spread of the virus, including vaccination campaigns, targeted interventions in high-risk communities, and reinforcement of preventive measures.
###### Data Limitations and Further Analysis:

It's essential to consider potential limitations in the data, such as variations in testing capacities, reporting practices, and data accuracy across different countries.

#### 8. Year To Year Infection rate 
##### GOAL
This  Query Shows the evolution of the Infection Rate for each country year by year
##### Query
Query 8 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
The observed trends in infection rates over the years highlight the dynamic nature of the pandemic response and the interplay between public health measures, vaccination efforts, and societal behaviors.
The initial increase in infection rates in 2021 and 2022 underscores the importance of continued vigilance and adherence to safety measures even as vaccines become available,One plausible explanation is the relaxation of safety measures and restrictions that were initially effective in controlling the spread of the virus.
The subsequent decrease in infection rates in 2023 and 2024 suggests the potential effectiveness of vaccination campaigns and the role of public trust in vaccines in controlling the spread of the virus.

#### 9. Countries with the Highest Death count 
##### GOAL
This  Query Shows the Countries with the Highest Death Count per Population
##### Query
Query 9 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
The United States leads with the highest death count, reflecting the pandemic's significant impact due to factors like population size and healthcare infrastructure. Brazil follows closely, highlighting the severity influenced by healthcare capacity and socioeconomic disparities. India's substantial death toll underscores the pandemic's impact, despite its large population. Other countries also face varying death counts, influenced by factors like healthcare capacity and government response. Interpreting these counts informs global strategies to combat the virus and allocate resources effectively.

#### 10. Covid Impact vs Age
##### GOAL
This  Query Shows the median age group of the population Impacted by COVID by country and for each year 
##### Query
Query 10 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
The results reveal that the majority of individuals impacted by and deceased from COVID-19 have a median age that falls within two primary age brackets: "LESS THAN 40" and "BETWEEN 40 AND 65". This finding contrasts with the common perception that COVID-19 primarily affects older individuals. However, it suggests that while older age groups are indeed vulnerable, a significant proportion of cases and fatalities occur in younger and middle-aged populations, highlighting the importance of targeted interventions and preventive measures across all age demographics.

#### 11-1.  Vaccinations VS Economic Situation
##### GOAL
This  Query Compares the Vaccinations status for each type of Economy using a double CTE, where the countries are categorized using the extreme poverty index and the  human development index, the categorization labels economic conditions as 'High Extreme Poverty' for extreme poverty rates >= 30%, 'Low Human Development Index' for human development index <= 0.5, and 'Moderate Economic Conditions' otherwise.
##### Query
Query 11-1 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
Moderate economic condition countries lead in vaccination efforts, receiving vaccines early in 2020 Compared to the high extreme poverty and low human development index countries who started vaccination campaigns in 2021, the results also show a significant acceleration in vaccination rates from 2021 to 2023. However, disparities persist, with lower rates in high extreme poverty and low human development index countries, possibly due to resource limitations. This underscores the need for equitable vaccine distribution strategies to address global health inequalities.

#### 11-2. Total Population vs Vaccinations Using TEMP TABLE
##### GOAL
This  Query Shows the Percentage of the Population that has received at least one COVID vaccine using TEMP TABLE
##### Query
Query 11-2 in the Project File [PROJECT  SQL File](Link)

#### 12. Vaccination Tracking
##### GOAL
This  Query Shows the Rolling count of people vaccinated inserted in a view that could be used in later visualizations
##### Query
Query 12 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation


#### 13. Year to Year Total Cases Evolution
##### GOAL
This  Query Shows a comparison for each country of the total cases year by year using Windows functions 
##### Query
Query 13 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation
The query reveals a notable trend: a surge in COVID-19 cases across most countries in 2020 and 2021, followed by a decline in subsequent years. This suggests a shift from pandemic escalation to control, possibly due to effective vaccination campaigns and public health interventions as discovered in the previous interpretations.


#### 14-1. Monthly Increase Status
##### GOAL
This  Query Shows the count of months where the number of cases increased per country for each year
##### Query
Query 12 in the Project File [PROJECT  SQL File](Link)
#####  Results Interpretation

###### Global Decline: 
There appears to be a global decline in the query count of months where the number of cases increased. This is evidenced by the decreasing numbers across many countries over the years. This trend suggests that the occurrence of months with increasing case counts is decreasing globally.

######  Regional Variations:
While there is an overall decline, there are variations in the trend across different regions. For example, countries in Africa have shown a consistent decrease over the years, indicating a sustained improvement in controlling the spread of the virus. However, countries in Europe and Asia exhibit fluctuations, with some years showing decreases and others showing increases in the query count.

###### Country-Specific Insights:
Some countries consistently show a decrease in the query count, indicating successful management of the pandemic over the years. Examples include New Zealand and Australia. Conversely, countries like Brazil and India demonstrate fluctuations, suggesting challenges in maintaining control over the spread of the virus.

###### Income Level Impact:
There seems to be a correlation between income levels and the trend in query counts. High-income countries generally show a more consistent decrease, while low-income and lower-middle-income countries exhibit more fluctuations and higher query counts, indicating ongoing challenges in managing the pandemic.

Outliers and Anomalies: Some countries show anomalies, with occasional spikes in the query count despite an overall decreasing trend. This could be due to various factors such as changes in government policies, the emergence of new variants, or local outbreaks.

#### 14-2. Monthly Increase Status Optimised Query
##### GOAL
This  Query Shows the count of months where the number of cases increased per country for each year using an optimized query using  the approx_set function combined with the cardinality and merge  function instead of count Distinct using a probabilistic approach for faster results and lower resource consumption
##### Query
Query 14-2 in the Project File [PROJECT  SQL File](Link)

