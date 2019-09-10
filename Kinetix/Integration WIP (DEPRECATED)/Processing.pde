
// *****************
// *** LIBRARIES ***
// *****************

import de.voidplus.leapmotion.*;
import oscP5.*;
import netP5.*;
import processing.serial.*;

// GUI shit
import processing.sound.*;
PFont openSans;
PImage goodImg;
PImage badImg;
PImage hand;
PImage chevron;
SoundFile goodSound;
SoundFile badSound;
int fade = 0;
int stateIndex; // NB: index variable for the GUI
int frames = 0;
int currentClass;

// Objects
OscP5 oscP5;
NetAddress dest;
OscP5 oscP5Receiver;
LeapMotion leap;

Serial myPort;  // Create object from Serial class
String val="";     // Data received from the serial port
String currentClass = "42";

// *************
// *** SETUP ***
// *************

void setup() {
  // size(800, 500);      NB: deprecated momentarily
  // background(255);

  // GUI shit
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
  goodSound = new SoundFile(this, "ok.wav");
  badSound = new SoundFile(this, "no.wav");

  //Communication
  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 115200);

  leap = new LeapMotion(this);

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 9000);
  dest = new NetAddress("127.0.0.1", 6448);
  oscP5Receiver = new OscP5(this, 12000);
}


// *****************
// *** CALLBACKS ***
// *****************

void leapOnInit() {
  // println("Leap Motion Init");
}
void leapOnConnect() {
  // println("Leap Motion Connect");
}
void leapOnFrame() {
  // println("Leap Motion Frame");
}
void leapOnDisconnect() {
  // println("Leap Motion Disconnect");
}
void leapOnExit() {
  // println("Leap Motion Exit");
}

// ******************
// *** GUI STATES ***
// ******************

void initState() {
  tint(255, fade);
  image(hand, 0, cos(frames)*15);
  fill(255, fade);
  textAlign(CENTER);
  textSize(64);
  text("Betal med Kinetix™", 0, -340);
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

void endState(boolean succ) {
  textAlign(CENTER);
  tint(255, fade);
  noStroke();
  if (succ) {
    text("Tak fordi du brugte Kinetix", 0, -100);
    image(goodImg, 0, 100, 250, 250);
  } else {
    text("Fejl", 0, -100);
    image(badImg, 0, 100, 250, 250);
  }
}

// ************
// *** DRAW ***
// ************

void draw() {

  // GUI shit
  translate(width/2, height/2);
  background(92, 147, 237);
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
      endState(true);
      break;
    default:
      break;
  }

  //Communication
  if (myPort.available() > 0) {  // If data is available,
    val = myPort.readStringUntil('\n'); // read it and store it in val
    // println(val);
  }

  if (val!= null) {

    val = val.trim();

    if(val.equals("1")) {

      // LeapMotion shit
      switch(currentClass) {
      case 1:
        println("Alpha");  // Does not execute
        background(255, 0, 0);
        break;
      case 2:
        println("Bravo");  // Prints "Bravo"
        background(0, 255, 0);
        break;
      case 3:
        println("Foxtrot");  // Prints "Foxtrot"
        background(0, 0, 255);
        break;
      case 4:
        println("Foxtrot");  // Prints "Foxtrot"
        background(255, 255, 0);
        break;
      case 5:
        println("Foxtrot");  // Prints "Foxtrot"
        background(0, 255, 255);
        break;
      case 6:
        println("Foxtrot");  // Prints "Foxtrot"
        background(255, 255, 255);
        break;
      case 7:
        println("Alpha");  // Prints "Alpha"
        background(120, 255, 120);
        break;
      case 8:
        println("Bravo");  // Prints "Bravo"
        background(255, 120, 255);
        break;
      case 9:
        println("Foxtrot");  // Prints "Foxtrot"
        background(20, 60, 120);
        break;
      case 10:
        println("Foxtrot");  // Prints "Foxtrot"
        background(120, 60, 20);
        break;
      case 11:
        println("Foxtrot");  // Prints "Foxtrot"
        background(55, 200, 10);
        break;
      case 12:
        println("Foxtrot");  // Prints "Foxtrot"
        background(185, 25, 195);
        break;

      default:
        println("Zulu");   //  Prints "Zulu"
        background(92, 147, 237);
        break;
      }
    }

    if (val!= null) {
      val = val.trim();
      if(val.equals("2")) {
        println("not right"); //print it out in the console
      }
    }
  }

  int fps = leap.getFrameRate();
  for (Hand hand : leap.getHands()) {

    PVector handPosition = hand.getPosition();

    if (hand.isRight()) {
      ArrayList<PVector> allJoints = getJoints(hand);
      sendJoints(allJoints, handPosition);
    }
  }
}

// ***************
// *** THINGS? ***
// ***************
void sendJoints(ArrayList<PVector> joints, PVector point) {
  OscMessage msg = new OscMessage("/wek/inputs");

  for (PVector joint : joints) {
    //msg.add(dist(point.x, point.y, point.z, joint.x, joint.y, joint.z));
    msg.add(joint.x - point.x);
    msg.add(joint.y - point.y);
    msg.add(joint.z - point.z);
  }

  oscP5.send(msg, dest);
}

ArrayList<PVector> getJoints(Finger thisFinger) {
  ArrayList<PVector> joints = new ArrayList();

  joints.add(thisFinger.getPositionOfJointTip());
  joints.add(thisFinger.getPositionOfJointMcp());
  joints.add(thisFinger.getPositionOfJointPip());
  joints.add(thisFinger.getPositionOfJointDip());

  return joints;
}

ArrayList<PVector> getJoints(Hand thisHand) {
  ArrayList<PVector> joints = new ArrayList();

  for (Finger finger : thisHand.getFingers()) {
    for (PVector joint : getJoints(finger)) {
      joints.add(joint);
    }
  }

  return joints;
}

void oscEvent(OscMessage message) {
  if (message.checkAddrPattern("/wek/outputs") == true) {
    currentClass = (int) message.get(0).floatValue();
    println(currentClass);
  }
}

// FOR TESTING PURPOSES
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

// function that resets the variables 'frames' and 'fade'
// It will either decrement or increment the GUI state index,
// depending on the argument it's given.
void guiState(boolean forward) {
  if (forward) {stateIndex++;} else {stateIndex--;}
  frames = 0;
  fade   = 0;
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
