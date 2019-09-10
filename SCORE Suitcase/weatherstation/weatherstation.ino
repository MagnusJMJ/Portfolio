// Weather Station, final(?) iteration

//Libraries
#include <DHT.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BMP085_U.h>
#include <Wire.h>
#include "RTClib.h"
#include <graphicsLCD.h>

//Constants
#define DHTPIN 12         // what pin we're connected to
#define DHTTYPE DHT22     // DHT 22  (AM2302)
DHT dht(DHTPIN, DHTTYPE); // Initialize DHT sensor for normal 16mhz Arduino

#define lcd_RST_pin 8 // LCD HX1230 pins, (no pin6) Change to your desire pins
#define lcd_CS_pin 7
#define lcd_DIN_pin 5
#define lcd_CLK_pin 4

Adafruit_BMP085_Unified bmp = Adafruit_BMP085_Unified(10085);

graphicsLCD lcd(lcd_RST_pin,lcd_CS_pin,lcd_DIN_pin,lcd_CLK_pin);
RTC_DS1307 RTC;

//Variables
int chk;
float hum;  //Stores humidity value
float temp; //Stores temperature value

int fsrPin = 0;     // the FSR and 10K pulldown are connected to a0
int fsrReading;     // the analog reading from the FSR resistor divider

void setup() {
  
  Serial.begin(9600);
  Wire.begin();
  RTC.begin();
  dht.begin();
  lcd.begin();
  lcd.displayInverse();
  lcd.clear();
  
  if(!bmp.begin()) {
    /* There was a problem detecting the BMP085 ... check your connections */
    lcd.print("Ooops, no BMP085 detected ... Check your wiring or I2C ADDR!");
    while(1);
  }
  pinMode(13, OUTPUT);
  
}

void loop() {
  
  delay(4000);
  lcd.clear();
  
  hum = dht.readHumidity();
  temp= dht.readTemperature();

  lcd.line(0);
  lcd.print("Weather");
  
  lcd.line(2);
  lcd.print("Hum:  ");
  lcd.print(hum);
  lcd.print("%");

  lcd.line(3);
  lcd.print("Temp: ");
  lcd.print(temp);
  lcd.print("C");
  
  /* Get a new sensor event */ 
  sensors_event_t event;
  bmp.getEvent(&event);
 
  /* Display the results (barometric pressure is measured in hPa) */
  if (event.pressure) {

    lcd.line(4);
    lcd.print("Bar:  ");
    lcd.print(event.pressure);
    lcd.print("hPa");
    
  } else {
    
    lcd.print("Sensor error");
    
  }

  fsrReading = analogRead(fsrPin);

  if (fsrReading > 200) {
    digitalWrite(13, HIGH);
  } else {
    digitalWrite(13, LOW);
  }
  
  lcd.line(5);
  lcd.print("Clogging: ");
  lcd.print(fsrReading);
    
}
