
#include <OnewireKeypad.h>
#include <LiquidCrystal_I2C.h>
#include <Wire.h>
#include <SPI.h>
#include <MFRC522.h>


char KEYS[] = {
  '1', '2', '3', 'A',
  '4', '5', '6', 'B',
  '7', '8', '9', 'C',
  '*', '0', '#', 'D'
};

#define SS_PIN 10
#define RST_PIN 9

char password[4] = {"5555"};
char check[4];
int card = 0;
int esp = 0;
int j = 0;
int outData = 8;
int inData = 7;
int val = 0;
LiquidCrystal_I2C lcd(0x27, 16, 2);
OnewireKeypad <Print, 16 > KP2(Serial, KEYS, 4, 4, A0, 4700, 1000);
MFRC522 mfrc522(SS_PIN, RST_PIN);

void setup () {
  Serial.begin(9600);
  KP2.SetKeypadVoltage(5);
  lcd.init();
  lcd.backlight();
  lcd.clear();
  lcd.setCursor(7, 0);
  lcd.print("3F");
  lcd.setCursor(6,1);
  lcd.print("LOCK");
  SPI.begin();
  mfrc522.PCD_Init();
  pinMode(outData, OUTPUT);
  pinMode(inData, INPUT);
  digitalWrite(outData, LOW);
}
void loop()
{
  char Key;
  byte KState = KP2.Key_State();

  if(esp == 1){
    digitalWrite(outData, HIGH);
    delay(2000);
    val = digitalRead(inData);
    Serial.print(val);
      if(val){
        card = 0;
        lcd.clear();
        lcd.setCursor(0,0);
        lcd.setCursor(7, 0);
        lcd.print("3F");
        lcd.setCursor(6,1);
        lcd.print("LOCK");
        digitalWrite(outData, LOW);
        j = 0;
        esp = 0;
      }
  }
  
  if (KState == PRESSED and card == 1 and esp == 0)
  {
    if ( Key = KP2.Getkey() )
    {
      check[j++] = Key;
      lcd.print("*");
      lcd.setCursor(j,0);
    }
    if(j==4){
      delay(1000);
      lcd.clear();
      lcd.setCursor(0,0);
      if(!(strncmp(check, password,4))){
        pass_c();
      }else{
        pass_i();
      }
    }
  }
  

  if( card == 0){
    if ( ! mfrc522.PICC_IsNewCardPresent()) 
    {
      return;
    }
    if ( ! mfrc522.PICC_ReadCardSerial()) 
    {
      return;
    }
    Serial.print("UID tag :");
    String content= "";
    byte letter;
    for (byte i = 0; i < mfrc522.uid.size; i++) 
    {
       Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
       Serial.print(mfrc522.uid.uidByte[i], HEX);
       content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " "));
       content.concat(String(mfrc522.uid.uidByte[i], HEX));
    }
    content.toUpperCase();
    if (content.substring(1) == "AA 89 09 BF") //change here the UID of the card/cards that you want to give access
    {
      authorized();
    }else{
      denied();
    }
  }
}


void authorized(){
  lcd.clear();
  lcd.print("Card correct");
  delay(1000);
  lcd.clear();
  lcd.print("Enter password");
  card = 1;
  delay(1000);
  lcd.clear();
}

void denied(){
  lcd.clear();
  lcd.print("Access denied");
  delay(1000);
  lcd.clear();
  lcd.print("Wrong card");
}
void pass_c(){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Password correct");
  delay(2000);
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Authorize via");
  lcd.setCursor(0,1);
  lcd.print("application");
  esp = 1;
  digitalWrite(outData, HIGH);
  delay(2000);
}

void pass_i(){
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Password wrong");
  delay(2000);
  lcd.clear();
  lcd.setCursor(0,0);
  lcd.print("Enter Password");
  lcd.setCursor(0,0);
  delay(1000);
  lcd.clear();
  j=0;
}
