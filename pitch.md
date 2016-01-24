Rapid Word Detection
========================================================
author: Asa Downs
date: 1.17.2016
font-import: http://fonts.googleapis.com/css?family=Roboto+Slab
font-family: 'Roboto Slab'
transition:concave
transition-speed:slow
incremental:true

A Need for Text Prediction
========================================================
type:alert
Smartphones continue to become the focal point of more and more digital interaction. Many of the most common interactions on a smartphone require text input. Fast and accurate text prediction provides a major opportunity for improving user’ smartphone experience.
  - 64% of American adult own a smartphone
  - Americans are more likely to interact with digital media on their smartphones than any other devices
  - The most common activity for users on their cell phones is to send and receive text messages
  - Americans spend nearly 5 hours a day on their cellphone 15% of that is spent texting or on chat

The Algorithm
========================================================
<small>Our algorithm uses an extremely straightforward (naive) N-gram approach to text prediction. This is mainly to provide an exceptionally responsive feel to the application that would allow users to interact with the algorithm as quickly as they are able to type. We made a conscious decision in favor of speed and clarity at the cost of accuracy.</small>

<small>We take the phrase the user enters, clean it (removing profanity, capitalization, numeric characters, punctuation) and reduce it to it’s last 4 words (4-gram) we then select the last word from the most common (highest frequency) 5-gram i.e. "a lot of the" -> "people". If no match is found we strip off the first word of our n-gram and check for a matching (n-1)-gram until we get down to two word combinations. If no matches are found we default to the most common word in the English language, "the".</small>

<small>The data is taken from the Corpus of Contemporary American English. This data was found to be the cleanest data source available and more balanced than other corpora. For speed we use 1M 2,3,4,5-grams each.</small>

The Application
========================================================
Our application allows users to paste or type text into a text area. As the user types the next word is automatically predicted. The suggested word appears in the blue box below the text input area. The second and third suggested word where available appear in the white boxes to the left and right of the blue box and are also selectable. 

The application works in real-time and will re-analyze the message as the user types and provide new suggestions. This occurs whether the user types a new word or takes from one of the suggested words. In either case, the text input area is updated and a new prediction is made.

The Pitch
========================================================
type:prompt
Our simple application demonstrates the ability to do rapid predictive text. Your support of this project will allow us to use a larger corpora and a wider array of corpora.

Although we have done some Good-Turing frequency estimation the sheer complexity of the English language means that there are many infrequent and unseen N-grams even with an extremely large corpora. We would like to use multiple corpora for different contexts to provide a user more appropriate suggestions for texting/chatting, searching, writing long-form content, and tweeting.

Our next step in development is to add information on colocations and word associations to our algorithm so that we can more appropriately pick the right follow up word to the overall subject matter the user is typing about. We believe this can be done without an excessive impact on performance.
