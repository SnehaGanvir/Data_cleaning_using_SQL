# Data Cleaning using SQL - Layoffs Dataset

This project demonstrates a data-cleaning process performed entirely in SQL. The goal is to take a raw dataset on company layoffs (`layoffs.csv`), clean and standardize it using SQL queries, and prepare it for analysis.

## 📊 Dataset

The dataset used is `layoffs.csv`, which contains information about company layoffs.

## 🧹 Data Cleaning Steps

The SQL script `Data_cleaning_using_SQL.sql` performs several key cleaning operations, which likely include:

1.  **Removing Duplicates**: Identifying and deleting duplicate rows to ensure data integrity.
2.  **Standardizing Data**:
    * Trimming whitespace from text fields.
    * Correcting or standardizing categorical values.
    * Converting date columns to a consistent format.
3.  **Handling Null or Blank Values**: Populating missing values where possible (e.g., using data from other rows) or converting blanks to a standard `NULL` format.
4.  **Removing Unnecessary Columns/Rows**: Dropping columns that are not needed for analysis or removing rows that are irrelevant.

## 🗂️ Repository Files

* `Data_cleaning_using_SQL.sql`: The SQL script containing all the queries used for cleaning the data.
* `layoffs.csv`: The original, raw layoffs dataset.
* `data_cleaning_output_1.png`: A screenshot of the cleaning results or output.
* `data_cleaning_output_2.png`: A second screenshot of the cleaning results or output.

## 🚀 How to Use

1.  Import the `layoffs.csv` file into your SQL database (e.g., MySQL, PostgreSQL, SQL Server).
2.  Run the queries in the `Data_cleaning_using_SQL.sql` file sequentially to clean the data.
3.  Analyze the resulting cleaned table.
