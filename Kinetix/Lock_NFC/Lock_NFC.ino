    #include <SPI.h>
    #include "PN532_SPI.h"
    #include "PN532.h"
    #include "NfcAdapter.h"

    String const Tag1 = "07 8E 41 AF", Tag2 = "D2 29 E7 26", Tag3 = "D2 29 E7 26"; // replace this UID with your NFC tag's UID
    int const greenLedPin = 3; // green led used for correct key notification
    int const redLedPin = 4; // red led used for incorrect key notification

    PN532_SPI interface(SPI, 10); // create a SPI interface for the shield with the SPI CS terminal at digital pin 10
    NfcAdapter nfc = NfcAdapter(interface); // create an NFC adapter object

    void setup(void) {
        Serial.begin(115200); // start serial comm
        Serial.println("NDEF Reader");
        nfc.begin(); // begin NFC comm

    }

    void loop(void) {
        Serial.println("Scanning...");
        if (nfc.tagPresent()) // check if an NFC tag is present on the antenna area
        {
            NfcTag tag = nfc.read(); // read the NFC tag
            String scannedUID = tag.getUidString(); // get the NFC tag's UID

          if( Tag1.compareTo(scannedUID) == 0) // compare the NFC tag's UID with the correct tag's UID (a match exists when compareTo returns 0)
            {
              // The correct NFC tag was used
              Serial.println("Gesture 1 Key");
         } else if(Tag2.compareTo(scannedUID) == 0){
              // an incorrect NFC tag was used
              Serial.println("Gesture 2 key");
              
         } else if(Tag1.compareTo(scannedUID) == 0){
          Serial.println("Gesture 3 key");
          
        } else{
          Serial.println("Try agian Please");
        }
        delay(100);
    }
    }
