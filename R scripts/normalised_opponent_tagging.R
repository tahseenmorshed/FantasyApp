# Normalize deviations within each metric for comparison
star_player_stats <- star_player_stats %>%
  mutate(NormTackleDev = (TackleDeviation - min(TackleDeviation)) / (max(TackleDeviation) - min(TackleDeviation)),
         NormGoalDev = (GoalDeviation - min(GoalDeviation)) / (max(GoalDeviation) - min(GoalDeviation)),
         NormFantasyPointDev = (FantasyPointDeviation - min(FantasyPointDeviation)) / (max(FantasyPointDeviation) - min(FantasyPointDeviation)))

# Aggregate by team for plotting
team_effectiveness <- star_player_stats %>%
  group_by(match_away_team) %>%
  summarise(AvgNormTackleDev = mean(NormTackleDev),
            AvgNormGoalDev = mean(NormGoalDev),
            AvgNormFantasyPointDev = mean(NormFantasyPointDev)) %>%
  pivot_longer(cols = starts_with("AvgNorm"), names_to = "Metric", values_to = "AverageNormDeviation")

# Plot
ggplot(team_effectiveness, aes(x = match_away_team, y = AverageNormDeviation, fill = Metric)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Normalized Performance Deviation Index by Metric",
       x = "Opponent Team", 
       y = "Normalized Deviation Index") +
  scale_fill_brewer(palette = "Set1")
