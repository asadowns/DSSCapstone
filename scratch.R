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

twitterFile <- file("raw/final/en_US/en_US.twitter.txt", "r")
twitter <- readLines(twitterFile)
close(twitterFile)
sampledTwitter <- sample(twitter,length(twitter)*0.01)
output<-file("1percent/twitter.txt")
writeLines(sampledTwitter, output)
close(output)
blogsLines <- countLines(twitter)
blogsMax <- max(nchar(twitter))

blogsFile <- file("raw/final/en_US/en_US.blogs.txt", "r")
blogs <- readLines(blogsFile)
close(blogsFile)
sampledblogs <- sample(blogs,length(blogs)*0.01)
output<-file("1percent/blogs.txt")
writeLines(sampledBlogs, output)
close(output)
blogsLines <- countLines(blogs)
blogsMax <- max(nchar(blogs))

newsFile <- file("raw/final/en_US/en_US.news.txt", "r")
news <- readLines(newsFile)
close(newsFile)
samplednews <- sample(news,length(news)*0.01)
output<-file("1percent/news.txt")
writeLines(samplednews, output)
close(output)
newsLines <- countLines(news)
newsMax <- max(nchar(news))


readLines(con, 1) 
## Read the first line of text 
readLines(con, 1) 
## Read the next line of text 
readLines(con, 5) 
## Read in the next 5 lines of text 
close(con) 
## It's important to close the connection when you are done

source <- DirSource("raw/final/en_US/") #input path for documents
corpus <- PCorpus(source, readerControl=list(reader=readPlain,language="en"), dbControl=list(dbName="dsscorpus", dbType="DB1"))
#corpusTwitter <- Corpus(twitter, readerControl=list(reader=readPlain,language="en"))

twitter <- readLines(twitterFile, 1000)

vsTwitter <- VectorSource(twitter)
corpusTwitter <- VCorpus(vsTwitter)
dtmTotal <- corpusTwitter %>% 
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  tm_map(content_transformer(tolower)) %>%
  DocumentTermMatrix()

