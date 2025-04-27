-- Cleaning Project ---

select*
from layoffs;

-- 1-Check for Duplicates--
-- 2-Standardize the data--
-- 3-Treatment of Null values--
-- 4-Deleting unnecessary columns--


-- Creating layoff_2 in case we make any mistake while making changes to the data
-- because you should not work on raw data directly

create table layoff_2 as
(
select *
from layoffs
)
;

select *from layoff_2;

-- we don't have unique identity column in the table 
-- in order to check for duplicates we use row_number
with duplicated_values as
(
select *,
row_number() over(partition by company,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoff_2
)
select *from duplicated_values
where row_num>=2;


-- now to remove these duplicated values----
-- firstly i created a temporary table having row_num =1
-- then created a table using CTA ,values from the temporary table

create temporary table deduplicated as
select*from(
	select *,
	row_number() over(partition by company,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
	from layoff_2
) as ranked
where row_num=1;

-- dropping table
drop table layoff_2;

-- now creating it again but this time without duplicates

create table layoff_2 as
select* from deduplicated;

select*from layoff_2;


-- Standardization---
-- colum-1
select company,trim(company) from layoff_2;

update layoff_2
set company=trim(company);
-- Column-2
select distinct location from layoff_2
order by 1;
-- column-3
select distinct industry from layoff_2
order by 1;

select * from layoff_2
where industry like 'Finance%';

select count(*) 
from layoff_2
 where industry like 'Infrastructure%';
 
 
 update layoff_2
 set industry=trim(industry);
 
 update layoff_2
 set industry='Finance'
 where industry like 'Finance%';
 
 update layoff_2
 set industry='Crypto'
 where industry like 'Crypto%';
 
 -- Column-3---
 select distinct country from layoff_2
 order by 1;
 
 select distinct country,trim(trailing '.' from country)
 from layoff_2
 order by 1;
 
 update layoff_2
 set country=trim(trailing '.' from country)
 where country like 'United States%';
 
describe layoff_2;
-- it can be seen that the date column is in text
-- when performing EDA , date being in Data and time type will help in performing time series analysis
select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoff_2;

update layoff_2
set date=str_to_date(`date`,'%m/%d/%Y');

alter table layoff_2
modify column `date` DATE;

describe layoff_2;

select*from layoff_2;

-- Populating null values in industry column

select * from layoff_2
where industry is null
or industry='';

select *from layoff_2
where company='Airbnb';

update layoff_2
set industry='Travel'
where company like '%Airbnb';

select *from layoff_2
where company='Airbnb';

select*from layoff_2;

select* from layoff_2
where industry is null
or industry='';

select*from layoff_2
where company="Carvana";

update layoff_2
set industry='Transportation'
where company like '%Carvana';

select*from layoff_2
where company="Juul";

update layoff_2
set industry='Consumer'
where company like '%Juul';

select*from layoff_2
where company="Bally's Interactive";

-- Checking number of null values in each column

select count(*) from layoff_2
where total_laid_off is null;

select count(*) from layoff_2
where percentage_laid_off is null;

select count(*) from layoff_2
where date is null;

select count(*) from layoff_2
where stage is null;

select count(*) from layoff_2
where country is null;

select count(*) from layoff_2
where funds_raised_millions is null;

select*from layoff_2
limit 10;

select* from layoff_2 
where total_laid_off is null
and percentage_laid_off is null;

-- Deleting the rows which are not useful

delete
from layoff_2
where total_laid_off is null
and percentage_laid_off is null;

-- dropping column which is not useful

alter table layoff_2
drop column row_num;

select * from layoff_2;





















