-- Remove rows where both total_laid_off and percentage_laid_off are NULL
DELETE FROM layoffs_stagings
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- Drop helper column row_num
ALTER TABLE layoffs_stagings
DROP COLUMN row_num;

-- Create final cleaned table
SELECT *
INTO layoffs_stagings2
FROM layoffs_stagings;

-- Check final cleaned data
SELECT *
FROM layoffs_stagings2;
