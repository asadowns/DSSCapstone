library(tm)
library(filehash)
library(dplyr)
#library(filehashSQLite)
library(SnowballC)
library(ggplot2)   

setwd("~/RProg/DSSCapstone")
source <- DirSource("raw/final/en_US/") #input path for documents
dbName <- "dsscorpus"
#corpus <- PCorpus(source, readerControl=list(reader=readPlain,language="en"), dbControl=list(useDb=TRUE,dbName=dbName, dbType="DB1"))

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

corpus <- tm_map(corpus,removeNumbers)
corpus <- tm_map(corpus,removePunctuation)
corpus <- tm_map(corpus,scontent_transformer(tolower))
corpus <- tm_map(corpus, removeWords,stopwordsProfane)
corpus< <- tm_map(corpus,stripWhitespace)
corpus - tm_map(clopus, stemDocument)
NgramTokenizer <- function(x, n) unlist(lapply(ngrams(words(x),n), paste, collapse = " "), use.names = FALSE)
tm <- DocumentTermMatrix(corpus, list(tokenize = function(x) NgramTokenizer(x,5)))
freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)
quant(freq)
wordFreq <- data.frame(word=names(freq), freq=freq)

fivePertwitter <- VCorpus(VectorSource(sample(twitter$content, round((length(twitter$content)*.01)))))
fivePerblogs <- VCorpus(VectorSource(sample(blogs$content, round((length(blogs$content)*.01)))))
fivePernews <- VCorpus(VectorSource(sample(news$content, round((length(news$content)*.01)))))
fivePerCorpus <- c(fivePertwitter,fivePerblogs,fivePernews)
dtmFivePercent <- DocumentTermMatrix(fivePerCorpus)
dtmFivePercentBigram <- DocumentTermMatrix(fivePerCorpus, list(tokenize = function(x) NgramTokenizer(x,2)))
dtmFivePercentTrigram <- DocumentTermMatrix(fivePerCorpus, list(tokenize = function(x) NgramTokenizer(x,3)))
dtmFivePercent4gram <- DocumentTermMatrix(fivePerCorpus, list(tokenize = function(x) NgramTokenizer(x,4)))
dtmFivePercent5gram <- DocumentTermMatrix(fivePerCorpus, list(tokenize = function(x) NgramTokenizer(x,5)))

plot <- ggplot(subset(wordFreq, freq>50), aes(word, freq))    
plot <- plot + geom_bar(stat="identity")  
plot <- plot + theme(axis.text.x=element_text(angle=45, hjust=1))   
plot   


newCorpus <- PCorpus(source, readerControl=list(reader=readPlain,language="en"), dbControl=list(useDb=TRUE,dbName=dbName, dbType="DB1"))

dtmTotal <- db %>% 
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  tm_map(content_transformer(tolower)) %>%
  DocumentTermMatrix()

dmNoStop <- corpus %>% 
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace) %>%
  tm_map(content_transformer(tolower)) %>%
  tm_map(removeWords,stopwordsProfane) %>%
  DocumentTermMatrix()


findFreqTerms(dtmNoStop,100)

findAssocs(dtmTotal,"the",0.8)
