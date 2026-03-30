library(fitzRoy)
library(dplyr)

player_stats <- fetch_player_stats(season = 2023, source = "fryzigg")

# Identify star players
star_players_tackles <- player_stats %>%
  group_by(player_id) %>%
  summarise(AvgTackles = mean(tackles), .groups = 'drop') %>%
  top_n(0.1 * n(), AvgTackles)

# Filter only star players
star_player_stats_tackles <- player_stats %>%
  filter(player_id %in% star_players_tackles$player_id)

# Calculate tackle deviations
star_player_stats_tackles <- star_player_stats_tackles %>%
  group_by(player_id) %>%
  mutate(AvgSeasonTackles = mean(tackles)) %>%
  ungroup() %>%
  mutate(TackleDeviation = tackles - AvgSeasonTackles)

# Aggregate 
tackle_effectiveness <- star_player_stats_tackles %>%
  group_by(match_away_team) %>%
  summarise(AvgTackleDeviation = mean(TackleDeviation), .groups = 'drop')

# Rank teams
tackle_tagging_index <- tackle_effectiveness %>%
  arrange(AvgTackleDeviation) %>%
  mutate(TackleTaggingRank = row_number())

# Plot
ggplot(tackle_tagging_index, aes(x = reorder(match_away_team, TackleTaggingRank), y = AvgTackleDeviation)) +
  geom_col() +
  coord_flip() +  # Flip the axes for easier reading
  labs(title = "Opponent Tackle Tagging Index", x = "Team", y = "Average Deviation in Tackles") +
  theme_minimal()
