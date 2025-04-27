-- Exploratory Data Analysis--

select*from layoff_2;

-- complete laidoff companies with highest funds raised

select company,funds_raised_millions
from layoff_2
where percentage_laid_off=1
order by 2 desc
limit 10;

-- Country with hihest laid_off
select country,sum(total_laid_off)
from layoff_2
group by country
order by 2 desc;    -- United States had the highest laid_off

-- now look at this as per year
select year(date) as `year`,sum(total_laid_off)
from layoff_2
where date is not null
group by `year`
order by 1 desc;  

-- a complete 100 percent laid off 
select *
from layoff_2
where percentage_laid_off=1
order by 4 desc;

-- max layoff
select max(total_laid_off)
from layoff_2;

-- date range of data
select min(`date`),max(`date`)
from layoff_2;

-- total laid_off from 2020 to 2023 of each company
select company,sum(total_laid_off)
from layoff_2
group by company
order by 2 desc;

-- total laid_off from 2020 to 2023 of each industry

select industry,sum(total_laid_off)
from layoff_2
group by industry
order by 2 desc;     -- Consumer industry with highest laid off

-- checking which stages were the comapny in with highest laid_off
select stage,sum(total_laid_off)
from layoff_2
group by stage
order by 2 desc;  -- post initial public offering has the highest total_laid_off

-- checking lay-off for each month of every year
select 
	year(`date`) as `year`,
	month(`date`) as `month`,
	sum(total_laid_off)
from layoff_2
where `date` is not null
group by `year`,`month`
order by `year` asc,`month` asc;
-- rolling total to check the the trend with time
with rolling_total as
(
select 
	year(`date`) as `year`,
	month(`date`) as `month`,
	sum(total_laid_off) as total_layoffs
from layoff_2
where `date` is not null
group by `year`,`month`
order by `year` asc,`month` asc
)
select `year`,`month`,total_layoffs,sum(total_layoffs) over (order by `year`,`month`) as rolling_total
from rolling_total;


-- top 5 companies with highest total laid off in each year
with company_year as
(select company,year(`date`)as `year`,sum(total_laid_off) as total_laid_off
from layoff_2
group by company,`year`
order by 3 desc),company_year_rank as
(select *,dense_rank() over(partition by year order by total_laid_off desc)as ranking
from company_year
where year is not null)
select * from company_year_rank
where ranking <=5;


-- YoY change for each year
with year_summary as(
select year(`date`) as year,
sum(total_laid_off) as total_laid_off
from layoff_2
where `date` is not null
group by `year`
order by `year`)
select `year`,total_laid_off,lag(total_laid_off) over (order by `year`) as previous_year_laid_off,
round(((total_laid_off-lag(total_laid_off) over (order by `year`))/(lag(total_laid_off) over (order by `year`)))*100,2) as YOY_percentage_change
 from year_summary;
 
 -- In year 2021 the laidoff decreased by 80 percent as compared to 2020
 -- In year 2022 the laidoff increased by 915 percent as compared to 2021
 -- In year 2023 the laidoff decreased by 21 percent as compared to 2022
 
 
 -- MoM change
 with Month_summary as(
select Month(`date`) as Month,
year(`date`) as year,
sum(total_laid_off) as total_laid_off
from layoff_2
where `date` is not null
group by `Month`,`year`
order by `year`,`Month`)
select `year`,`Month`,total_laid_off,lag(total_laid_off) over (order by `year`,`Month`) as previous_year_laid_off,
round(((total_laid_off-lag(total_laid_off) over (order by `year`,`Month`))/(lag(total_laid_off) over (order by `year`,`Month`)))*100,2) as MoM_percentage_change
 from Month_summary;
 
-- COVID-19 Impact (2020): Layoffs spiked sharply in April 2020 (+177% MoM) before declining steadily, reflecting early pandemic disruptions.

-- Extreme Volatility (2021-2023): Wild MoM swings—like +9,309% (Nov 2021) and +207% (Nov 2022)—suggest erratic, event-driven workforce cuts.

-- January Surges: Layoffs often spiked at year-start (e.g., +720% in Jan 2023), likely due to post-holiday restructuring.

-- Sharp Corrections: Peaks were typically followed by steep drops (e.g., -97% in July 2021), 
-- indicating one-time adjustments rather than sustained trends.

-- Repeated swings (e.g., +212% in May, +195% in October, +207% in November) point to macroeconomic uncertainty
--  (e.g., inflation, interest rate hikes, tech sector downturns).

