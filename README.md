# Modeling Baseball Salaries
Modeling Baseball Salaries using Box-Cox Transformation and Gamma Regression
## Data Sets
### Player statistics
* Player statistics are provided by [Baseball-Reference](baseball-reference.com)
* The data from this source required a bit of hand assembly, and was composed from four queries:

  * [For combined seasons, from 2019 to 2021, in the regular season, sorted by descending Offensive WAR (oWAR). (Qualified for Batting Title)](https://stathead.com/tiny/rN1dU)
  * [For combined seasons, from 2018 to 2020, in the regular season, sorted by descending Offensive WAR (oWAR). (Qualified for Batting Title)](https://stathead.com/tiny/HzAwJ)
  * [For combined seasons, from 2017 to 2019, in the regular season, sorted by descending Offensive WAR (oWAR). (Qualified for Batting Title)](https://stathead.com/tiny/d6O4d)
  * [For combined seasons, from 2016 to 2018, in the regular season, sorted by descending Offensive WAR (oWAR). (Qualified for Batting Title)](https://stathead.com/tiny/ekcft)

* The data from each query was copied into a single file, which is [stats.csv](https://github.com/SeanCunniff/ModelingBaseballSalaries/blob/main/stats.csv) in this repository

### Player Contracts
* Salary data was provided by [Cot's Contracts](https://legacy.baseballprospectus.com/compensation/cots/), here is a [direct link to their spreadsheets](https://docs.google.com/spreadsheets/d/1bXUPBabVf82y0m2KaZ0F9Fno9xwZ2pmepbFvMBX_TEM/edit)
* Each free agent season of interest 2022, 2021, 2020, 2019 were hand compiled into a new file, [salary.csv](https://github.com/SeanCunniff/ModelingBaseballSalaries/blob/main/salary.csv)
* The data needed to be cleaned with the names needing to be reordered and a new column added for statistic year, which helped merge our two datasets

### Merging datasets
* the file used in all regression analysis programs is [dataset.csv](https://github.com/SeanCunniff/ModelingBaseballSalaries/blob/main/dataset.csv)
* This file was made using a SAS/SQL program named [query.sas](https://github.com/SeanCunniff/ModelingBaseballSalaries/blob/main/query.sas)
  * this query merges the two data files by player name and statistics year
* Free agency years and player statistics years may be hard to follow, so here is an example:
  Suppose there is a player at the end of their rookie contract in 2021, they will be considered to be apart of the 2022 free agent class (So they will be in the 2022 tab of Cot's Contracts). We consider the three season prior to the new contract for player data, so that would be a span from 2019 to 2021 (the first query from BBREF)
