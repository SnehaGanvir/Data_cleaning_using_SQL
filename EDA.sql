-- exploratory data analysis (EDA)

SELECT * FROM layoffs_staging2;

-- quick sense of dataset size
SELECT COUNT(*) AS total_records FROM layoffs_staging2;

SELECT COUNT(DISTINCT company) AS unique_companies,
       COUNT(DISTINCT industry) AS unique_industries,
       COUNT(DISTINCT country) AS unique_countries
FROM layoffs_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT * FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT company, SUM(total_laid_off)
From layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`DATE`)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
From layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC; 

SELECT country, SUM(total_laid_off)
From layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- layoffs over time 
SELECT YEAR(`date`) AS year, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- comparing layoffs by stage
SELECT stage, SUM(total_laid_off)
From layoffs_staging2
GROUP BY stage
ORDER BY 1 DESC;

-- Which companies laid off the highest percentage of their workforce.
SELECT company, AVG(percentage_laid_off)
From layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT substring(`date`,1,7) as `month`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
group by `month` 
ORDER BY 1 ASC;

WITH Rolling_Total AS 
(
SELECT substring(`date`,1,7) as `month`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
group by `month` 
ORDER BY 1 ASC
)
SELECT `month`, total_off, SUM(total_off) 
over ( ORDER BY `month`) AS rolling_total
FROM Rolling_Total;

SELECT company, Sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

SELECT company, YEAR(`DATE`), Sum(total_laid_off)
from layoffs_staging2
group by company, YEAR(`DATE`)
order by company Asc;

SELECT company, YEAR(`DATE`), Sum(total_laid_off)
from layoffs_staging2
group by company, YEAR(`DATE`)
order by 3 desc;

WITH company_year AS 
(SELECT company, YEAR(`DATE`), Sum(total_laid_off)
from layoffs_staging2
group by company, YEAR(`DATE`)
)
SELECT * FROM company_year;

WITH company_year(company, years, total_laid_off) AS 
(SELECT company, YEAR(`DATE`), Sum(total_laid_off)
from layoffs_staging2
group by company, YEAR(`DATE`)
)
SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
ORDER BY Ranking ASC;

WITH company_year(company, years, total_laid_off) AS 
(SELECT company, YEAR(`DATE`), Sum(total_laid_off)
from layoffs_staging2
group by company, YEAR(`DATE`)
), 
company_year_rank As
(
SELECT *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT * FROM Company_year_rank
WHERE Ranking <= 5;



