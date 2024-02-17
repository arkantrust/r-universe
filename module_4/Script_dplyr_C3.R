library(dplyr)

# 1 Crea el objeto movies_netflix que solo contenga los datos de
# las películas de Netflix y las variables Title, Year, Age y Rotten.Tomatoes

movies_netflix <- movies %>%
  filter(Netflix == 1) %>%
  select(Title, Year, Age, Rotten.Tomatoes)

# 2 Ahora crea en el objeto movies_netflix una nueva variable que se llame Plataforma.
# Esta variable será igual a “Netflix” para todos los casos de este objeto

movies_netflix <- mutate(movies_netflix, Plataforma = "Netflix")

# 3 A continuación, crea un objeto con el nombre movies_prime que tenga
# las mismas variables que finalmente tiene el objeto movies_netflix.
# La única diferencia es que el objeto movies_prime tiene solo las películas
# de Prime.Video y la variable Plataforma será igual a “Prime Video”

movies_prime <- movies %>%
  filter(Prime.Video == 1) %>%
  select(Title, Year, Age, Rotten.Tomatoes) %>%
  mutate(Plataforma = "Prime Video")

# 4 Ahora repite el mismo procedimiento para crear el objeto movies_disney.
# La variable Plataforma será igual a “Disney Plus”

# The Disney field has a dot at the end "Disney." :(
movies_disney <- movies %>%
  filter(Disney. == 1) %>%
  select(Title, Year, Age, Rotten.Tomatoes) %>%
  mutate(Plataforma = "Disney Plus")

