library(tidytext)
library(dplyr)
library(wordcloud2)


text <- c("I am typing into this line",
          "And having a great time",
          "This is really fun",
          "and I am going to love this summer")

text


text_df <- data_frame(line = 1:4, text = text)

text_df %>%
  unnest_tokens(word, text)

tidy <- text_df %>%
  unnest_tokens(word, text)

tidy <- tidy %>% count(word, sort = TRUE)

wordcloud2(data=tidy)

## What about boring words?? 

stop_words

tidy %>% anti_join(stop_words)

## Sentiment Analysis 
## "nrc" "afinn" "bing"

get_sentiments("afinn")

tidy %>% inner_join(get_sentiments("bing"))
tidy %>% inner_join(get_sentiments("nrc"))


tidy %>% inner_join(get_sentiments("afinn")) 




