// Sends 60 values 

import de.voidplus.leapmotion.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;
OscP5 oscP5Receiver;



LeapMotion leap;

int currentClass;

void setup() {
  size(800, 500);
  background(255);
  // ...

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
  if (currentClass == 0) {
    background(0, 255, 0);
  } else if (currentClass == 1) {
    background(255, 0, 0);
  } else if (currentClass == 2) {
    background(0, 0, 255);
  } else if (currentClass == 3) {
    background(0, 255, 255);
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