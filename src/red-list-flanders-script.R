library(tidyverse) # tidyverse
library(magrittr)  # For %<>% pipes
library(janitor)    # For cleaning input data
library(knitr)      # For nicer (kable) tables
library(readxl)     # To read excel files
library(stringr)    # To perform string operations
library(digest)     # To generate hashes
library(rgbif)      # To Match GBIF
library(assertable) # because it sneeded for rGBIF
library(inborutils) # wrap GBIF api data
library(readr)
library(dplyr)
library(assertthat)
library(inborutils)

ValidatedRedListsSource <- read_delim("data/raw/validated/ValidatedRedListsSource.csv", 
                                      ";", escape_double = FALSE, trim_ws = TRUE)
NonValidatedRedListsSource <- read_delim("data/raw/unvalidated/NonValidatedRedListsSource.csv", 
                                         ";", escape_double = FALSE, trim_ws = TRUE)



NonValidatedRedLists <- NonValidatedRedListsSource %<>%
  # Steps to produce the output
  mutate(license = "http://creativecommons.org/publicdomain/zero/1.0/"
         , rightsHolder = "INBO", accessRights = "http://www.inbo.be/en/norms-for-data-use"
         , datasetName = "UnValidated Red Lists of Flanders"
         , locationID = "ISO_3166-2:BE-VLG"
         , locality = "Flanders", countryCode = "BE", occurrencestatus = "present" )  %>%
  rename(scientificName = SpeciesnameAsPublished) %>%
  
  # add column threadStatus
  mutate(threadStatus = str_replace(RLCAsPublished,"Bedreigd","Endangered (EN)" )) %>%
  
  # List Code translation
  mutate(threadStatus = str_replace(threadStatus,"Bedreigd","Endangered (EN)" )
         , threadStatus = str_replace(threadStatus, "Kwetsbaar", "Vulnerable (VU)")
         , threadStatus = str_replace(threadStatus, "Ernstig bedreigd","Critically Endangered (CR)")
         , threadStatus = str_replace(threadStatus, "Momenteel niet bedreigd","Least Concern (LC)")
         , threadStatus = str_replace(threadStatus,"Momenteel niet in gevaar","Least Concern (LC)" )
         , threadStatus = str_replace(threadStatus," Met uitsterven bedreigd","Critically Endangered (CR)" )
         , threadStatus = str_replace(threadStatus,"Bijna in gevaar","Near Threatened (NT)" )
         , threadStatus = str_replace(threadStatus,"Met uitsterven bedreigd","Critically Endangered (CR)" )
         , threadStatus = str_replace(threadStatus,"Zeldzaam","Near Threatened (NT)" )
         , threadStatus = str_replace(threadStatus, "Uitgestorven","Regionally Extinct (REX)")
         , threadStatus = str_replace(threadStatus, "Achteruitgaand","Near Threatened (NT)")
         , threadStatus = str_replace(threadStatus,"Onvoldoende gekend","Data Deficient (DD)" )
         , threadStatus = str_replace(threadStatus, "Onvoldoende data ", "Data Deficient (DD)"	)
         , threadStatus = str_replace(threadStatus, "Regionaal uitgestorven","Regionally Extinct (EX)")
         , threadStatus = str_replace(threadStatus, "maar mate waarin ongekend","uncertain rate")
         , threadStatus = str_replace(threadStatus, "in Vlaanderen","in Flanders"))   %>%
  
#   mutate(threadStatus = recode (threadStatus
#          , "Geografisch beperkt" = "Geographically Limited (NT)"
#          , "Endangered (EN), maar niet gekend in welke mate" = "Endangered (EN), but not known to what extent"
#          , "Near Threatened (NT) (vrij zeldzaam)"="Near Threatened (NT) (quite rare)"
#          , "Near Threatened (NT) (zeer zeldzaam)"="Near Threatened (NT) (very rare)"
#          , "Near Threatened (NT) (zeldzaam)"="Near Threatened (NT) (rare)"
#          , "Niet bedreigd" = "Least Concern (LC)"
#          , "Least concern"="Least Concern (LC)"
#          , "Sterk bedreigd"="Critically Endangered (CR)"
#          , "Vulnerable" = "Vulnerable (VU)"
#          , "Verdwenen"= "Disappeared"
#          , "Waarschijnlijk bedreigd"="Probably Endangered"
#          , "Vermoedelijk bedreigd"="Presumably Threatened"
#          , "Vatbaar voor bedreiging"="Vulnerable to threat"
#          , "Critically endangered"="Critically Endangered (CR)"
#          , "Critically Endangered"="Critically Endangered (CR)"
#          , "Endangered"= "Endangered (EN)","Regionally extinct"="Regionally extinct (RE)")) %>% 
  
