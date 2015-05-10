# Plot 1 for exploratory data analysis couse
# Script assumes that source data is present in the same folder as script

# Read the power consumption data
power = read.csv('household_power_consumption.txt', sep=';', stringsAsFactors=F,
                 na.strings="?")

# Convert date to 'date'
power$Date = as.Date(power$Date, format = '%d/%m/%Y')

# Subset the data for the 2 days
power_subset <- subset(power, subset=((Date == '2007-02-01') | 
                                          (Date == '2007-02-02')))
unique(power_subset$Date) #to check correct subset

# Convert active power to numeric
power_subset$Global_active_power <- as.numeric(power_subset$Global_active_power)

# Plot histogram for Global active power, name the plot and axis, and set plot
# color to Red.
hist(power_subset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Save the plot as png with given height and width.
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
