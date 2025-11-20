-- Add helper column for deduplication
ALTER TABLE layoffs_stagings ADD row_num INT;

-- Populate row numbers
WITH cte AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company, location, industry, total_laid_off,
                         percentage_laid_off, date, stage, country, funds_raised_millions
            ORDER BY (SELECT NULL)
        ) AS rn
    FROM layoffs_stagings
)
UPDATE t
SET row_num = cte.rn
FROM layoffs_stagings t
JOIN cte
    ON t.company = cte.company
    AND t.location = cte.location
    AND t.date = cte.date;

-- Delete duplicates
DELETE FROM layoffs_stagings
WHERE row_num > 1;