rename(vernacularName = SpeciesnameDutch) %>%  
  
 
mutate(threadStatus = recode (threadStatus
      , "Geografisch beperkt" = "Geographically Limited (NT)"
      , "Endangered (EN), maar niet gekend in welke mate" = "Endangered (EN), but not known to what extent"
      , "Near Threatened (NT) (vrij zeldzaam)"="Near Threatened (NT) (quite rare)"
      , "Near Threatened (NT) (zeer zeldzaam)"="Near Threatened (NT) (very rare)"
      , "Near Threatened (NT) (zeldzaam)"="Near Threatened (NT) (rare)"
      , "Niet bedreigd" = "Least Concern (LC)"
      , "Least concern"="Least Concern (LC)"
      , "Sterk bedreigd"="Critically Endangered (EN)"
      , "Vulnerable" = "Vulnerable (VU)"
      , "Verdwenen"= "Disappeared (RE)"
      , "Waarschijnlijk bedreigd"="Probably Endangered (NT)"
      , "Vermoedelijk bedreigd"="Presumably Threatened (DD/PT)"
      , "Vatbaar voor bedreiging"="Vulnerable to threat (NT)"
      , "Critically endangered"="Critically Endangered (CR)"
      , "Critically Endangered"="Critically Endangered (CR)"
      , "Endangered"= "Endangered (EN)"
      , "Regionally extinct"="Regionally extinct (RE)"
      , "Disappeared"="Disapeared (RE)"
      , "Near threatened"="Near Threatened (NT)"
      , "Probably Endangered"="Probably Endangered (DD/PT)"
      , "Geographically Limited"="Geographically Limited (NT)")) %>%
  

   request_species_information(name_col = "scientificName") %>%
   request_species_information(name_col = "scientificName" 
                              , gbif_terms= c('usageKey','scientificName','rank','order','matchType', 'phylum', 'kingdom','genus','class','confidence',  'synonym','status','family')) 

ValidatedRedLists <- ValidatedRedListsSource %<>%
  # Steps to produce the output
  mutate(license = "http://creativecommons.org/publicdomain/zero/1.0/"
         , rightsHolder = "INBO", accessRights = "http://www.inbo.be/en/norms-for-data-use"
         , datasetName = "UnValidated Red Lists of Flanders"
         , locationID = "ISO_3166-2:BE-VLG"
         , locality = "Flanders", countryCode = "BE", occurrencestatus = "present" )  %>%
  rename(scientificName = SpeciesnameAsPublished) %>%
  
  # add column threadStatus
  mutate(threadStatus = str_replace(RLCAsPublished,"Bedreigd","Endangered (EN)" )) %>%
  
  # List Code translation
  mutate(threadStatus = str_replace(threadStatus,"Bedreigd","Endangered (EN)" )
         , threadStatus = str_replace(threadStatus, "Kwetsbaar", "Vulnerable (VU)")
         , threadStatus = str_replace(threadStatus, "Ernstig bedreigd","Critically Endangered (CR)")
         , threadStatus = str_replace(threadStatus, "Momenteel niet bedreigd","Least Concern (LC)")
         , threadStatus = str_replace(threadStatus,"Momenteel niet in gevaar","Least Concern (LC)" )
         , threadStatus = str_replace(threadStatus," Met uitsterven bedreigd","Critically Endangered (CR)" )
         , threadStatus = str_replace(threadStatus,"Bijna in gevaar","Near Threatened (NT)" )
         , threadStatus = str_replace(threadStatus,"Met uitsterven bedreigd","Critically Endangered (CR)" )
         , threadStatus = str_replace(threadStatus,"Zeldzaam","Near Threatened (NT)" )
         , threadStatus = str_replace(threadStatus, "Uitgestorven","Regionally Extinct (REX)")
         , threadStatus = str_replace(threadStatus, "Achteruitgaand","Near Threatened (NT)")
         , threadStatus = str_replace(threadStatus,"Onvoldoende gekend","Data Deficient (DD)" )
         , threadStatus = str_replace(threadStatus, "Onvoldoende data ", "Data Deficient (DD)"	)
         , threadStatus = str_replace(threadStatus, "Regionaal uitgestorven","Regionally Extinct (EX)")
         , threadStatus = str_replace(threadStatus, "maar mate waarin ongekend","uncertain rate")
         , threadStatus = str_replace(threadStatus, "in Vlaanderen","in Flanders"))   %>%
  
  #   mutate(threadStatus = recode (threadStatus
  #          , "Geografisch beperkt" = "Geographically Limited (NT)"
  #          , "Endangered (EN), maar niet gekend in welke mate" = "Endangered (EN), but not known to what extent"
  #          , "Near Threatened (NT) (vrij zeldzaam)"="Near Threatened (NT) (quite rare)"
  #          , "Near Threatened (NT) (zeer zeldzaam)"="Near Threatened (NT) (very rare)"
  #          , "Near Threatened (NT) (zeldzaam)"="Near Threatened (NT) (rare)"
  #          , "Niet bedreigd" = "Least Concern (LC)"
  #          , "Least concern"="Least Concern (LC)"
  #          , "Sterk bedreigd"="Critically Endangered (CR)"
  #          , "Vulnerable" = "Vulnerable (VU)"
