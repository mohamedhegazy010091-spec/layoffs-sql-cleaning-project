# Layoffs SQL Cleaning Project

This project demonstrates a full **data cleaning workflow in SQL Server** using a Kaggle layoffs dataset.

**Dataset:** [Kaggle Layoffs 2022](https://www.kaggle.com/datasets/swaptr/layoffs-2022)

---

## Project Overview

The goal of this project is to prepare a clean and consistent dataset for analysis, including:

1. Removing duplicate records
2. Standardizing categorical data (industry, country, company)
3. Fixing text-based NULLs and blank values
4. Handling missing numeric data (`total_laid_off`, `percentage_laid_off`, `funds_raised_millions`)
5. Preparing the final clean dataset ready for EDA and reporting

---

## Folder Structure

```
layoffs-sql-cleaning-project/
│
├── README.md
├── data/ # Raw dataset
├── scripts/ # SQL scripts
└── images/ # ERD or visuals
```

---

## Scripts Overview

### 01_create_staging.sql
- Creates a **staging table** from raw dataset.
- Keeps a copy of raw data for safety.

### 02_remove_duplicates.sql
- Identifies duplicates using `ROW_NUMBER()`.
- Removes duplicates while keeping first occurrence.

### 03_standardize_data.sql
- Standardizes `industry`, `country`, and `company` names.
- Handles variations (e.g., 'CryptoCurrency' → 'Crypto', 'United States.' → 'United States').

### 04_handle_nulls.sql
- Converts `'NULL'` string to SQL `NULL`.
- Populates missing `industry` values from other rows with same company + location.
- Ensures numeric columns are clean for analysis.

### 05_final_clean.sql
- Drops temporary helper columns (`row_num`).
- Deletes rows that cannot be used (both `total_laid_off` and `percentage_laid_off` NULL).
- Outputs final clean dataset in `layoffs_stagings2`.

---

## Example Queries

```sql
-- Remove string 'NULL' and replace with real NULL
UPDATE layoffs_stagings2
SET total_laid_off = NULL
WHERE TRIM(total_laid_off) = 'NULL';

-- Populate missing industry based on company and location
UPDATE t1
SET t1.industry = t2.industry
FROM layoffs_stagings2 t1
JOIN layoffs_stagings2 t2
   ON t1.company = t2.company
   AND t1.location = t2.location
WHERE t1.industry IS NULL
      AND t2.industry IS NOT NULL;

