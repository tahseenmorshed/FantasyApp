library(fitzRoy)
library(dplyr)
library(ggplot2)
library(plotly)


player_stats <- fetch_player_stats(season = 2024, source = "fryzigg")

# Calculate points per minute
player_stats <- player_stats %>%
  mutate(PointsPerMinute = afl_fantasy_score / (time_on_ground_percentage / 100 * 120))

# find the average PPM for each player
average_ppm <- player_stats %>%
  group_by(player_id, player_first_name, player_last_name) %>%
  summarise(AvgPPM = mean(PointsPerMinute, na.rm = TRUE), GamesPlayed = n()) %>%
  ungroup() %>%
  arrange(desc(AvgPPM))

# Filter to the top 50 players
top_50_players <- head(average_ppm, 50)

# display the top 50 player
print(top_50_players)

ggplotly(
  ggplot(top_50_players, aes(x = reorder(paste(player_first_name, player_last_name), AvgPPM), y = AvgPPM)) +
    geom_col() +
    coord_flip() +  # Makes the chart horizontal
    labs(title = "Top 50 AFL Players by Points Per Minute in 2023",
         x = "Player",
         y = "Average Points Per Minute") +
    theme_minimal()
)