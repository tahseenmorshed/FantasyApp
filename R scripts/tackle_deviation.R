library(fitzRoy)
library(dplyr)

# Fetch player stats for the 2023 season
player_stats <- fetch_player_stats(season = 2023, source = "fryzigg")

# Identify star players based on tackles
star_players_tackles <- player_stats %>%
  group_by(player_id) %>%
  summarise(AvgTackles = mean(tackles), .groups = 'drop') %>%
  top_n(0.1 * n(), AvgTackles)

# Filter only star players' game data based on tackles
star_player_stats_tackles <- player_stats %>%
  filter(player_id %in% star_players_tackles$player_id)

# Calculate tackle deviations for each game
star_player_stats_tackles <- star_player_stats_tackles %>%
  group_by(player_id) %>%
  mutate(AvgSeasonTackles = mean(tackles)) %>%
  ungroup() %>%
  mutate(TackleDeviation = tackles - AvgSeasonTackles)

# Aggregate tackle deviation by opponent team
tackle_effectiveness <- star_player_stats_tackles %>%
  group_by(match_away_team) %>%
  summarise(AvgTackleDeviation = mean(TackleDeviation), .groups = 'drop')

# Rank teams by average tackle deviation
tackle_tagging_index <- tackle_effectiveness %>%
  arrange(AvgTackleDeviation) %>%
  mutate(TackleTaggingRank = row_number())

# Plot the tackle tagging index
ggplot(tackle_tagging_index, aes(x = reorder(match_away_team, TackleTaggingRank), y = AvgTackleDeviation)) +
  geom_col() +
  coord_flip() +  # Flip the axes for easier reading
  labs(title = "Opponent Tackle Tagging Index", x = "Team", y = "Average Deviation in Tackles") +
  theme_minimal()
