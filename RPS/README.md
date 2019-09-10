# [Rock, Paper, Scissors](https://magnusjmj.github.io/APME/miniex8)
![Screenshot](https://github.com/MagnusJMJ/APME/blob/master/miniex8/screenshot.png)
---
### The Program
In the beginning, I wanted to base this mini-exercise on Daniel Shiffman's coding challenge
involving fractal trees. However, I ended up making this instead - a simple game of Rock,
Paper, Scissors, played against the computer. I made the switch mainly because I thought
it would be an interesting thing to code, and also because it is considerably easier
to illustrate in a flowchart than a recursively defined tree. Something to keep in mind
when reading the code is that I've put *much* more emphasis on HTML and CSS than the exercise
calls for, and also chosen to completely cut out libraries. This means that everything is
100% native JS/HTML/CSS, but also that you really have to read the HTML/CSS in addition
to the JS to get the full picture. Because we haven't really been taught HTML/CSS, I'll outline
what's going on here:
 * **index.html** contains all the content that is shown on the page. Text, images, you name it.
 These are the same kinds of elements we worked with in miniex7, except this time I've hardcoded
 them in the HTML-file.
 * **miniexercise8.js** is responsible for the *scripting*. It manipulates the DOM and decides
 what happens. The only way I've used JavaScript differently for this exercise is that I've mostly
 detached it from the visuals and changed those with CSS instead, which brings us to:
 * **style.css** is solely responsible for styling the DOM elements. Technically the sketch would
 work fine without the stylesheet, but it would be ugly default HTML. CSS makes complex styling (like
 gradual colour/scale change when hovering the cursor over an element) relatively easy! In this sense,
 CSS is a very powerful tool. Some of the styling I've included in the stylesheet would be complex
 and code-heavy to implement with just JavaScript.

### The challenges
While I was still working with the fractal tree script, it really dawned on me just how
difficult it can be to work with other people's code. Instead of adding functionality to
the script, I ended up spending most of my time making edits to make the code more like
_"how I would've written it"._ In addition, I had considerable issues not frying my brain
like a wet electrical circuit trying to wrap my head around recursive functions.
I also think having to make a flowchart of the program was more of a challenge than I had
first thought. Even though the "flow" of actions/processes I had to describe was fairly
straightforward (from a logical standpoint), it prompted me to actually reflect about
what was going on; especially  in terms of how to categorize the different steps (input/
process/decision, etc).

### The flowchart
![Screenshot](https://github.com/MagnusJMJ/APME/blob/bcfd44dc44306824c4f78afae42d43e36fd12fb9/miniex8/flowchart.png)
