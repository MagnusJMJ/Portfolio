// preloads assets and variables
var frenchLily, firstNames, lastNames, causeGen, grammar, people;
function preload() {
  frenchLily = loadImage('assets/frenchlily.png');
  firstNames = loadStrings('assets/names1.txt');
  lastNames  = loadStrings('assets/names2.txt');
  causeGen   = loadStrings('assets/causeGen.json');
  console.log('Preload, check!');
}

function setup() {
  createCanvas(windowWidth, windowHeight);
  imageMode(CENTER);
  noLoop();

  // RiGrammar makes a sentence based on the rules/options in our JSON file
  grammar = new RiGrammar(causeGen.join('\n'));

  // makes a list of people on start-up
  people = [];
  for (i = 0; i < 100; i++) {
    people[i] = new Person();
  }
  console.log('Setup, check!');
}

function draw() {

  // visuals
  background(255);
  noFill();
  strokeWeight(5);
  rect(20, 20, width-40, height-40);
  strokeWeight(2);
  rect(30, 30, width-60, height-60);

  push();
  translate(width/2, height/2);

  // typography
  fill(0);
  textFont('Times New Roman');
  textAlign(CENTER);
  textSize(48);
  textStyle(BOLD);
  text('OBITUARY', 0, -50);
  textSize(20);
  textStyle(NORMAL);
  text(people[0].firstName + ' ' + people[0].lastName, 0, 0);
  textStyle(ITALIC);
  text(people[0].birth + ' - ' + people[0].death, 0, 35);
  rectMode(CENTER);
  text(people[0].firstName + ' ' + people[0].cause, 0, 140, 400, 100);

  // more visuals
  image(frenchLily, 0, -200);
  line(-200, -40, 200, -40);
  text('\*', 0, 75);

  pop();
  console.log('Draw() was called!');
}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}

// pressing the mouse button displays a new obituary
function mousePressed() {
  shuffle(people, true);
  redraw();
  console.log('Mouse was clicked!');
}

// this constructor function makes people
function Person() {
  this.firstName = firstNames[round(random(firstNames.length - 1))];
  this.lastName  = lastNames[round(random(lastNames.length - 1))];
  this.age       = round(random(100));
  this.death     = round(random(2000, 2017));
  this.birth     = this.death - this.age;
  this.cause     = grammar.expand();
}
