# Load all required libraries
library(tidyverse)
library(rpart)
library(randomForest)
library(readr)
library(modelr)
library(ggplot2)
library(cowplot)
melbourne_data <- read_csv("C:/Users/Belfa F Rahma/Downloads/Portofolio Need/R ML/melb_data.csv")
summary(melbourne_data)

#EDA
# Distribution of property prices
ggplot(melbourne_data, aes(x = Price)) +
  geom_histogram(bins = 50, fill = "#3498db", color = "white", alpha = 0.8) +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Distribution of Property Prices in Melbourne",
       x = "Price (AUD)", y = "Count")

#EDA
# Relationship between Rooms and Price
p1 <- ggplot(melbourne_data, aes(x = factor(Rooms), y = Price)) +
  geom_boxplot(fill = "#1abc9c", alpha = 0.7) +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Price vs. Number of Rooms",
       x = "Rooms", y = "Price (AUD)")
# Relationship between Distance and Price
p2 <- ggplot(melbourne_data, aes(x = Distance, y = Price)) +
  geom_point(alpha = 0.4, color = "#e67e22") +
  geom_smooth(method = "lm", se = FALSE, color = "black") +
  labs(title = "Effect of Distance from CBD on Price",
       x = "Distance (km)", y = "Price (AUD)")

plot_grid(p1, p2, ncol = 2)

# Building the Descission Tree Model
fit <- rpart(Price ~ Rooms + Bathroom + Landsize + BuildingArea +
               YearBuilt + Lattitude + Longtitude, data = melbourne_data)

# Visualize regression tree
library(rpart.plot)
# Atur ulang layout dan margin agar tidak error
dev.off()  # tutup plot lama kalau ada
par(mfrow = c(1, 1), mar = c(1, 1, 1, 1))  # reset plot area & margin
rpart.plot(
  fit,
  main = "Regression Tree for Melbourne Housing Prices",
  type = 2,          # menampilkan cabang dan nilai split
  extra = 101,       # menampilkan prediksi & jumlah observasi
  under = TRUE,      # info tambahan di bawah node
  faclen = 0,        # tampilkan nama kategori lengkap
  cex = 0.8,         # ukuran teks sedikit lebih kecil
  tweak = 1.2,       # memperbesar keseluruhan plot
  fallen.leaves = TRUE # membuat cabang bawah rata
)


# Prediction & Model Evaluation
print("Making predictions for the following 5 houses:")
print(head(melbourne_data))

print("Predicted Prices:")
preds <- predict(fit, head(melbourne_data))
print(preds)

print("Actual Prices:")
print(head(melbourne_data$Price))

# Prediction & Model Evaluation
# Calculate Mean Absolute Error (MAE)
mae(fit, melbourne_data)

#Data Splitting: Train Vs Test
splitData <- resample_partition(melbourne_data, c(test = 0.3, train = 0.7))

lapply(splitData, dim)

#Training Model on Train Set and Testing on Test Set
fit2 <- rpart(Price ~ Rooms + Bathroom + Landsize + BuildingArea +
                YearBuilt + Lattitude + Longtitude, data = splitData$train)

test_mae <- mae(model = fit2, data = splitData$test)
train_mae <- mae(model = fit2, data = splitData$train)

cat("MAE (Train):", train_mae, "\n")
cat("MAE (Test):", test_mae, "\n")


#Model Tuning: Finding the Best Tree Depth
get_mae <- function(maxdepth, target, predictors, training_data, testing_data){
  predictors <- paste(predictors, collapse="+")
  formula <- as.formula(paste(target,"~",predictors,sep = ""))
  
  model <- rpart(formula, data = training_data,
                 control = rpart.control(maxdepth = maxdepth))
  mae(model, testing_data)
}

target <- "Price"
predictors <- c("Rooms","Bathroom","Landsize","BuildingArea",
                "YearBuilt","Lattitude","Longtitude")

depth_values <- 1:10
mae_values <- map_dbl(depth_values, ~ get_mae(.x, target, predictors, 
                                              splitData$train, splitData$test))

tuning_results <- data.frame(MaxDepth = depth_values, MAE = mae_values)

# Visualize tuning results
ggplot(tuning_results, aes(x = MaxDepth, y = MAE)) +
  geom_line(color = "#9b59b6", linewidth = 1.2) +
  geom_point(size = 3, color = "#8e44ad") +
  labs(title = "Model Tuning: MAE by Tree Depth",
       x = "Maximum Tree Depth", y = "Mean Absolute Error") +
  theme_minimal()

#Actual vs Predicted Visualization
melbourne_data$Predicted_Price <- predict(fit2, melbourne_data)

ggplot(melbourne_data, aes(x = Price, y = Predicted_Price)) +
  geom_point(color = "#2ecc71", alpha = 0.6) +
  geom_abline(intercept = 0, slope = 1, color = "red", linewidth = 1) +
  scale_x_continuous(labels = scales::comma) +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "Actual vs Predicted Prices",
       x = "Actual Price (AUD)", y = "Predicted Price (AUD)")



