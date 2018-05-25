library(readr)
ValidatedRedListsSource <- read_delim("data/raw/validated/ValidatedRedListsSource.csv", 
                                      ";", escape_double = FALSE, trim_ws = TRUE)
NonValidatedRedListsSource <- read_delim("data/raw/unvalidated/NonValidatedRedListsSource.csv", 
                                         ";", escape_double = FALSE, trim_ws = TRUE)

View(NonValidatedRedListsSource)
View(ValidatedRedListsSource)