profane <- "2g1c, 2 girls 1 cup, acrotomophilia, alabama hot pocket, alaskan pipeline, anal, anilingus, anus, apeshit, arsehole, ass, asshole, assmunch, auto erotic, autoerotic, babeland, baby batter, baby juice, ball gag, ball gravy, ball kicking, ball licking, ball sack, ball sucking, bangbros, bareback, barely legal, barenaked, bastardo, bastinado, bbw, bdsm, beaner, beaners, beaver cleaver, beaver lips, bestiality, big black, big breasts, big knockers, big tits, bimbos, birdlock, bitch, bitches, black cock, blonde action, blonde on blonde action, blowjob, blow job, blow your load, blue waffle, blumpkin, bollocks, bondage, boner, boob, boobs, booty call, brown showers, brunette action, bukkake, bulldyke, bullet vibe, bullshit, bung hole, bunghole, busty, butt, buttcheeks, butthole, camel toe, camgirl, camslut, camwhore, carpet muncher, carpetmuncher, chocolate rosebuds, circlejerk, cleveland steamer, clit, clitoris, clover clamps, clusterfuck, cock, cocks, coprolagnia, coprophilia, cornhole, coon, coons, creampie, cum, cumming, cunnilingus, cunt, darkie, date rape, daterape, deep throat, deepthroat, dendrophilia, dick, dildo, dirty pillows, dirty sanchez, doggie style, doggiestyle, doggy style, doggystyle, dog style, dolcett, domination, dominatrix, dommes, donkey punch, double dong, double penetration, dp action, dry hump, dvda, eat my ass, ecchi, ejaculation, erotic, erotism, escort, ethical slut, eunuch, faggot, fecal, felch, fellatio, feltch, female squirting, femdom, figging, fingerbang, fingering, fisting, foot fetish, footjob, frotting, fuck, fuck buttons, fucking, fudge packer, fudgepacker, futanari, gang bang, gay sex, genitals, giant cock, girl on, girl on top, girls gone wild, goatcx, goatse, god damn, gokkun, golden shower, goodpoop, goo girl, goregasm, grope, group sex, g-spot, guro, hand job, handjob, hard core, hardcore, hentai, homoerotic, honkey, hooker, hot carl, hot chick, how to kill, how to murder, huge fat, humping, incest, intercourse, jack off, jail bait, jailbait, jelly donut, jerk off, jigaboo, jiggaboo, jiggerboo, jizz, juggs, kike, kinbaku, kinkster, kinky, knobbing, leather restraint, leather straight jacket, lemon party, lolita, lovemaking, make me come, male squirting, masturbate, menage a trois, milf, missionary position, motherfucker, mound of venus, mr hands, muff diver, muffdiving, nambla, nawashi, negro, neonazi, nigga, nigger, nig nog, nimphomania, nipple, nipples, nsfw images, nude, nudity, nympho, nymphomania, octopussy, omorashi, one cup two girls, one guy one jar, orgasm, orgy, paedophile, paki, panties, panty, pedobear, pedophile, pegging, penis, phone sex, piece of shit, pissing, piss pig, pisspig, playboy, pleasure chest, pole smoker, ponyplay, poof, poon, poontang, punany, poop chute, poopchute, porn, porno, pornography, prince albert piercing, pthc, pubes, pussy, queaf, queef, quim, raghead, raging boner, rape, raping, rapist, rectum, reverse cowgirl, rimjob, rimming, rosy palm, rosy palm and her 5 sisters, rusty trombone, sadism, santorum, scat, schlong, scissoring, semen, sex, sexo, sexy, shaved beaver, shaved pussy, shemale, shibari, shit, shitty, shota, shrimping, skeet, slanteye, slut, s&m, smut, snatch, snowballing, sodomize, sodomy, spic, splooge, splooge moose, spooge, spread legs, spunk, strap on, strapon, strappado, strip club, style doggy, suck, sucks, suicide girls, sultry women, swastika, swinger, tainted love, taste my, tea bagging, threesome, throating, tied up, tight white, tit, tits, titties, titty, tongue in a, topless, tosser, towelhead, tranny, tribadism, tub girl, tubgirl, tushy, twat, twink, twinkie, two girls one cup, undressing, upskirt, urethra play, urophilia, vagina, venus mound, vibrator, violet wand, vorarephilia, voyeur, vulva, wank, wetback, wet dream, white power, wrapping men, wrinkled starfish, xx, xxx, yaoi, yellow showers, yiffy, zoophilia, 🖕"
stopwordsProfane <- tolower(c(stopwords('en'),profane))
dtmNoStop <- corpusTwitter %>% 
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeWords,stopwordsProfane) %>%
  DocumentTermMatrix()
  
findFreqTerms(dtmNoStop,10)

findAssocs(dtmTotal,"the",0.8)

noStop <- tbl_df(as.data.frame(inspect(dtmNoStop)))
noStopSum <- sapply(noStop,sum)
head(sort(noStopSum, decreasing=TRUE),50)

total <- tbl_df(as.data.frame(inspect(dtmTotal)))
totalSum <- sapply(total,sum)
head(sort(totalSum, decreasing=TRUE),50)

twitter <- readChar('raw/final/en_US/en_US.twitter.txt', file.info('raw/final/en_US/en_US.twitter.txt')$size)

#inspect(DocumentTermMatrix(corpusTwitter, list(dictionary = c("the"))))

NgramTokenizer <- function(x, n) unlist(lapply(ngrams(words(x),n), paste, collapse = " "), use.names = FALSE)

tdmNoStop <- corpusTwitter %>% 
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeWords,stopwordsProfane) %>%
  TermDocumentMatrix(control = list(tokenize = function(x) NgramTokenizer(x,3)))


tdm <- TermDocumentMatrix(crude, control = list(tokenize = function(x) NgramTokenizer(x,3)))
inspect(tdm[,1:10])
#inspect(removeSparseTerms(tdm[, 1:10], 0.7))

