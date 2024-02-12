
#NOTE: Please note that the code for the queries has already been included in the PDF version of the article. 
#This file contains codes for which I haven't inserted images in the homework PDF. 

getwd()

CarPricesPrediction <- read.csv('CarPricesPrediction.csv')



#Main Title Code*******************************************************************************

# Grouping data by Condition and calculating mean prices
condition_prices <- tapply(CarPricePrediction$Price, CarPricePrediction$Condition, mean)

# Creating a bar plot
barplot(condition_prices, main="Average Price Based on Condition", xlab="Condition", ylab="Average Price", col="skyblue", border="black")

# Boxplot of Price by Condition
boxplot(Price ~ Condition, data = CarPricesPrediction, col = "green", main = "Price by Condition", xlab = "Condition", ylab = "Price")






#Alternate Title 1 Code************************************************************************

# Create a boxplot to visualize the overall distribution of prices
boxplot(Price ~ Make, data = CarPricesPrediction, main = "Overall Price Distribution by Make")





#Alternate Title 2 Code************************************************************************

# Scatter plot
plot(car_data$Mileage, car_data$Price, main="Mileage vs. Price", xlab="Mileage", ylab="Price", col="blue", pch=19)

# Subset data for Ford
ford_data <- car_data[car_data$Make == "Ford", ]

# Scatter plot for Ford
plot(ford_data$Mileage, ford_data$Price, main="Ford - Mileage vs. Price", xlab="Mileage", ylab="Price", col="green", pch=19)

# Subset data for Toyota
toyota_data <- car_data[car_data$Make == "Toyota", ]

# Scatter plot for Toyota
plot(toyota_data$Mileage, toyota_data$Price, main="Toyota - Mileage vs. Price", xlab="Mileage", ylab="Price", col="red", pch=19)

# Subset data for Chevrolet
chevrolet_data <- car_data[car_data$Make == "Chevrolet", ]

# Scatter plot for Chevrolet
plot(chevrolet_data$Mileage, chevrolet_data$Price, main="Chevrolet - Mileage vs. Price", xlab="Mileage", ylab="Price", col="purple", pch=19)





#Prediction Model Code***************************************************************************

# Create a new column for decisions with a default value
CarPricesPrediction$Decision <- 'Good'

# Update decision based on certain conditions
CarPricesPrediction$Decision[CarPricesPrediction$Price < 20000] <- 'Good'
CarPricesPrediction$Decision[CarPricesPrediction$Year > 2010 & 
                               (CarPricesPrediction$Make %in% c('Ford', 'Toyota', 'Chevrolet', 'Nissan')) & 
                               CarPricesPrediction$Price > 18000 & CarPricesPrediction$Price < 22000] <- 'Excellent'

# Assuming SimulatedTrueCondition is the simulated true classification of cars

CarPricesPrediction$SimulatedTrueCondition <- sample(c('Excellent', 'Good'), nrow(CarPricesPrediction), replace = TRUE)

# Check the first few rows of the data to verify decisions
head(CarPricesPrediction)

# Calculate accuracy by comparing the decisions to the simulated true condition
accuracy <- mean(CarPricesPrediction$Decision == CarPricesPrediction$SimulatedTrueCondition)

cat("Accuracy:", accuracy, "\n")
