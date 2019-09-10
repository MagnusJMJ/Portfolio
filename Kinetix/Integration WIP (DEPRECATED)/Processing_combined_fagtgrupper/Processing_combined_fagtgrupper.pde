// Sends 60 values 

import de.voidplus.leapmotion.*;
import oscP5.*;
import netP5.*;
import processing.serial.*;

OscP5 oscP5;
NetAddress dest;
OscP5 oscP5Receiver;



LeapMotion leap;

int currentClass;

//Variables

Serial myPort;  // Create object from Serial class
String val="";     // Data received from the serial port


void setup() {
  size(800, 500);
  background(255);
  // ...

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

      switch(currentClass) {
      case 1:  
        println("Rock n' Roll");  // Prints Rock n' Roll
        background(255, 0, 0);
        break;
      case 6: 
        println("A-okay");  // Prints A-okay
        background(255, 255, 255);
        break;
      case 7: 
        println("Thumb side");  // Prints thumb side
        background(120, 255, 120);
        break;
      }
    }
  }
  if (val!= null) {
    val = val.trim();
    if (val.equals("2"))  
    {

      switch(currentClass) {
      case 2: 
        println("Peace");  // Prints Peace
        background(0, 255, 0);
        break;
      case 4: 
        println("Pistol");  // Prints Pistol
        background(255, 255, 0);
        break;
      case 5: 
        println("Star Trek");  // Prints Star Trek
        background(0, 255, 255);
        break;
      }
    }
  }

  if (val!= null) {
    val = val.trim();
    if (val.equals("3"))  
    {

      switch(currentClass) {
      case 3: 
        println("Surf's up");  // Prints Surf's up
        background(0, 0, 255);
        break;
      case 8: 
        println("Point");  // Prints Point
        background(255, 120, 255);
        break;
      case 9: 
        println("Hunger games");  // Prints Hunger games
        background(20, 60, 120);
        break;
      default:
        println("Default");   // Does not execute
        background(0, 10, 0);
        break;
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
      println(currentClass);
    }
  }