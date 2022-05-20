# Ateliers codon(s)!
# 02 - Manipuler des données avec le tidyverse
# Lundi 30/05/2022

# Défi

# Importer les données ----

dragons <- read.csv("https://raw.githubusercontent.com/codons-blog/C-02-ManipulationDonnees/main/dragons.csv")

# Renommer la colonne paprika en curcuma ----

dragons <- rename(dragons, curcuma = paprika)

# Retirer 30cm au traitement tabasco pour les Magyar à pointes ----

# 1e approche : extraire un vecteur

valeurs_correctes <- dragons$tabasco[dragons$espece == "magyar_a_pointes"] - 30
dragons[dragons$espece == "magyar_a_pointes", "tabasco"] <- valeurs_correctes

# 2e approche : utiliser ifelse

dragons <- mutate(dragons, tabsco = ifelse(espece == "magyar_a_pointes", tabasco - 30, tabasco))

# 3e approche : utiliser case_when

dragons <- mutate(dragons,
                  tabasco = case_when(espece == "magyar_a_pointes" ~ tabasco - 30,
                                      TRUE ~ as.numeric(tabasco)))

# Format large -> format long -----

dragons_long <- pivot_longer(dragons,
                        cols = c(tabasco:curcuma),
                        names_to = "epice",
                        values_to = "taille_cm")

# Convertir les centimètres en mètres ----

dragons_long <- mutate(dragons_long, 
                       taille_m = taille_cm / 100)

# Boxplots ----

magyar_a_pointes <- filter(dragons_long, espece == "magyar_a_pointes")
suedois_a_museau_court <- filter(dragons_long, espece == "suedois_a_museau_court")
vert_gallois <- filter(dragons_long, espece == "vert_gallois")

par(mfrow = c(1, 3))  # separe la fenetre graphique en 3 colonnes

boxplot(taille_m ~ epice, data = magyar_a_pointes,
        xlab = "Epice", ylab = "Taille de la flamme (m)",
        main = "Magyar a pointes")

boxplot(taille_m ~ epice, data = suedois_a_museau_court,
        xlab = "Epice", ylab = "Taille de la flamme (m)",
        main = "Suedois a museau court")

boxplot(taille_m ~ epice, data = vert_gallois,
        xlab = "Epice", ylab = "Taille de la flamme (m)",
        main = "Vert gallois")
