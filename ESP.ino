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
int key = 0;
char pass = 'o';
char clo = 'c';

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
}

void loop() {
  WiFiClient client = server.available();
  val = digitalRead(inPin);
  rs();
  //Serial.println(val);
  delay(1000);
  if(val){
    if(client){
      while(client.connected()){
        while(client.available() > 0){
          char c = client.read();
          if(c == pass){
            key = 1;
            servo.write(0);
          }else if(key == 1 and c == clo){
            servo.write(90);
            rs();
            client.stop();
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

void rs(){
  if (val == 0){
    digitalWrite(outPin, LOW);  
  }else{
    digitalWrite(outPin, HIGH);
  }
}
