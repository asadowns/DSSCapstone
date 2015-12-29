library(tm)
library(filehash)
library(dplyr)
#library(filehashSQLite)
library(SnowballC)
library(ggplot2)  
library(R.utils)
setwd("~/RProg/DSSCapstone")

if (!file.exists('Coursera-SwiftKey.zip')) {
  download.file('https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip','Coursera-SwiftKey.zip', method='curl')
  downloadDate <- date()  
}

if (!file.exists('raw')) {
  unzip('Coursera-SwiftKey.zip', exdir="./raw")
}

if (!file.exists('1percent')) {
  twitterFile <- file("raw/final/en_US/en_US.twitter.txt", "r")
  twitter <- readLines(twitterFile)
  close(twitterFile)
  sampledTwitter <- sample(twitter,length(twitter)*0.01)
  output<-file("1percent/twitter.txt")
  writeLines(sampledTwitter, output)
  close(output)
  twitterLines <- countLines("raw/final/en_US/en_US.twitter.txt")[1]
  twitterMax <- max(nchar(twitter))
  
  blogsFile <- file("raw/final/en_US/en_US.blogs.txt", "r")
  blogs <- readLines(blogsFile)
  close(blogsFile)
  sampledblogs <- sample(blogs,length(blogs)*0.01)
  output<-file("1percent/blogs.txt")
  writeLines(sampledblogs, output)
  close(output)
  blogsLines <- countLines("raw/final/en_US/en_US.blogs.txt")[1]
  blogsMax <- max(nchar(blogs))
  
  newsFile <- file("raw/final/en_US/en_US.news.txt", "r")
  news <- readLines(newsFile)
  close(newsFile)
  samplednews <- sample(news,length(news)*0.01)
  output<-file("1percent/news.txt")
  writeLines(samplednews, output)
  close(output)
  newsLines <- countLines('raw/final/en_US/en_US.news.txt')[1]
  newsMax <- max(nchar(news))
}

source <- DirSource("1percent/") #input path for documents
dbName <- "onepercentcorpus"
if(!file.exists(dbName)){
  corpus <- PCorpus(source, readerControl=list(reader=readPlain,language="en"), dbControl=list(useDb=TRUE,dbName=dbName, dbType="DB1"))
} else {
  db <- dbInit(dbName, "DB1")
  files <- dbLoad(db)
  blogs <- dbFetch(db,'blogs.txt')
  twitter <- dbFetch(db,'twitter.txt')
  news <- dbFetch(db,'news.txt')
  corpus <- c(blogs,twitter,news)
}

