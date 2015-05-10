# Plot 2 for exploratory data analysis couse
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

# Plot Global active power against datetime column added above
plot(power_subset$Global_active_power~power_subset$datetime, type='l', 
     ylab="Global Active Power (kilowatts)", xlab="")

# Save to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()