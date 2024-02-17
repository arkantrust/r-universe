library(dplyr)

# --------------------------------------
# 1 Cuantas peliculas hay

# Filtrar las peliculas, Type == 0
movies <- filter(movies.shows, Type == 0)
print(count(movies)) # 9515
# --------------------------------------
# 2 Ahora mira cuenta cuántas películas tenemos en la plataforma de Netflix por año.
# ordena el resultado para que aparezca primero el último año disponible.

netflix_movies_per_year <- movies %>%
  filter(Netflix == 1) %>% 
  group_by(Year) %>%
  summarise(Count = n()) %>%
  arrange(desc(Year))
# --------------------------------------
# 3 Ahora concentrémonos en los años 2018, 2019 y 2020.
# Ahora calcula la calificación promedio (en Rotten Tomatoes)
# por año para las películas que están en la plataforma de Netflix.
# debes descartar aquellas observaciones que no tenga
# datos para la calificación de Rotten Tomatoes.

avrg_netflix_rating_year <- movies %>%
  filter(Netflix == 1, Year %in% c(2018, 2019, 2020)) %>%
  filter(!is.na(Rotten.Tomatoes)) %>%
  group_by(Year) %>%
  summarise(AverageRating = mean(Rotten.Tomatoes))
# --------------------------------------
# 4 Lo mismo pero con prime video en vez de netflix

avrg_netflix_rating_year <- movies %>% 
  filter(Year >= 2018 & Year <= 2020) %>% 
  filter(Prime.Video == 1, !is.na(Rotten.Tomatoes)) %>% 
  group_by(Year) %>%
  summarise(Cal_Prime = mean(Rotten.Tomatoes)) 

