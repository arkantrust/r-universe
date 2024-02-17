library(gapminder)

data(gapminder)

pib <- gapminder %>%
  filter(country == "Colombia", year == 2007) %>%
  mutate(PIB = (gdpPercap * pop) / 1e6)

print(pib)
