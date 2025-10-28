-- data cleaning

--  dataset : https://www.kaggle.com/datasets/swaptr/layoffs-2022 


-- 1. Removing duplicates
-- 2. standardize the data
-- 3. Null values or blank values 
-- 4. remove any columns




-- 1. Remove duplicates
SELECT * from layoffs;

create TABLE layoffs_staging
Like layoffs;

INSERT layoffs_staging
SELECT * 
FROM layoffs;

SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date') as row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date',stage, country, funds_raised_millions) as row_num
FROM layoffs_staging
)
select * from duplicate_cte
where row_num > 1;

SELECT * FROM layoffs_staging
where company = 'oda';

SELECT * FROM layoffs_staging
where company = 'casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date',stage, country, funds_raised_millions) as row_num
FROM layoffs_staging;

SELECT * FROM layoffs_staging2
WHERE row_num > 1;

Delete FROM layoffs_staging2
WHERE row_num > 1;

SELECT * FROM layoffs_staging2;

# 2 standardizing data

SELECT company, TRIM(company) FROM layoffs_staging2;   -- Remove space before starting of word

update layoffs_staging2
SET company = TRIM(company);

select * FROM layoffs_staging2
WHERE industry like 'crypto%';

UPDATE layoffs_staging2
SET industry = 'crypto'
WHERE industry like 'crypto%';

select distinct industry FROM layoffs_staging2;

SELECT DISTINCT location
from layoffs_staging2
order by  1;

SELECT distinct country, trim(trailing '.' from country)
from layoffs_staging2
order by 1;
-- above query doesn't give required output so updating 

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United states%';


-- changing format of the date column
SELECT date,
str_to_date(date,'%m/%d/%Y')
from layoffs_staging2;

UPDATE layoffs_staging2
SET date = str_to_date(date,'%m/%d/%Y');

alter table layoffs_staging2
modify column `date` date;

SELECT * FROM layoffs_staging2;

-- 3. Null values or Blank_values 
SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

SELECT * FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

SELECT * FROM layoffs_staging2
WHERE company = 'Airbnb';

select t1.industry, t2.industry 
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
    and t1.location = t2.location
where ( t1.industry is null OR t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company = t2.company
SET t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;


-- 4. remove any columns and rows we need to

SELECT * FROM layoffs_staging2
WHERE company LIKE 'BALLY%';


SELECT * FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Deleting useless data which can't really use 
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT * FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP column row_num;

SELECT * FROM layoffs_staging2;