#          , "Verdwenen"= "Disappeared"
#          , "Waarschijnlijk bedreigd"="Probably Endangered"
#          , "Vermoedelijk bedreigd"="Presumably Threatened"
#          , "Vatbaar voor bedreiging"="Vulnerable to threat"
#          , "Critically endangered"="Critically Endangered (CR)"
#          , "Critically Endangered"="Critically Endangered (CR)"
#          , "Endangered"= "Endangered (EN)","Regionally extinct"="Regionally extinct (RE)")) %>% 

rename(vernacularName = SpeciesnameDutch) %>%  
  
  
  mutate(threadStatus = recode (threadStatus
                                , "Geografisch beperkt" = "Geographically Limited (NT)"
                                , "Endangered (EN), maar niet gekend in welke mate" = "Endangered (EN), but not known to what extent"
                                , "Near Threatened (NT) (vrij zeldzaam)"="Near Threatened (NT) (quite rare)"
                                , "Near Threatened (NT) (zeer zeldzaam)"="Near Threatened (NT) (very rare)"
                                , "Near Threatened (NT) (zeldzaam)"="Near Threatened (NT) (rare)"
                                , "Niet bedreigd" = "Least Concern (LC)"
                                , "Least concern"="Least Concern (LC)"
                                , "Sterk bedreigd"="Critically Endangered (EN)"
                                , "Vulnerable" = "Vulnerable (VU)"
                                , "Verdwenen"= "Disappeared (RE)"
                                , "Waarschijnlijk bedreigd"="Probably Endangered (NT)"
                                , "Vermoedelijk bedreigd"="Presumably Threatened (DD/PT)"
                                , "Vatbaar voor bedreiging"="Vulnerable to threat (NT)"
                                , "Critically endangered"="Critically Endangered (CR)"
                                , "Critically Endangered"="Critically Endangered (CR)"
                                , "Endangered"= "Endangered (EN)"
                                , "Regionally extinct"="Regionally extinct (RE)"
                                , "Disappeared"="Disapeared (RE)"
                                , "Near threatened"="Near Threatened (NT)"
                                , "Probably Endangered"="Probably Endangered (DD/PT)"
                                , "Geographically Limited"="Geographically Limited (NT)")) %>%
  
  
  request_species_information(name_col = "scientificName") %>%
  request_species_information(name_col = "scientificName" 
                              , gbif_terms= c('usageKey','scientificName','rank','order','matchType', 'phylum', 'kingdom','genus','class','confidence',  'synonym','status','family')) 


View(NonValidatedRedLists)
View(ValidatedRedLists)

write.csv(NonValidatedRedLists, file = "./data/interim/NonValidatedRedLists.csv", na = "", 
          row.names = FALSE, fileEncoding = "UTF-8")
write.csv(ValidatedRedLists, file = "./data/interim/ValidatedRedLists.csv", na = "", 
          row.names = FALSE, fileEncoding = "UTF-8")


