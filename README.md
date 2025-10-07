# 🏡 Melbourne Housing Data Analysis in R

Welcome to my project based on the Kaggle notebook **"Welcome to Data Science in R"** by Rachael Tatman.  
This repository demonstrates basic data science workflows in R — including data cleaning, exploration, and visualization — using the **Melbourne Housing Market** dataset.

---

## 📊 Dataset Overview
The dataset provides property sale records in Melbourne, Australia.  
Below is the explanation for each variable used:

| Variable | Description |
|-----------|-------------|
| **Rooms** | Number of rooms in the property. |
| **Price** | Sale price (in AUD). |
| **Method** | Sale method: <br> - `S`: Sold <br> - `SP`: Sold prior <br> - `PI`: Passed in <br> - `PN`: Sold prior not disclosed <br> - `SN`: Sold not disclosed <br> - `NB`: No bid <br> - `VB`: Vendor bid <br> - `W`: Withdrawn prior to auction <br> - `SA`: Sold after auction <br> - `SS`: Sold after auction price not disclosed <br> - `N/A`: Price or bid not available. |
| **Type** | Property type: <br> - `br`: Bedroom(s) <br> - `h`: House / Cottage / Villa / Terrace <br> - `u`: Unit / Duplex <br> - `t`: Townhouse <br> - `dev site`: Development site <br> - `o res`: Other residential. |
| **SellerG** | Real estate agent (seller group). |
| **Date** | Date the property was sold. |
| **Distance** | Distance from the Central Business District (CBD). |
| **Regionname** | General region (e.g., West, North West, North East). |
| **Propertycount** | Number of properties that exist in the suburb. |
| **Bedroom2** | Scraped number of bedrooms (from another source). |
| **Bathroom** | Number of bathrooms. |
| **Car** | Number of car spots. |
| **Landsize** | Land size (in square meters). |
| **BuildingArea** | Building area (in square meters). |
| **CouncilArea** | Governing council for the area. |

---

## 🧠 Project Workflow
1. **Data Importing** — Loading the dataset into R.  
2. **Data Cleaning** — Handling missing values and correcting data types.  
3. **Exploratory Data Analysis (EDA)** — Using summary statistics and visualization to explore trends.  
4. **Feature Exploration** — Identifying which property attributes are related to price.  
5. **Basic Modeling** *(optional)* — Linear relationship examples.

---

## 📈 Insights & Findings
After cleaning and exploring the Melbourne housing data, several key insights were observed:

- 🏠 **Rooms and Price:**  
  Properties with more rooms tend to have higher prices, showing a strong positive correlation between the number of rooms and the selling price.

- 🚗 **Car Spots and Price:**  
  The availability of car spots slightly increases the property’s price, though the effect is smaller than that of the number of rooms.

- 📏 **Landsize and BuildingArea:**  
  Larger land and building areas are generally associated with higher prices, but the relationship is not linear — outliers (very large properties) significantly affect averages.

- 📍 **Distance from CBD:**  
  Prices generally decrease as the distance from the CBD increases, confirming that location is a major factor in property valuation.

- 🗓️ **Time Trend:**  
  Over time, prices show variability but a general upward trend, reflecting market growth during the data period.

- 🌏 **Region Differences:**  
  Inner-city and eastern regions tend to have the highest median prices, while western regions are more affordable.

---

## 🧩 Tools & Libraries Used
- **R** (RStudio)
- **tidyverse**
- **ggplot2**
- **dplyr**
- **readr**
- **lubridate**

---


