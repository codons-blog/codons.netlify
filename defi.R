# Ateliers codon(s)!
# 02 - Manipuler des données avec le tidyverse
# Lundi 30/05/2022

# Défi

# Importer les données ----

dragons <- read.csv("https://raw.githubusercontent.com/codons-blog/C-02-ManipulationDonnees/main/dragons.csv")

# Corriger les erreurs ----

# Renommer la colonne paprika en curcuma

dragons_2 <- rename(dragons, curcuma = paprika)

# Ajouter 30cm au traitement tabasco pour les Magyar à pointes

dragons_3 <- mutate(dragons_2,
                    tabasco = case_when(espece == "magyar_a_pointes" ~ tabasco + 30,
                                        TRUE ~ as.numeric(tabasco)))
# 