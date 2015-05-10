# Plot 4 for exploratory data analysis couse
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

# Set 2x2 plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(power_subset, {
    plot(Global_active_power~datetime, type='l', 
                        ylab="Global Active Power", xlab="")
    plot(Voltage~datetime, type="l", ylab="Voltage", xlab="")
    # Plot Sub metering 1,2 and 3 against datetime (created above) on same plot
    # Create ranges
    xrange <- range(power_subset$datetime)
    yrange <- range(power_subset$Sub_metering_1, power_subset$Sub_metering_2, power_subset$Sub_metering_3)
    
    # Create empty plot
    plot(xrange, yrange, type="n", xlab="", ylab="Energy sub metering")
    
    # Add all the plot
    lines(Sub_metering_1~datetime, col='Black')
    lines(Sub_metering_2~datetime, col='Red')
    lines(Sub_metering_3~datetime, col='Blue')
    
    # Add a legend
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(Global_reactive_power~datetime, type="l")
    })

# Save the plot
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()