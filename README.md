# Data_cleaning_using_SQL
SQL project to clean and standardize a layoffs dataset

# 🧹 Data Cleaning Using SQL

## 📋 Project Overview
This project focuses on cleaning and standardizing a layoffs dataset using **SQL**.  
The goal is to transform raw, inconsistent data into a clean, analysis-ready format.  
The process involves removing duplicates, fixing inconsistent text formats, handling null values, and converting data types for accurate analysis.

---

## 🛠️ Tools & Technologies
- **MySQL Workbench**
- **SQL**

---

## ⚙️ Key Steps Performed
1. **Created staging tables** to safely clean data without affecting the original table.  
2. **Identified and removed duplicates** using `ROW_NUMBER()` and CTEs.  
3. **Trimmed and standardized text data** (e.g., company, industry, country names).  
4. **Formatted the date column** using `STR_TO_DATE()` for consistency.  
5. **Handled null and blank values** by updating or removing invalid records.  
6. **Deleted unnecessary rows** where both `total_laid_off` and `percentage_laid_off` were missing.

---

## 🧾 Dataset
The dataset contains company layoff data with the following columns:
- `company`
- `location`
- `industry`
- `total_laid_off`
- `percentage_laid_off`
- `date`
- `stage`
- `country`
- `funds_raised_millions`

📂 You can find the dataset in the file: **`layoffs.csv`**

---

## 📈 Outcome
- Cleaned and standardized data ready for **Exploratory Data Analysis (EDA)**.  
- Dataset can now be used for **data visualization** or **predictive analysis**.

---

## 📚 Learning Highlights
Through this project, I learned:
- How to use **window functions** for duplicate detection.  
- How to **standardize text** and **format dates** in SQL.  
- The importance of **data cleaning** before any analysis or visualization.

---

## 📊 Project Structure

