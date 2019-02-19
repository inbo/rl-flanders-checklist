
library(tidyverse)

threats_full <- rev(c("Regionally Extinct (RE)", 
                  "Critically Endangered (CR)", 
                  "Endangered (EN)",
                  "Vulnerable (VU)",
                  "Near Threatened (NT)",
                  "Least Concern (LC)",
                  "Data Deficient (DD)"))

threats_code <- rev(c("RE", "CR", "EN", "VU", 
                  "NT", "LC", "DD"))

threats_colors <- rev(c("#000200ff", "#da1b03ff", "#fb7e3cff",
                    "#f7e715ff", "#c9e224ff", "#5ec657ff", 
                    "#cfd1c4ff"))

redlists <- read_csv("redlists_assessment.csv")

redlists <- redlists %>%
  filter(Validated == "Validated") %>%  # only validated records
  filter(!is.na(RLC)) %>%   # excluding NA values
  filter(RLC %in% threats_code) %>% # ONLY codes, no 'NE' values
  mutate(RLC = factor(RLC, levels = threats_code))

# For each taxonomic group
ggplot(redlists, aes(x = TaxonomicGroup, fill = RLC)) +
  geom_bar(position = "fill") +
  coord_flip() +
  theme_minimal(base_size = 16) +
  scale_fill_manual("IUCN Red List \ncategory", values = threats_colors) +
  xlab("") + ylab("") + 
  scale_y_continuous(labels = scales::percent)

# For animalia plantae
ggplot(redlists, aes(x = Kingdom, fill = RLC)) +
  geom_bar(position = "fill") +
  theme_minimal(base_size = 16) +
  scale_fill_manual("IUCN Red List \ncategory", values = threats_colors) +
  xlab("") + ylab("") + 
  scale_y_continuous(labels = scales::percent)

# For (in)vertebrates
redlists_nonplant <- redlists %>% 
  filter(Spine != "Plant")

ggplot(redlists_nonplant, aes(x = Spine, fill = RLC)) +
  geom_bar(position = "fill") +
  theme_minimal(base_size = 16) +
  scale_fill_manual("IUCN Red List \ncategory", values = threats_colors) +
  xlab("") + ylab("") + 
  scale_y_continuous(labels = scales::percent)

#----------------------------------------------------------------

# treemapify as overview figure?

frequence_all <- redlists %>%
  group_by(RLC) %>%
  summarise (n = n()) %>%
  mutate(freq = n / sum(n)) %>%
  ungroup()

library(treemapify)

ggplot(frequence_all, 
       aes(area = freq, fill = RLC,
           label = RLC)) +
  geom_treemap() +
  geom_treemap_text(colour = "white", 
                    place = "centre",
                    grow = FALSE) +
  scale_fill_manual("IUCN Red List \ncategory", 
                    values = threats_colors)


