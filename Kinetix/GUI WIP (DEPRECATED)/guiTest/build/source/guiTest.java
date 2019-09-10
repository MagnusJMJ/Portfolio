import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class guiTest extends PApplet {

// integer variables
int frames = 0;
int fade   = 0;
int state  = -1;
int gestureIndex = 5;

// arrays
String[] gestures = {
  "Peace.png", "A okay.png", "Ball.png","FingerGun.png",
  "HungerGames.png", "Spock.png","Point.png", "Spreading.png",
  "Surfing.png","Thumb.png", "Rock and roll.png"
};
PImage[] gestureImg = new PImage[gestures.length];

// string variables
String header1 = "";
String header2 = "";

// asset initialization
PFont openSans;
PImage goodSign;
PImage badSign;
PImage hand;
PImage nfc;
PImage k;

public void setup() {
  
  frameRate(60);

  // asset loading
  openSans = createFont("Open Sans", 64, true);
  goodSign = loadImage("good.png");
  badSign  = loadImage("bad.png");
  hand     = loadImage("hand.png");
  nfc      = loadImage("nfc.png");
  k        = loadImage("k.png");

  textFont(openSans, 48);
  textAlign(CENTER);
  imageMode(CENTER);
}

public void draw() {

  // variables
  frames++;
  if (frames < 51) {fade += 5;}

  // canvas
  translate(width/2,height/2);
  background(92, 147, 237);

  // header
  fill(255, fade);
  textSize(64);
  text(header1, 0, -280);

  // sub-header
  fill(255, fade-50);
  textSize(48);
  text(header2, 0, -220);

  // image
  tint(255, fade);
  switch(state) {
    case 0:
      image(k, 0, 0, 300, 300);
      break;
    case 1:
      image(nfc, 0, 0, 300, 300);
      break;
    case 2:
      image(hand, 0, 0, 300, 300);
      break;
    case 3:
      gestureImg[gestureIndex] = loadImage(gestures[gestureIndex]);
      image(gestureImg[gestureIndex], 0, 0, 425, 425);
      image(goodSign, 0, 300, 150, 150);
      break;
    case 4:
      gestureImg[gestureIndex] = loadImage(gestures[gestureIndex]);
      image(gestureImg[gestureIndex], 0, 0, 425, 425);
      image(badSign, 0, 300, 150, 150);
      break;
    case 5:
      break;
    default:
      break;
  }
}

public void stateHandler(int arg) {

  frames = 0;
  fade   = 0;

  switch(arg) {
    case 0:
      header1 = "Velkommen";
      header2 = "Betal med Kinetix™";
      break;
    case 1:
      header1 = "" + 123.45f + "Kr."; // PRIS
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
      header2 = "Tast PIN-kode";
      break;
    default:
      // ?
  }
}

public void keyPressed() {
  if (keyCode == 37 && state >= 1) {stateHandler(--state);}
  if (keyCode == 39 && state <= 3) {stateHandler(++state);}
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "guiTest" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
