library(twitteR)
library(ROAuth)
requestURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
consumerKey <- "8kb0nStdvvCvweN8Qvf9yUPaJ"
consumerSecret <- "kx470OqsATIQarO1GYY3MLUjrnG74J722pP3kAu4t2G70f6si9"
my_oauth <- OAuthFactory$new(consumerKey=consumerKey,
                             consumerSecret=consumerSecret, requestURL=requestURL,
                             accessURL=accessURL, authURL=authURL)
my_oauth$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
save(my_oauth, file="backup/oauth_token.Rdata")
save(my_oauth, file="oauth_token.Rdata")
accessToken = '14851168-3ePk0sagpEJZzOWUa9RYFBv2AwhPl6mlvX9LirqgO'
accessSecret = '4WBb5FzvsDGNKTEtTxc5GsQIva2BLjk7ZpuAskQrtZ6oP'

setup_twitter_oauth(consumer_key=consumerKey, consumer_secret=consumerSecret,
                    access_token=accessToken, access_secret=accessSecret)

tweets <- searchTwitter("#blessed", n=5000)
tweets <- twListToDF(tweets)

write.csv(tweets, "blessed.csv")

tweets <- searchTwitter("#yolo", n=5000)
tweets <- twListToDF(tweets)

write.csv(tweets, "yolo.csv")

tweets <- searchTwitter("libertarian", n=5000)
tweets <- twListToDF(tweets)

write.csv(tweets, "libertarian.csv")

tweets <- searchTwitter("taxes", n=5000)
tweets <- twListToDF(tweets)

write.csv(tweets, "taxes.csv")


timeline <- userTimeline('realDonaldTrump', n=3200)
timeline <- twListToDF(timeline)

write.csv(timeline, "trump.csv")

timeline <- userTimeline('chancetherapper', n=3200)
timeline <- twListToDF(timeline)

write.csv(timeline, "chance.csv")

timeline <- userTimeline('chrissyteigen', n=3200)
timeline <- twListToDF(timeline)

write.csv(timeline, "teigen.csv")

timeline <- userTimeline('SenSanders', n=3200)
timeline <- twListToDF(timeline)

write.csv(timeline, "bernie.csv")

timeline <- userTimeline('SpeakerRyan', n=3200)
timeline <- twListToDF(timeline)

write.csv(timeline, "paulryan.csv")

timeline <- userTimeline('SenWarren', n=3200)
timeline <- twListToDF(timeline)

write.csv(timeline, "warren.csv")









