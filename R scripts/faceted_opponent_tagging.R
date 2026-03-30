library(fitzRoy)
library(dplyr)
library(ggplot2)
library(tidyr)

# Assuming player_stats is already fetched and star_players identified as shown previously

# Calculate deviations for tackles, goals, and fantasy points
star_player_stats <- player_stats %>%
  filter(player_id %in% star_players$player_id) %>%
  group_by(player_id) %>%
  mutate(AvgTackles = mean(tackles),
         TackleDeviation = tackles - AvgTackles,
         AvgGoals = mean(goals),
         GoalDeviation = goals - AvgGoals,
         AvgFantasyPoints = mean(afl_fantasy_score),
         FantasyPointDeviation = afl_fantasy_score - AvgFantasyPoints) %>%
  ungroup()

# Prepare data for plotting, melting into long format for faceting
plot_data <- star_player_stats %>%
  select(player_id, match_away_team, TackleDeviation, GoalDeviation, FantasyPointDeviation) %>%
  pivot_longer(cols = c(TackleDeviation, GoalDeviation, FantasyPointDeviation), 
               names_to = "Metric", values_to = "Deviation")

ggplot(plot_data, aes(x = match_away_team, y = Deviation, fill = Metric)) +
  geom_boxplot() +
  coord_flip() +
  theme_minimal() +
  labs(title = "Performance Deviation Distribution by Metric",
       x = "Opponent Team",
       y = "Deviation from Season Average")




