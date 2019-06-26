# CodeBook

This code book describes how the beer and brewery data is imported and merged for the analysis.

## Data

The two data files, [`Beers.csv`](https://github.com/KThompson0308/beeranalysis/blob/master/analysis/data/Beers.csv) and [`Breweries.csv`](https://github.com/KThompson0308/beeranalysis/blob/master/analysis/data/Breweries.csv), are keyed on `Brewery_id` and `Brew_ID` respectively.

Data is included in git repo because it is light-weight and in git-friendly format.

### Structure of Data Files

The structures of the two data files are shown with a description of the columns, a sensible data type for the column, and the link between the files.

#### Beers.csv

* 2410 Beers
* Column Names (Raw)
  1. `Name`         - Name of the beer (character)
  2. `Beer_ID`      - Unique identifier for the beer (character)
  3. `ABV`          - Alcohol by volume as percent of total (dbl)
  4. `IBU`          - International bitterness unit (dbl)
  5. `Brewery_id`   - Unique identifier to match beers to breweries; **foreign key** to breweries.csv by `Brew_ID` (character)
  6. `Style`        - Style of the beer (character)
  7. `Ounces`       - Size of the beer container (factor)

#### Breweries.csv

* 558 Breweries
* Column Names (Raw)
  1. `Brew_ID`      - Unique identifier for brewery; **primary key** (character)
  2. `Name`         - Name of the brewery (character)
  3. `City`         - Name of city where brewery is located (character)
  4. `State`        - Name of state (US) where brewery is located (character)

## Merge and Cleaning Process

Data generation automation is located at `./analysis/data/`. This is a `makefile` that merges the files together, converts the columns of the `data.frames()` to sensible types, adds changes names of columns to more desciptive names, and stores the data in `./analysis/data/.RData`.

### Data Pipeline Automation

Data imported into R with [`gather1.R`](https://github.com/KThompson0308/beeranalysis/blob/master/analysis/data/gather1.R) and [`gather2.R`](https://github.com/KThompson0308/beeranalysis/blob/master/analysis/data/gather2.R). Once imported, the data is merged with [`mergedata.R`](https://github.com/KThompson0308/beeranalysis/blob/master/analysis/data/mergedata.R) and stored in .RData. This automation is callable by runnning `make` in `./analysis/Data/`.

### Mapping of Original Column Names to Cleaned Column Names

#### Beer.csv

Beer.csv is imported with [`gather1.R`](https://github.com/KThompson0308/beeranalysis/blob/master/analysis/data/gather1.R).

| Original Name | Imported Name | R Data Type |
|:-----------|:-----------|:------------------|
| Name       | Beer_name  | character         |
| Beer_ID    | Beer_ID    | character         |
| ABV        | ABV        | double            |
| IBU        | IBU        | double            |
| Brewery_ID | Brewery_id | character         |
| Style      | Style      | character         |
| Ounces     | Ounces     | factor            |

#### Brewery.csv

Brewery.csv is imported with [`gather2.R`](https://github.com/KThompson0308/beeranalysis/blob/master/analysis/data/gather2.R).

| Original Name | Imported Name | R Data Type |
|:-----------|:-----------|:------------------|
| Brew_ID    | Brewery_id | character         |
| City       | City       | character         |
| State      | State      | character         |
| Name       | Brewery_name | character       |

### Generated Columns in `merged_data`

`ShortStyle`: computed by extracting the most relevant string from style. Since this column is computed from `Style` it will have the same missingness structure as `Style`.

#### Merge Strategy

Data is merged with [`mergedata.R`](https://github.com/KThompson0308/beeranalysis/blob/master/analysis/data/mergedata.R). Data are left merged (`brewery.csv` on to `beer.csv`) by `Brewery_id` with `merge` from `{base}`.

## R Variables

These variables are contained in `./analysis/data/`

* `beer_data` - import of `beer.csv` as `data.frame()`.
* `brewery_data` - import of `brewery.csv` as `data.frame()`.
* `merged_data` - left merge of `beer.csv` and `brewery.csv` on `Brewery_id`.
* `nabular_data` - all columns of merged_data with an accompanying set of columns with `_NA` appended indicating if a row contains an `NA` for the matching column. These columns are factors with two levels (`!NA` and `NA`).

## Libraries

The following R packages are required for running the code.

* [naniar](https://github.com/njtierney/naniar)
* [tidyverse](https://www.tidyverse.org/)
  * ggplot2
  * dplyr
* [pastecs](https://cran.r-project.org/web/packages/pastecs/index.html)
