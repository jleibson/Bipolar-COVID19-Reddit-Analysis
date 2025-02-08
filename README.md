# Bipolar-COVID19-Reddit-Analysis

## Overview
This project analyzes the impact of the COVID-19 pandemic on individuals with bipolar disorder by examining posts from the r/bipolar subreddit. Using natural language processing (NLP) techniques, we perform sentiment analysis and topic modeling on Reddit posts from 2020 to 2025, providing insights into the mental health challenges faced by this community during the pandemic.

## Features
- Data collection from Reddit using PRAW
- Text preprocessing and cleaning
- Sentiment analysis using multiple lexicons (AFINN, Bing, Syuzhet)
- Emotion detection using NRC lexicon
- Topic modeling using Latent Dirichlet Allocation (LDA)
- Time series analysis of sentiment trends
- Static and interactive visualizations

## Requirements
- Python (3.7 or higher)
- R (4.0 or higher)
- Required Python packages:
  - praw
  - pandas
  - datetime
- Required R packages:
  - tidyverse
  - syuzhet
  - topicmodels
  - ggplot2
  - plotly

## Code Structure
- reddit_bipolar_data.py: Functions to collect and preprocess Reddit data
- bipolar_covid_analysis.R: Core analysis functions including sentiment analysis, emotion detection, and topic modeling
- visualization.R: Code for generating static and interactive plots

## Installation
- Clone this repository: `git clone https://github.com/yourusername/Bipolar-COVID19-Reddit-Analysis.git`
- Navigate to the project directory: `cd Bipolar-COVID19-Reddit-Analysis`
- Install required Python packages: `pip install praw pandas`
- Install required R packages: 'install.packages(c("tidyverse", "syuzhet", "topicmodels", "ggplot2", "plotly"))'


## Usage
1. Edit `reddit_bipolar_data.py` to include your Reddit API credentials
2. Run `python reddit_bipolar_data.py` to collect data
3. Open `bipolar_covid_analysis.R` in RStudio
4. Run the script to perform the analysis and generate visualizations

## Output
- CSV file with collected and preprocessed Reddit data
- PNG files with sentiment trend plots and emotion distribution
- HTML file with interactive topic model visualization
- Text file with summary statistics and key findings

## Challenges and Limitations
- Reddit API rate limits affect data collection speed
- Analysis is based on public posts, which may not represent all individuals with bipolar disorder
- Sentiment analysis tools may not fully capture the nuances of mental health discussions

## Key Variables
- sentiment_score: Sentiment score of each post (-1 to 1)
- emotion_categories: Detected emotions in each post
- post_date: Date of the Reddit post
- subreddit_subscribers: Number of subscribers to r/bipolar at the time of posting

## Key Findings
- Overall negative sentiment trend, worsening over time
- Dominant emotions: sadness, trust, and anticipation
- Key topics: COVID-19's impact on manic episodes, job security, and emotional experiences

## Results and Visualization
Our analysis revealed a declining trend in sentiment over the course of the pandemic. Here's a sample visualization of this trend:


![image](https://github.com/user-attachments/assets/0125184a-aea3-4701-89de-f6e5e726b67c)



## Significance and Conclusion
This analysis provides crucial insights into the mental health challenges faced by individuals with bipolar disorder during the COVID-19 pandemic. By examining sentiment trends, emotional responses, and key discussion topics, we can better understand the unique struggles of this community. These findings can be valuable for:

1. Mental health professionals developing targeted interventions
2. Policymakers addressing the mental health impacts of global crises
3. Researchers studying the long-term effects of pandemics on vulnerable populations

The project demonstrates the potential of using social media data to gain real-time insights into mental health trends during unprecedented global events.

## Future Work
This project lays the groundwork for several important areas of future research:

1. **COVID-19 as a Trigger:** Investigate how COVID-19 may trigger or exacerbate bipolar disorder, even in individuals without prior psychiatric history. This could inform mental health screening protocols for COVID-19 patients.

2. **Bidirectional Relationship:** Explore the bidirectional relationship between COVID-19 and mental health disorders, emphasizing the need for comprehensive care that addresses both physical and mental health in COVID-19 patients.

3. **Neurological Impact:** Study the potential neuroinvasive effects of SARS-CoV-2 and its impact on the central nervous system, which may contribute to psychiatric symptoms. This opens avenues for neurological research in COVID-19-related mental health issues.

4. **Vulnerable Populations:** Further investigate why individuals with pre-existing psychiatric disorders, especially bipolar disorder, are at higher risk of COVID-19 infection and poorer outcomes. This could inform targeted preventive measures and care strategies.

Additional future work could include:
- Comparative analysis with other mental health subreddits
- Integration of machine learning models for more nuanced sentiment classification
- Longitudinal study to track long-term mental health impacts post-pandemic

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Contact
Joseph Leibson - joseph.leibson@gmail.com

Project Link: [https://github.com/jleibson/Bipolar-COVID19-Reddit-Analysis](https://github.com/jleibson/Bipolar-COVID19-Reddit-Analysis)
