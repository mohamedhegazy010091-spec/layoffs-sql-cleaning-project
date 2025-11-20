-- Standardize industry values
UPDATE layoffs_stagings
SET industry = 'Crypto'
WHERE industry IN ('Crypto Currency', 'CryptoCurrency');

-- Standardize country names (remove trailing periods)
UPDATE layoffs_stagings
SET country = LEFT(country, LEN(country) - 1)
WHERE RIGHT(country, 1) = '.';
