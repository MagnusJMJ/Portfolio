   // Sends 60 values

import de.voidplus.leapmotion.*;
import oscP5.*;
import netP5.*;
import processing.serial.*;

//Variables GUI
int frames = 0;
int fade   = 0;
int state  = -1;
int stateprev = 0;
int gestureIndex = 5;
boolean runtest = false;
boolean veri = false;
boolean intro = true;
boolean intro1 = true;


String header1 = "";
String header2 = "";


//Variables Failstate

int time;
int timer;
int prevcurrentClass;
boolean timertrigger = false;

String[] gestures = {
  "peace_outline.png", "aokay_outline.png", "Ball.png", "fingergun_outline.png",
  "hungergames_outline.png", "spock_outline.png", "point_outline.png", "Spreading.png",
  "Surfing_outline.png", "thumb_outline.png", "rockandroll_outline.png"
};

PImage[] gestureImg = new PImage[gestures.length];

// asset initialization
PFont openSans;
PImage goodSign;
PImage badSign;
PImage hand;
PImage nfc;
PImage k;
PImage chevron;


OscP5 oscP5;
NetAddress dest;
OscP5 oscP5Receiver;



LeapMotion leap;

int currentClass;

//Variables

Serial myPort;  // Create object from Serial class
String val="";     // Data received from the serial port


void setup() {
fullScreen(2);
  // size(1920,1080);
 //  size(1280, 920);

  // asset loading
  openSans = createFont("Open Sans", 64, true);
  goodSign = loadImage("good.png");
  badSign  = loadImage("bad.png");
  chevron  = loadImage("chevron.png");
  hand     = loadImage("leap.png");
  nfc      = loadImage("nfc.png");
  k        = loadImage("k.png");

  textFont(openSans, 48);
  textAlign(CENTER, CENTER);
  imageMode(CENTER);

  //Communication

  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 115200);


  leap = new LeapMotion(this);

  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 9000);
  dest = new NetAddress("127.0.0.1", 6448);
  oscP5Receiver = new OscP5(this, 12000);
}


// ======================================================
// 1. Callbacks

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


