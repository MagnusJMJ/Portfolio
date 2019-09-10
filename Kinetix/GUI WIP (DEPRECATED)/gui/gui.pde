import processing.sound.*;

PFont openSans;
PImage goodImg;
PImage badImg;
PImage hand;
PImage chevron;
PImage throbber;
SoundFile goodSound;
SoundFile badSound;
int fade = 0;
int stateIndex;
int frames = 0;

void setup() {
  fullScreen();
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER);
  openSans = createFont("Open Sans", 64, true);
  textFont(openSans);
  goodImg = loadImage("ok.png");
  badImg = loadImage("no.png");
  hand = loadImage("hand.png");
  chevron = loadImage("chevron.png");
  throbber = loadImage("throbber.png");
  goodSound = new SoundFile(this, "ok.wav");
  badSound = new SoundFile(this, "no.wav");
}

void draw() {
  translate(width/2, height/2);
  background(92, 147, 237, 200);
  noStroke();

  frames++;
  if (frames < 51) {fade += 5;}

  switch (stateIndex) {
    case 0:
      initState();
      break;
    case 1:
      nfcState(123.45);
      break;
    case 2:
      gestureState();
      break;
    case 3:
      endState(true);
      break;
    default:
      initState();
      break;
  }
}

void initState() {
  tint(255, fade);
  image(hand, 0, cos(frames)*15);
  fill(255, fade);
  textAlign(CENTER);
  textSize(64);
  text("Betal med Kinetix™", 0, -340);
}

void buyState(float price) {
  textAlign(LEFT, CENTER);
  fill(255, fade-150);
  textSize(48);
  text("At betale: ", -300, -50);
  fill(255, fade);
  textSize(36);
  text(price + "Kr.", -300, 0);
  textAlign(CENTER);
  text("Verificér med wearable", 0, 200);
  tint(255, fade);
  throbber(0, 275);
}

void nfcState(float price) {
  textAlign(LEFT, CENTER);
  fill(255, fade-150);
  textSize(48);
  text("At betale: ", -300, -50);
  fill(255, fade);
  textSize(36);
  text(price + "Kr.", -300, 0);
  textAlign(CENTER);
  text("Verificér med wearable", 0, 150);
  tint(255, fade);
  throbber(0, 250);
}

void gestureState() {
  textAlign(CENTER);
  fill(255, fade);
  text("Succes! Verificér med fagt", 0, 50);
  tint(255, fade);
  throbber(0, 150);
}

void throbber(int x, int y) {
  translate(x, y);

  // angle += 5;
  float value = cos(radians(frames)) * 24.0;
  for (float a = 0; a < 360; a += 22.5) {
    float xOff = cos(radians(a)) * value+20;
    float yOff = sin(radians(a)) * value+20;
    fill(0, 255, 0);
    ellipse(xOff, yOff, value/2, value/2);
  }

  translate(-x,-y);
}

void endState(boolean succ) {
  textAlign(CENTER);
  tint(255, fade);
  fill(255, fade);
  if (succ) {
    text("Tak fordi du brugte Kinetix", 0, -100);
    image(goodImg, 0, 100, 250, 250);
  } else {
    text("Fejl - prøv igen", 0, -100);
    image(badImg, 0, 100, 250, 250);
  }
}

// for testing purposes
void keyPressed() {
  switch (keyCode) {
    case 37:
      stateIndex--;
      frames = 0;
      fade   = 0;
      break;
    case 39:
      stateIndex++;
      frames = 0;
      fade   = 0;
      break;
    default:
      break;
  }
}
