# Load required libraries
library(readr)
library(dplyr)
library(syuzhet)
library(ggplot2)
library(lubridate)
library(tidyr)
library(stringr)
library(tidytext)
library(topicmodels)
library(scales)

# 1. Data Preparation
data <- read_csv("bipolar_covid_posts.csv")
data$date <- as.Date(data$date)

# 2. Sentiment Analysis
data$sentiment_syuzhet <- get_sentiment(data$processed_text, method="syuzhet")
data$sentiment_bing <- get_sentiment(data$processed_text, method="bing")
data$sentiment_afinn <- get_sentiment(data$processed_text, method="afinn")

# 3. Emotion Analysis
emotions <- get_nrc_sentiment(data$processed_text)
data <- cbind(data, emotions)

# 4. Temporal Analysis
daily_sentiment <- data %>%
  group_by(date) %>%
  summarize(across(c(sentiment_syuzhet, sentiment_bing, sentiment_afinn), mean))

# Plot sentiment trends
ggplot(daily_sentiment, aes(x = date)) +
  geom_smooth(aes(y = sentiment_syuzhet, color = "Syuzhet"), se = FALSE) +
  geom_smooth(aes(y = sentiment_bing, color = "Bing"), se = FALSE) +
  geom_smooth(aes(y = sentiment_afinn, color = "AFINN"), se = FALSE) +
  labs(title = "Sentiment Trends in Bipolar Subreddit COVID-19 Posts",
       x = "Date", y = "Average Sentiment Score",
       color = "Lexicon") +
  theme_minimal()

# 5. Statistical Analysis
pandemic_date <- as.Date("2020-03-11")
data$period <- ifelse(data$date < pandemic_date, "Before", "After")

# Descriptive statistics for the "After" period
after_stats <- data %>%
  filter(period == "After") %>%
  summarize(
    mean_sentiment = mean(sentiment_syuzhet),
    median_sentiment = median(sentiment_syuzhet),
    sd_sentiment = sd(sentiment_syuzhet),
    min_sentiment = min(sentiment_syuzhet),
    max_sentiment = max(sentiment_syuzhet)
  )

print("Descriptive statistics for the period after pandemic declaration:")
print(after_stats)

# Time-based analysis
ggplot(data, aes(x = date, y = sentiment_syuzhet)) +
  geom_smooth(method = "loess") +
  labs(title = "Sentiment Trend Over Time",
       x = "Date", y = "Sentiment Score") +
  theme_minimal()

# 6. Visualization
# Emotion distribution
emotion_totals <- colSums(select(data, anger:trust))
emotion_percentages <- prop.table(emotion_totals) * 100

ggplot(data.frame(emotion = names(emotion_percentages), 
                  percentage = emotion_percentages), 
       aes(x = reorder(emotion, -percentage), y = percentage)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(title = "Distribution of Emotions in Bipolar Subreddit COVID-19 Posts",
       x = "Emotion", y = "Percentage") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 7. Word-level Analysis
word_frequencies <- data %>%
  unnest_tokens(word, processed_text) %>%
  count(word, sort = TRUE)

# 8. Topic Modeling
dtm <- data %>%
  unnest_tokens(word, processed_text) %>%
  count(post_id, word) %>%
  cast_dtm(post_id, word, n)

lda_model <- LDA(dtm, k = 5, control = list(seed = 1234))
topics <- tidy(lda_model, matrix = "beta")

top_terms <- topics %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

# Visualization for topic modeling removed

# 9. Contextual Analysis
set.seed(1234)
sample_posts <- data %>% 
  select(processed_text, sentiment_syuzhet) %>% 
  sample_n(10)

print(sample_posts)

# 10. Interpretation and Reporting
sentiment_summary <- data %>%
  summarize(
    mean_sentiment = mean(sentiment_syuzhet),
    sd_sentiment = sd(sentiment_syuzhet),
    min_sentiment = min(sentiment_syuzhet),
    max_sentiment = max(sentiment_syuzhet)
  )

print(sentiment_summary)

# 11. Final Report Generation
report <- paste(
  "Sentiment Analysis Report for Bipolar Subreddit COVID-19 Posts\n",
  "===========================================================\n",
  "\nOverall Sentiment Statistics:\n",
  paste("Mean Sentiment:", round(sentiment_summary$mean_sentiment, 2)),
  paste("Standard Deviation:", round(sentiment_summary$sd_sentiment, 2)),
  paste("Minimum Sentiment:", round(sentiment_summary$min_sentiment, 2)),
  paste("Maximum Sentiment:", round(sentiment_summary$max_sentiment, 2)),
  "\nDescriptive Statistics for Post-Pandemic Period:\n",
  paste("Mean Sentiment:", round(after_stats$mean_sentiment, 2)),
  paste("Median Sentiment:", round(after_stats$median_sentiment, 2)),
  paste("Standard Deviation:", round(after_stats$sd_sentiment, 2)),
  paste("Minimum Sentiment:", round(after_stats$min_sentiment, 2)),
  paste("Maximum Sentiment:", round(after_stats$max_sentiment, 2)),
  "\nTop 5 Most Frequent Words:\n",
  paste(word_frequencies$word[1:5], collapse = ", "),
  "\nDominant Emotions:\n",
  paste(names(sort(emotion_percentages, decreasing = TRUE)[1:3]), collapse = ", "),
  "\nKey Topics Identified:\n",
  paste("Topic", 1:5, sep = " "),
  sep = "\n"
)

cat(report)

# Save report to a text file
write(report, file = "sentiment_analysis_report.txt")

