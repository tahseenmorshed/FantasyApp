library(fitzRoy)
library(dplyr)

player_stats <- fetch_player_stats(season = 2023, source = "fryzigg")

#Selecting top 10% players by average disposals per game
star_players <- player_stats %>%
  group_by(player_id) %>%
  summarise(AvgDisposals = mean(disposals), .groups = 'drop') %>%
  top_n(0.1 * n(), AvgDisposals)

# Merge star player IDs back into player_stats
star_player_stats <- player_stats %>%
  filter(player_id %in% star_players$player_id)

# Calculate deviations for each game
star_player_stats <- star_player_stats %>%
  group_by(player_id) %>%
  mutate(AvgSeasonDisposals = mean(disposals)) %>%
  ungroup() %>%
  mutate(DisposalDeviation = disposals - AvgSeasonDisposals)

# Aggregating deviation by opponent team
tagging_effectiveness <- star_player_stats %>%
  group_by(match_away_team) %>%
  summarise(AvgDeviation = mean(DisposalDeviation), .groups = 'drop')

# Ranking teams by their AvgDeviation
tagging_index <- tagging_effectiveness %>%
  arrange(AvgDeviation) %>%
  mutate(TaggingRank = row_number())
library(ggplot2)

ggplot(tagging_index, aes(x = reorder(match_away_team, TaggingRank), y = AvgDeviation)) +
  geom_col() +
  coord_flip() +  # Flips the axes for easier reading
  labs(title = "Opponent Tagging Index", x = "Team", y = "Average Deviation in Disposals") +
  theme_minimal()
