# [The John Doe Obituary Generator](https://magnusjmj.github.io/APME/miniex5/)
![screenshot](https://github.com/MagnusJMJ/APME/blob/master/miniex5/obituarygenerator.png)
---
The John Doe Obituary Generator is exactly what it says on the tin. It generates obituaries for the average guy and gal, the John and Jane Doe - but with very unusual causes of death. Every person on the list is a composite of a random selection among the 100 most common first names and 100 most common last names in the United States. They each have a random year of birth (and death) sometime within the last century. The only thing unusual about them is their death. In fact, most of them are fairly absurd and in poor taste.

### Writing the program and implementing RiTa.js
Before I started writing the actual program, I'd determined that I wanted to experiment with three concepts:
 * Objects (as opposed to simple values)
 * Constructor functions (for making objects)
 * Arrays (for storing the objects)
 
When I first started reading up on objects, there was a recurring theme in the example code I found: The example object was 
often a person, a 'John Doe'.
```
var person = {
    firstName:"John",
    lastName:"Doe",
    age:50,
    eyeColor:"blue"
};
```
Normally, the name 'John Doe' is used as a generic catch-all name, used to refer to people of unknown identity. In crime literature, a 'John Doe' is typically an unidentified dead body. From there, the idea of making my objects dead people wasn't far away. But obituaries are fairly sinister business, and none of the functionality I'd implemented thus far required the use of the RiTa.js library - that's why I decided to include randomly generated causes of death. It's a feature that required RiTa.js to be feasible, and it added some much-needed comic relief to the project.

Implementing RiTa.js, however, would turn out to be a nightmare. At first, I tried to make RiTa.js generate sentences by way of a Markov-chain. The `RiMarkov()` function reads an input text and analyzes what words are likely to follow other words based on the instances of that word in the input you supply it. When prompted to generate a sentence, it then starts with a word that is likely to be first in a sentence, then picks a word that is likely to appear after that word, etc. The problem with Markov-chains is that apart from choosing the source material, you have very little control of how it writes; how it words itself. This was a problem because I needed it to generate a very specific kind of sentences.

Instead, I ended up using the`RiGrammar()` function. This proved much more useful, because suddenly i actually _knew what the hell I was doing_ (to an extent). `RiGrammar()` also generates sentences, but according to much more stringent rules. The function is told what components the sentence is going to have, and for each component, is is then given a set of strings to choose (randomly) from. While I _think_ it can be made to choose words from its own lexicon, I specifically told it what text it could write. The grammar reads from an external file, causeGen.json (`RiGrammar()` can only read "rules" written in the .json or .yaml syntax). This way, much more coherent (though also more monotonous) output could be generated.

### Finding and Working with Text
Trying to find lists of names to feed the program led me to more pregnancy-related websites than I knew existed. In an early version, the list was comprised of the most popular _baby_-names, meaning a lot of the objects/people ended up with names like "Noah" and "Autumn". That didn't quite fit the bill, considering the feel I was going for, so instead I found a list of the most common names of all people today, old and young.

When I was still trying to implement the markov-chain function in my program, I also had the pleasure of googling "funny obituaries". The results were surprisingly heartwarming, but I was not able to amass anywhere near the amount of samples to feed a competent Markov chain. Instead, Cards Against Humanity actually proved very useful once I switched to `RiGrammar()`. Not because I fed it text from CAH, but because they are generally worded in ways that make many different cards fit together seamlessly, which is essentially what I had to do with my own text samples in the .json file.

### The Materiality of Text and Interface
One of the defining properties of my program (in my opinion) is the way it is portrayed visually. The typeface, colours and other visuals (namely the french lily) was made to emulate obituaries in newspapers. It makes no effort to present itself _as_ a generator, or even as a computer program.
