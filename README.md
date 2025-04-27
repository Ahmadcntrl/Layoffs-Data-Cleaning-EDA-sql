# SQL-DataCleaning-Project
Data Cleaning Project using SQL — deduplication, standardization, and handling null values on a layoffs dataset.
SQL Data Cleaning Project - Layoffs Dataset

**Project Overview**

This project focuses on cleaning a dataset related to company layoffs using SQL. The aim was to prepare the data for further analysis by removing duplicates, standardizing text fields, handling null values, and formatting dates properly.

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

**SQL Concepts Applied**
- Common Table Expressions (CTEs)
- Temporary Tables
- Window Functions (ROW_NUMBER())
- String Functions (TRIM())
- Date Conversion (STR_TO_DATE())
- Data Standardization and Cleaning Techniques
- Conditional Updates and Deletes

**Project Files**
data_cleaning_project.sql — Contains all SQL queries written for this project.

**Tools Used**
MySQL (Workbench)

**Key Learnings**
- Importance of not working directly on raw datasets
- Using SQL for end-to-end data cleaning without external tools
- Building habits like backing up tables, progressive cleaning, and validating each step

