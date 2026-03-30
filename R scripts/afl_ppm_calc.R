library(fitzRoy)
library(dplyr)
library(ggplot2)
library(tidyr)

# Calculate deviations for tackles, disposals, and fantasy points
star_player_stats <- player_stats %>%
  filter(player_id %in% star_players$player_id) %>%
  group_by(player_id) %>%
  mutate(AvgTackles = mean(tackles),
         TackleDeviation = tackles - AvgTackles,
         AvgDisposals = mean(disposals),  # Updated from AvgGoals
         DisposalDeviation = disposals - AvgDisposals,  # Updated from GoalDeviation
         AvgFantasyPoints = mean(afl_fantasy_score),
         FantasyPointDeviation = afl_fantasy_score - AvgFantasyPoints) %>%
  ungroup()

# Prepare data for plotting
plot_data <- star_player_stats %>%
  select(player_id, match_away_team, TackleDeviation, DisposalDeviation, FantasyPointDeviation) %>%  # Updated from GoalDeviation
  pivot_longer(cols = c(TackleDeviation, DisposalDeviation, FantasyPointDeviation),  # Updated from GoalDeviation
               names_to = "Metric", values_to = "Deviation")

ggplot(plot_data, aes(x = match_away_team, y = Deviation, fill = Metric)) +
  geom_boxplot() +
  coord_flip() +
  theme_minimal() +
  labs(title = "Performance Deviation Distribution by Metric",
       x = "Opponent Team",
       y = "Deviation from Season Average")
