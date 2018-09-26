library(tidyverse)

dat <- read.csv('drink_data.txt', sep = '\t', header = TRUE)

dat_world <- read.csv('drink_data_world_long.txt', sep = '\t', header = TRUE)
data_long <- gather(dat_world, year, consumption, X2009:X2000, factor_key=TRUE)

write.csv(data_long, file = 'drink_world_long.txt', quote = FALSE, sep = '\t', row.names = F)
write_tsv(data_long, path = 'drink_world_long.txt')

head(dat)
tail(dat)

dat %>%
  filter(beerServings > 300)

dat %>%
  arrange(continent, desc(beerServings))

ggplot(dat, aes(x = continent, y = beerServings)) +
  geom_boxplot()

ggplot(dat, aes(x = beerServings, y = wineServings, color = continent)) +
  facet_wrap(~continent) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

ggplot(dat, aes(x = beerServings, y = spiritServings, color = continent)) +
  geom_point() +
  geom_smooth(method = 'lm', se = FALSE)

ggplot(dat, aes(x = beerServings, color = continent)) +
  facet_wrap(~ continent) +
  geom_density()

dat_world %>%
  filter(type %in% c('Beer', 'Wine', 'Spirits')) %>%
  aggregate(amount ~ year + type + continent, data = ., mean) %>%
  ggplot(aes(x = factor(year), y = amount, group = type, color = type)) +
  facet_wrap(~ continent) +
  geom_line()

dat_world %>%
  filter(type %in% c('Beer', 'Wine', 'Spirits')) %>%
  #aggregate(amount ~ year + type + continent, data = ., mean) %>%
  ggplot(aes(x = year, y = amount)) +
  facet_grid( type ~ continent) +
  geom_point() +
  geom_smooth(formula = amount ~ year)

dat_world %>%
  filter(type %in% c('Beer', 'Wine', 'Spirits')) %>%
  ggplot(aes(x = year, y = amount, color = type)) +
  facet_wrap(~ continent) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = 'lm')
