-- Convert string 'NULL' to real SQL NULL
UPDATE layoffs_stagings
SET total_laid_off = NULL
WHERE TRIM(total_laid_off) = 'NULL';

UPDATE layoffs_stagings
SET percentage_laid_off = NULL
WHERE TRIM(percentage_laid_off) = 'NULL';

UPDATE layoffs_stagings
SET funds_raised_millions = NULL
WHERE TRIM(funds_raised_millions) = 'NULL';

-- Populate missing industry based on company + location
UPDATE t1
SET t1.industry = t2.industry
FROM layoffs_stagings t1
JOIN layoffs_stagings t2
   ON t1.company = t2.company
   AND t1.location = t2.location
WHERE t1.industry IS NULL
      AND t2.industry IS NOT NULL;