profane <- "2g1c, 2 girls 1 cup, acrotomophilia, alabama hot pocket, alaskan pipeline, anal, anilingus, anus, apeshit, arsehole, ass, asshole, assmunch, auto erotic, autoerotic, babeland, baby batter, baby juice, ball gag, ball gravy, ball kicking, ball licking, ball sack, ball sucking, bangbros, bareback, barely legal, barenaked, bastardo, bastinado, bbw, bdsm, beaner, beaners, beaver cleaver, beaver lips, bestiality, big black, big breasts, big knockers, big tits, bimbos, birdlock, bitch, bitches, black cock, blonde action, blonde on blonde action, blowjob, blow job, blow your load, blue waffle, blumpkin, bollocks, bondage, boner, boob, boobs, booty call, brown showers, brunette action, bukkake, bulldyke, bullet vibe, bullshit, bung hole, bunghole, busty, butt, buttcheeks, butthole, camel toe, camgirl, camslut, camwhore, carpet muncher, carpetmuncher, chocolate rosebuds, circlejerk, cleveland steamer, clit, clitoris, clover clamps, clusterfuck, cock, cocks, coprolagnia, coprophilia, cornhole, coon, coons, creampie, cum, cumming, cunnilingus, cunt, darkie, date rape, daterape, deep throat, deepthroat, dendrophilia, dick, dildo, dirty pillows, dirty sanchez, doggie style, doggiestyle, doggy style, doggystyle, dog style, dolcett, domination, dominatrix, dommes, donkey punch, double dong, double penetration, dp action, dry hump, dvda, eat my ass, ecchi, ejaculation, erotic, erotism, escort, ethical slut, eunuch, faggot, fecal, felch, fellatio, feltch, female squirting, femdom, figging, fingerbang, fingering, fisting, foot fetish, footjob, frotting, fuck, fuck buttons, fucking, fudge packer, fudgepacker, futanari, gang bang, gay sex, genitals, giant cock, girl on, girl on top, girls gone wild, goatcx, goatse, god damn, gokkun, golden shower, goodpoop, goo girl, goregasm, grope, group sex, g-spot, guro, hand job, handjob, hard core, hardcore, hentai, homoerotic, honkey, hooker, hot carl, hot chick, how to kill, how to murder, huge fat, humping, incest, intercourse, jack off, jail bait, jailbait, jelly donut, jerk off, jigaboo, jiggaboo, jiggerboo, jizz, juggs, kike, kinbaku, kinkster, kinky, knobbing, leather restraint, leather straight jacket, lemon party, lolita, lovemaking, make me come, male squirting, masturbate, menage a trois, milf, missionary position, motherfucker, mound of venus, mr hands, muff diver, muffdiving, nambla, nawashi, negro, neonazi, nigga, nigger, nig nog, nimphomania, nipple, nipples, nsfw images, nude, nudity, nympho, nymphomania, octopussy, omorashi, one cup two girls, one guy one jar, orgasm, orgy, paedophile, paki, panties, panty, pedobear, pedophile, pegging, penis, phone sex, piece of shit, pissing, piss pig, pisspig, playboy, pleasure chest, pole smoker, ponyplay, poof, poon, poontang, punany, poop chute, poopchute, porn, porno, pornography, prince albert piercing, pthc, pubes, pussy, queaf, queef, quim, raghead, raging boner, rape, raping, rapist, rectum, reverse cowgirl, rimjob, rimming, rosy palm, rosy palm and her 5 sisters, rusty trombone, sadism, santorum, scat, schlong, scissoring, semen, sex, sexo, sexy, shaved beaver, shaved pussy, shemale, shibari, shit, shitty, shota, shrimping, skeet, slanteye, slut, s&m, smut, snatch, snowballing, sodomize, sodomy, spic, splooge, splooge moose, spooge, spread legs, spunk, strap on, strapon, strappado, strip club, style doggy, suck, sucks, suicide girls, sultry women, swastika, swinger, tainted love, taste my, tea bagging, threesome, throating, tied up, tight white, tit, tits, titties, titty, tongue in a, topless, tosser, towelhead, tranny, tribadism, tub girl, tubgirl, tushy, twat, twink, twinkie, two girls one cup, undressing, upskirt, urethra play, urophilia, vagina, venus mound, vibrator, violet wand, vorarephilia, voyeur, vulva, wank, wetback, wet dream, white power, wrapping men, wrinkled starfish, xx, xxx, yaoi, yellow showers, yiffy, zoophilia, 🖕"
stopwordsProfane <- tolower(c(stopwords('en'),profane))
NgramTokenizer <- function(x, n) unlist(lapply(ngrams(words(x),n), paste, collapse = " "), use.names = FALSE)
corpus <- tm_map(corpus,removeNumbers)
corpus <- tm_map(corpus,removePunctuation)
corpus <- tm_map(corpus,content_transformer(tolower))
corpus <- tm_map(corpus, removeWords,stopwordsProfane)
corpus <- tm_map(corpus,stripWhitespace)

dtmUnagram <- DocumentTermMatrix(corpus)
freq <- sort(colSums(as.matrix(dtmUnagram)), decreasing=TRUE)
asciiNames <- iconv(names(freq),"latin1","ASCII")
freq <- freq[!is.na(asciiNames)]
quantile(freq, seq(0,1,0.1))
frame <- data.frame(word=names(freq), freq=freq)
frame <- transform(frame, word = reorder(word, freq)) 
frame <- top_n(frame,20,freq)
plot1 <- ggplot(frame, aes(word, freq)) + 
  geom_bar(stat="identity",aes(order=desc(freq))) + 
  theme(axis.text.x=element_text(angle=45, hjust=1))   
plot1   

dtmBigram <- DocumentTermMatrix(corpus, list(tokenize = function(x) NgramTokenizer(x,2)))
freqBigram <- sort(colSums(as.matrix(dtmBigram)), decreasing=TRUE)
quantile(freqBigram, seq(0,1,0.1))
frameBigram <- data.frame(word=names(freqBigram), freq=freqBigram)
frameBigram <- transform(frameBigram, word = reorder(word, freq)) 
frameBigram <- top_n(frameBigram,20,freq)
plot2 <- ggplot(frameBigram, aes(word, freq)) + 
  geom_bar(stat="identity") + 
  theme(axis.text.x=element_text(angle=45, hjust=1))   
plot2  

