#include <Servo.h>
#include <ESP8266WiFi.h>
#include <String>

WiFiServer server(80);
Servo servo;

const char* ssid = "XD 2.4"; // Your SSID
const char* password = "516489723"; //Your password
int inPin = 12; // D6
int outPin = 14; // D5
int val = 0;   
char pass = 'o';
char clo = 'c';
int authorization_required = 1;


IPAddress local_IP(192, 168, 0, 46); // Set your Gateway IP address
IPAddress gateway(192, 168, 0, 1); // Set your IP address
IPAddress subnet(255, 255, 255, 0); // Set your network mask
IPAddress primaryDNS(8, 8, 8, 8);   //optional
IPAddress secondaryDNS(8, 8, 4, 4); //optional

void setup() {
  pinMode(inPin, INPUT);
  pinMode(outPin, OUTPUT);
  servo.attach(4);
  servo.write(90); 
  Serial.begin(115200);
  if (!WiFi.config(local_IP, gateway, subnet, primaryDNS, secondaryDNS)) {
    Serial.println("STA Failed to configure");
  }
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected.");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
  server.begin();
  digitalWrite(outPin, LOW);
}

void loop() {
  WiFiClient client = server.available();
  val = digitalRead(inPin);
  //Serial.println(val);
  delay(2000);
  
  if(val){
    Serial.println("test");
    if(client){
      while(client.connected()){
        while(client.available() > 0){
          char c = client.read();
          if(c == '?') { // zapytanie o autorzycje
              client.write(authorization_required); // odpowiedz z wartością zminnej 1 lub 0 | 1 - potrzebna autoryzacja 0 - niepotrzebna
          }else if(c == 'y') { // autoryzacja się powiodła
              servo.write(0);
          }else if(c == 'n') { // autoryzacja się nie powiodła
              servo.write(90);
            digitalWrite(outPin, HIGH);
            delay(1000);
            digitalWrite(outPin, LOW);
            client.stop();
            val = 0;
            delay(1000);
          }
          Serial.write(c);
        }
        delay(10);
      }
      client.stop();
      Serial.println("Client disconnected");
    }
  }else{
    servo.write(90);  
  }
}