void draw() {
  frames++;
  if (frames < 51) {
    fade += 5;
  }

  // println(timer);
  println(currentClass);


  if (keyPressed == true) {
    intro = false;
  }

  if (intro == false && intro1 == true) {
    stateHandler(1);
  } else if (intro == true && veri == false) {
    stateHandler(0);
  }



  // canvas
  translate(width/2, height/2);
  background(92, 147, 237);

  // header
  fill(255, fade);
  textSize(64);
  text(header1, 0, -200);
  text(header2, 0, 175);


  // sub-header
  fill(255, fade-50);
  textSize(85);
  text(header2, 0, -320);

  // image
  tint(255, fade);

  switch(state) {
  case 0:
    image(k, 0, 0, 250, 275);
    break;
  case 1:
    image(nfc, 0, 0, 450, 250);
    translate(-300, 0);
    rotate(radians(90));
    image(chevron, 0, 0, 100, 100);
    break;
  case 2:
    image(hand, 0, 0, 350, 275);
    translate(300, 0);
    rotate(radians(-90));
    image(chevron, 0, 0, 100, 100);
    break;
  case 3:
    gestureImg[gestureIndex] = loadImage(gestures[gestureIndex]);
    image(gestureImg[gestureIndex], 0, 0, 375, 375);
    image(goodSign, 0, 400, 200, 200);
    break;
  case 4:
    gestureImg[gestureIndex] = loadImage(gestures[gestureIndex]);
    image(gestureImg[gestureIndex], 0, 0, 375, 375);
    image(badSign, 0, 300, 100, 100);
    break;
  case 5:
    break;
  default:
    break;
  }



  //  println(val);
  println(timer);

  //Communication
  if ( myPort.available() > 0)
  {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
    // println(val);
  }


  if (val!= null) {
    val = val.trim();
    if (val.equals("1"))
    {
      //  timer ++;
      if (runtest == false) {
        stateHandler(2);
        runtest = true;
      }
      intro1 = false;



      if ( veri == false) {

        if ( currentClass > 0)
        {
          timer++;
        }
      }

      if ( veri == false) {
        if ( currentClass == prevcurrentClass && timer > 100)
        {
          switch(currentClass) {
          case 1:
            println("Rock n Roll");  // Prints Rock n' Roll
            //  background(255, 0, 0);
            gestureIndex = 11;
            stateHandler(4);
            veri = true;
            // delay(500);
            break;

          case 2:
            println("Peace");  // Prints Peace
            //    background(0, 255, 0);
            gestureIndex = 10;
            stateHandler(4);
            veri = true;
            break;

          case 3:
            println("Surf's up");  // Prints Surf's up
            //    background(0, 0, 255);
            gestureIndex = 8;
            stateHandler(3);
            veri = true;
            break;
          case 4:
            println("Pistol");  // Prints Pistol
            //    background(255, 255, 0);
            gestureIndex = 3;
            stateHandler(4);
            veri = true;
            break;
          case 5:
            println("Star Trek");  // Prints Star Trek
            //     background(0, 255, 255);
            gestureIndex = 5;
            stateHandler(4);
            veri = true;
            break;

          case 6:
            println("A okay");  // Prints A-okay
            //   background(255, 255, 255);
            gestureIndex = 1;
            stateHandler(3);
            veri = true;
            //   delay(500);
            break;
          case 7:
            println("Thumb side");  // Prints thumb side
            //     background(120, 255, 120);
            gestureIndex = 9;
            stateHandler(3);
            veri = true;
            break;
          case 8:
            println("Point");  // Prints Point
            //   background(255, 120, 255);
            gestureIndex = 6;
            stateHandler(4);
            veri = true;
            break;
          case 9:
            println("Hunger games");  // Prints Hunger games
            //  background(20, 60, 120);
            gestureIndex = 4;
            stateHandler(4);
            veri = true;
            break;
          }
        } else if (currentClass != prevcurrentClass)
        {
          println("ttt");
          prevcurrentClass= currentClass;
          timer = 0;
        }
      }
    }
  }


  println("prev is" + " " + prevcurrentClass + " " + "current is" + " " + currentClass);

  if (val!= null) {
    val = val.trim();
    if (val.equals("2"))
    {

      if (runtest == false) {
        stateHandler(2);
        runtest = true;
      }
      intro1 = false;


      if ( currentClass > 0)
      {
        timer++;
      }




      if ( veri == false) {
        if ( currentClass == prevcurrentClass && timer > 100)
        {
          switch(currentClass) {
          case 1:
            println("Rock n Roll");  // Prints Rock n' Roll
            gestureIndex = 10;
            stateHandler(4);
            veri = true;
            // delay(500);
            break;

          case 2:
            println("Peace");  // Prints Peace
            gestureIndex = 10;
            stateHandler(3);
            veri = true;
            break;

          case 3:
            println("Surf's up");  // Prints Surf's up
            gestureIndex = 8;
            stateHandler(4);
            veri = true;
            break;
          case 4:
            println("Pistol");  // Prints Pistol
            gestureIndex = 3;
            stateHandler(4);
            veri = true;
            break;
          case 5:
            println("Star Trek");  // Prints Star Trek
            gestureIndex = 5;
            stateHandler(4);
            veri = true;
            break;

          case 6:
            println("WRONG GESTURE");  // Prints A-okay
            gestureIndex = 1;
            stateHandler(4);
            veri = true;
            //   delay(500);
            break;
          case 7:
            println("Thumb side");  // Prints thumb side
            gestureIndex = 9;
            stateHandler(4);
            veri = true;
            break;
          case 8:
            println("Point");  // Prints Point
            gestureIndex = 6;
            stateHandler(3);
            veri = true;
            break;
          case 9:
            println("Hunger games");  // Prints Hunger games
            gestureIndex = 4;
            stateHandler(3);
            veri = true;
            break;
          }
        } else if (currentClass != prevcurrentClass)
        {
          println("ttt");
          prevcurrentClass= currentClass;
          timer = 0;
        }
      }
    }
  }


  if (val!= null) {
    val = val.trim();
    if (val.equals("3"))
    {
      //  timer ++;
      if (runtest == false) {
        stateHandler(2);
        runtest = true;
      }
      intro1 = false;



      //Debug starts failstate
      if ( veri == false) {

        if ( currentClass > 0)
        {
          timertrigger = true;
        }
      }


      if (timertrigger == true)
      {
        timer++;
      }



      if ( veri == false) {
        if ( currentClass == prevcurrentClass && timer > 100)
        {
          switch(currentClass) {
          case 1:
            println("Rock n Roll");  // Prints Rock n' Roll
            //  background(255, 0, 0);
            gestureIndex = 10;
            stateHandler(3);
            veri = true;
            // delay(500);
            break;

          case 2:
            println("Peace");  // Prints Peace
            //    background(0, 255, 0);
            gestureIndex = 0;
            stateHandler(4);
            veri = true;
            break;

          case 3:
            println("Surf's up");  // Prints Surf's up
            //    background(0, 0, 255);
            gestureIndex = 8;
            stateHandler(4);
            veri = true;
            break;
          case 4:
            println("Pistol");  // Prints Pistol
            //    background(255, 255, 0);
            gestureIndex = 3;
            stateHandler(3);
            veri = true;
            break;
          case 5:
            println("Star Trek");  // Prints Star Trek
            //     background(0, 255, 255);
            gestureIndex = 5;
            stateHandler(3);
            veri = true;
            break;

          case 6:
            println("WRONG GESTURE");  // Prints A-okay
            //   background(255, 255, 255);
            gestureIndex = 1;
            stateHandler(4);
            veri = true;
            //   delay(500);
            break;
          case 7:
            println("Thumb side");  // Prints thumb side
            //     background(120, 255, 120);
            gestureIndex = 9;
            stateHandler(4);
            veri = true;
            break;
          case 8:
            println("Point");  // Prints Point
            //   background(255, 120, 255);
            gestureIndex = 6;
            stateHandler(4);
            veri = true;
            break;
          case 9:
            println("Hunger games");  // Prints Hunger games
            //  background(20, 60, 120);
            gestureIndex = 4;
            stateHandler(4);
            veri = true;
            break;
          }
        } else if (currentClass != prevcurrentClass)
        {
          println("ttt");
          prevcurrentClass= currentClass;
          timer = 0;
        }
      }
    }
  }

  if (val!= null) {
    val = val.trim();
    if (val.equals("4"))
    {

      println("not right"); //print it out in the console
    }
  }


  int fps = leap.getFrameRate();
  for (Hand hand : leap.getHands()) {

    PVector handPosition       = hand.getPosition();

    if (hand.isRight()) {
      ArrayList<PVector> allJoints = getJoints(hand);
      sendJoints(allJoints, handPosition);
    }
  }

  if (state != stateprev) {
    fade = 0;
  }

  stateprev = state;
}


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
    // println(currentClass);
  }
}

void stateHandler(int arg) {
  state = arg;
  frames = 0;
  // fade   = 0;

  switch(arg) {
  case 0:
    header1 = "Velkommen";
    header2 = "Betal med Kinetix™";
    break;
  case 1:
    header1 = "" + 123.45 + "Kr."; // PRIS
    header2 = "Verificér med armbånd";
    break;
  case 2:
    header2 = "Verificér med fagt";
    break;
  case 3:
    header1 = "Succes!";
    header2 = "Betaling verificeret";
    break;
  case 4:
    header1 = "Fejl!";
    header2 = "Forkert fagt";
    break;
  default:
    // don't even trip dog
  }
}

void keyPressed() {
  if (keyCode == 37) {stateHandler(++state);}
  if (keyCode == 39) {stateHandler(--state);}
}