dtmTrigram <- DocumentTermMatrix(corpus, list(tokenize = function(x) NgramTokenizer(x,3)))
freqTrigram <- sort(colSums(as.matrix(dtmTrigram)), decreasing=TRUE)
quantile(freqTrigram, seq(0,1,0.1))
frameTrigram <- data.frame(word=names(freqTrigram), freq=freqTrigram)
frameTrigram <- transform(frameTrigram, word = reorder(word, freq)) 
frameTrigram <- top_n(frameTrigram,20,freq)
plot3 <- ggplot(frameTrigram, aes(word, freq)) + 
  geom_bar(stat="identity") + 
  theme(axis.text.x=element_text(angle=45, hjust=1))   
plot3

dtm4gram <- DocumentTermMatrix(corpus, list(tokenize = function(x) NgramTokenizer(x,4)))
freq4gram <- sort(colSums(as.matrix(dtm4gram)), decreasing=TRUE)
quantile(freq4gram, seq(0,1,0.1))
frame4gram <- data.frame(word=names(freq4gram), freq=freq4gram)
frame4gram <- transform(frame4gram, word = reorder(word, freq)) 
frame4gram <- top_n(frame4gram,20,freq)
plot4 <- ggplot(frame4gram, aes(word, freq)) + 
  geom_bar(stat="identity") + 
  theme(axis.text.x=element_text(angle=45, hjust=1))   
plot4

dtm5gram <- DocumentTermMatrix(corpus, list(tokenize = function(x) NgramTokenizer(x,5)))
freq5gram <- sort(colSums(as.matrix(dtm5gram)), decreasing=TRUE)
quantile(freq5gram, seq(0,1,0.1))
frame5gram <- data.frame(word=names(freq5gram), freq=freq5gram)
frame5gram <- transform(frame5gram, word = reorder(word, freq)) 
frame5gram <- top_n(frame5gram,20,freq)
plot5 <- ggplot(frame5gram, aes(word, freq)) + 
  geom_bar(stat="identity") + 
  theme(axis.text.x=element_text(angle=45, hjust=1))   
plot5

gramFreq <- list(freqBigram,freqTrigram,freq4gram,freq5gram)

predictNgram <- function(sentence) {
  processed <- sentence %>% removeNumbers %>%
    removePunctuation() %>%
    tolower() %>%
    removeWords(stopwordsProfane) %>%
    stripWhitespace() %>%
    trim()
  print(processed)
  strlength <- str_count(processed,"\\w+")
  if (strlength>4) strlength <- 4
  pattern <- paste(rep("\\w+\\s+",strlength-1),collapse = "",sep="")
  pattern <- paste0(pattern,"\\w+$")
  predictor <- str_extract(processed,pattern)
  print(predictor)
  gram <- gramFreq[[strlength]]
  print(strlength-1)
  phraseMatch <- names(which.max(gram[grepl(paste0("^",predictor), names(gram))]))
  print(phraseMatch)
  if (!is.null(phraseMatch)) {
    match <- str_extract(phraseMatch,'\\w+$')
    return(match)
  }
  else if (strlength>1){
    pattern <- paste(replicate(strlength-2, "\\w+\\s+"), collapse = "")
    pattern <- paste0(pattern,"\\w+$")
    sentence <- str_extract(processed,pattern)
    predictNgram(sentence)
  }
  else {
    print('no prediction')
  }
}


predictSentence <- function(sentence) {
  processed <- sentence %>% removeNumbers %>%
    removePunctuation() %>%
    tolower() %>%
    removeWords(stopwordsProfane) %>%
    stripWhitespace() %>%
    trim()
  print(processed)
  strlength <- str_count(processed,"\\w+")
    if (strlength>2) {
      pattern <- "\\w+\\s+\\w+\\s+\\w+$"
      predictor <- str_extract(processed,pattern)
      print(predictor)
      phraseMatch <- names(which.max(freq4gram[grepl(paste0("^",predictor), names(freq4gram))]))
      print(phraseMatch)
      match <- str_extract(phraseMatch,'\\w+$')
    }
    if (strlength>1) {
      pattern <- "\\w+\\s+\\w+$"
      predictor <- str_extract(processed,pattern)
      phraseMatch <- names(which.max(freqTrigram[grepl(paste0("^",predictor), names(freqTrigram))]))
    }
    if (strlength>0) {
      pattern <- "\\w+$"
      predictor <- str_extract(processed,pattern)
      phraseMatch <- names(which.max(freqBigram[grepl(paste0("^",predictor), names(freqBigram))]))
    }
  match <- str_extract(phraseMatch,'\\w+$')
match

}

