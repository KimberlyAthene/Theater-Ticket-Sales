# I'm first trying to just look at the data given to see what kind of things
#   I can start looking into within the datasets

# Start with the Sample Seat Manifest
manifest_df <- read.csv("~/The Fox Project/Sample Seat Manifest.csv")
head(manifest_df)

# Look for unique values through the different columns
# Skip column LS because it is a concatenated one from four others
# It could be used later for joining with the other dataframe
unique(manifest_df$Level)
unique(manifest_df$Section)
unique(manifest_df$Row)
unique(manifest_df$Seat)
unique(manifest_df$Price.Level.Code)
unique(manifest_df$Item.Price)

# Check the scatter plot to see the different prices assigned to the different
#   levels 
# There are values with zero. It could be meant to be a price of 70 (which 
#   is missing from this column) or it could be missing data? Inquire further.
library(ggplot2)
ggplot(data=manifest_df, aes(x=Level, y=Item.Price)) + geom_point()
ggplot(data=manifest_df, aes(x=Level, y=Price.Level.Code)) + geom_point()
ggplot(data=manifest_df, aes(x=Item.Price, y=Price.Level.Code)) + geom_point()
ggplot(data=manifest_df, aes(x=Seat.Status.Code, y=Section)) + geom_point()
ggplot(data=manifest_df, aes(x=Seat.Status.Code, y=Item.Price)) + geom_point()
ggplot(manifest_df, aes(Seat.Status.Code)) + geom_bar()


# Okay so to help clean the dataset, I changed the Item.Price column to 
# match the Price.Level.Codes for each Item.Price.
cl_mani_df <- read.csv("~/The Fox Project/Sample Seat Manifest Cleaned.csv")
head(cl_mani_df)

ggplot(data=cl_mani_df, aes(x=Level, y=Item.Price)) + geom_point()
ggplot(data=cl_mani_df, aes(x=Level, y=Price.Level.Code)) + geom_point()
ggplot(data=cl_mani_df, aes(x=Item.Price, y=Price.Level.Code)) + geom_point()
ggplot(data=cl_mani_df, aes(x=Seat.Status.Code, y=Item.Price)) + geom_point()

# Levels 17 and 18 are both Item Price = 0 so I'm looking for 
# similarities and differences to check if I can merge the two Levels
sev_mani_df <- read.csv('~/The Fox Project/Manifest Price Level 1718.csv')
head(sev_mani_df)

unique(sev_mani_df$Level)
unique(sev_mani_df$Section)
unique(sev_mani_df$Row)
unique(sev_mani_df$Seat)
unique(sev_mani_df$Seat.Status.Code)
unique(sev_mani_df$Price.Level.Code)
unique(sev_mani_df$Item.Price)

ggplot(data=sev_mani_df, aes(x=Level, y=Price.Level.Code)) + geom_point()

# I'm going to try to merge the two df to see if I can just use the one
# in Tableau for visibility
coord_df <- read.csv("~/The Fox Project/DDC Seat Coordinates.csv")
head(coord_df)

#Merge the two df together
toget_df <- merge(manifest_df, coord_df, by='LS', all.x=TRUE)
head(toget_df)

#get rid of extraneous columns
keeps <- c("LS", "Level.x","Section.x", "Row.x", "Seat.x", "Seat.Status.Code",
           "Price.Level.Code","Item.Price","X", "Y")
fox_df <- toget_df[, keeps, drop = FALSE]
head(fox_df)
#rename the columns for pretty tables
names(fox_df) <- c("LS", "Level","Section", "Row", "Seat", "Seat.Status.Code",
                   "Price.Level.Code","Item.Price","X", "Y")
head(fox_df)

# Save the file to be able to use it in Tableau
write.csv(fox_df, file = "~/The Fox Project/fox df.csv", row.names = FALSE)




