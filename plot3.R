# Plot 3 for exploratory data analysis couse
# Script assumes that source data is present in the parent folder of script

# Read the power consumption data
power = read.csv('../household_power_consumption.txt', sep=';', stringsAsFactors=F,
                 na.strings="?")

# Convert date to 'date'
power$Date = as.Date(power$Date, format = '%d/%m/%Y')

# Subset the data for the 2 days
power_subset <- subset(power, subset=((Date == '2007-02-01') | 
                                          (Date == '2007-02-02')))
unique(power_subset$Date) #to check correct subset

# Add new column with date and time
power_subset <- within(power_subset, datetime <- as.POSIXct(paste(Date, Time)))

# Plot Sub metering 1,2 and 3 against datetime (created above) on same plot
# Create ranges
xrange <- range(power_subset$datetime)
yrange <- range(power_subset$Sub_metering_1, power_subset$Sub_metering_2, power_subset$Sub_metering_3)

# Create empty plot
plot(xrange, yrange, type="n", xlab="", ylab="Energy sub metering")

# Add all the plot
lines(power_subset$Sub_metering_1~power_subset$datetime, col='Black')
lines(power_subset$Sub_metering_2~power_subset$datetime, col='Red')
lines(power_subset$Sub_metering_3~power_subset$datetime, col='Blue')

# Add a legend
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
                legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save the plot

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()