# SQL Data Cleaning and Exploratory Data Analysis (EDA) Project - Layoffs Dataset

This project involved two main phases:

- Data Cleaning Project using SQL — deduplication, standardization, and handling null values on a layoffs dataset.
- Exploratory Data Analysis (EDA): Discovering key insights about layoffs across companies, industries, stages, countries, and time periods using SQL.


**Steps Performed**

- Created a backup table to preserve the raw data (layoff_2)
- Identified and removed duplicate records using ROW_NUMBER()

- Standardized text fields like:

- company names (trimming spaces)
- industry names (merging similar categories)
- country names (removing unwanted characters like dots)
- Converted the date column from text to proper DATE datatype

**Handled NULL values:**

- Populated missing industry values based on company names
- Deleted rows where important fields like total_laid_off and percentage_laid_off were missing

Dropped unnecessary columns (e.g., row_num)

**Exploratory Data Analysis (EDA)**

- Identified companies with complete layoffs and highest funds raised.
- Analyzed total layoffs:

- By country (United States had the highest)
- By year (trends from 2020 to 2023)
- By company and industry (Consumer industry had the highest layoffs)
- By funding stage (Post-IPO companies were most affected)
- Calculated rolling totals to observe layoff trends over time.
- Identified Top 5 companies with highest layoffs each year.
- Computed Year-over-Year (YoY) percentage changes:

    - 2021 saw an ~80% decrease from 2020
    - 2022 saw a ~915% increase from 2021
    - 2023 saw a ~21% decrease from 2022

**SQL Concepts Applied**
- Common Table Expressions (CTEs)
- Temporary Tables
- Window Functions (ROW_NUMBER())
- String Functions (TRIM())
- Date Conversion (STR_TO_DATE())
- Data Standardization and Cleaning Techniques
- Conditional Updates and Deletes
- Data Ranking and Rolling Totals
- YoY Percentage Change Calculation

**Project Files**
data_cleaning_project.sql — Contains all SQL queries written for this project.
eda_layoffs.sql — Exploratory Data Analysis queries

**Tools Used**
MySQL (Workbench)

**Key Learnings**
- Importance of not working directly on raw datasets
- Using SQL for end-to-end data cleaning without external tools
- Building habits like backing up tables, progressive cleaning, and validating each step
- How to perform powerful EDA using only SQL
- Leveraging window functions and CTEs for deeper insights

