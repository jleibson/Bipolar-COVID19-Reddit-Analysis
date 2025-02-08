import praw
import pandas as pd
from datetime import datetime
import re
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords

import nltk
import ssl

try:
    _create_unverified_https_context = ssl._create_unverified_context
except AttributeError:
    pass
else:
    ssl._create_default_https_context = _create_unverified_https_context

nltk.download('stopwords')
nltk.download('punkt')
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
stop_words = set(stopwords.words('english'))

# Initialize Reddit API client
reddit = praw.Reddit(client_id='-OmT9zxMU9nYXQIiTdGgEA',
                     client_secret='7z-ApyhH_e-J4-NeiCzraGfFNqqnGA',
                     user_agent='MyApp/1.0 by No-Information-4841')

# Scrape posts from r/bipolar
subreddit = reddit.subreddit('bipolar')
posts = []
for post in subreddit.search('covid', limit=1000):
    if re.search(r'manic|mania|episode', post.selftext, re.IGNORECASE):
        posts.append([post.id, datetime.fromtimestamp(post.created_utc), post.selftext])

# Create DataFrame
df = pd.DataFrame(posts, columns=['post_id', 'date', 'text'])

# Preprocess text
stop_words = set(stopwords.words('english'))

def preprocess(text):
    text = re.sub(r'http\S+', '', text)
    tokens = word_tokenize(text.lower())
    return ' '.join([word for word in tokens if word.isalnum() and word not in stop_words])

df['processed_text'] = df['text'].apply(preprocess)

# Save to CSV
df.to_csv('bipolar_covid_posts.csv', index=False)

nltk.download('punkt')
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
