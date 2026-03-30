library(fitzRoy)
library(dplyr)
library(ggplot2)

player_stats <- fetch_player_stats(season = 2023, source = "fryzigg")

# Identify star players based on fantasy points
star_players_fantasy <- player_stats %>%
  group_by(player_id) %>%
  summarise(AvgFantasyPoints = mean(afl_fantasy_score), .groups = 'drop') %>%
  top_n(0.1 * n(), AvgFantasyPoints)

# Filter only star players game data
star_player_stats_fantasy <- player_stats %>%
  filter(player_id %in% star_players_fantasy$player_id)

# Calculate fantasy point deviations for each game
star_player_stats_fantasy <- star_player_stats_fantasy %>%
  group_by(player_id) %>%
  mutate(AvgSeasonFantasyPoints = mean(afl_fantasy_score)) %>%
  ungroup() %>%
  mutate(FantasyPointDeviation = afl_fantasy_score - AvgSeasonFantasyPoints)

# Aggregate fantasy point deviation by opponent team
fantasy_effectiveness <- star_player_stats_fantasy %>%
  group_by(match_away_team) %>%
  summarise(AvgFantasyPointDeviation = mean(FantasyPointDeviation), .groups = 'drop')

# Rank teams by average fantasy point deviation
fantasy_tagging_index <- fantasy_effectiveness %>%
  arrange(AvgFantasyPointDeviation) %>%
  mutate(FantasyTaggingRank = row_number())

# Plot 
ggplot(fantasy_tagging_index, aes(x = reorder(match_away_team, FantasyTaggingRank), y = AvgFantasyPointDeviation)) +
  geom_col() +
  coord_flip() +  # Flip the axes for easier reading
  labs(title = "Opponent Fantasy Point Tagging Index", x = "Team", y = "Average Deviation in Fantasy Points") +
  theme_minimal()
