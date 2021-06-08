#include <Servo.h>
#include <ESP8266WiFi.h>
#include <WebSocketsServer.h>
#include <String>

WiFiServer server(80);
Servo servo;

const char* ssid = "XD 2.4"; // Your SSID
const char* password = "516489723"; //Your password

IPAddress local_IP(192, 168, 0, 46); // Set your Gateway IP address
IPAddress gateway(192, 168, 0, 1); // Set your IP address
IPAddress subnet(255, 255, 255, 0); // Set your network mask
IPAddress primaryDNS(8, 8, 8, 8);   //optional
IPAddress secondaryDNS(8, 8, 4, 4); //optional

int inPin = 12; // D6
int outPin = 14; // D5
int val = 0;   
char pass = 'o';
char clo = 'c';
int authorization_required = 1;

WebSocketsServer webSocket = WebSocketsServer(81); //websocket init with port 81

void webSocketEvent(uint8_t num, WStype_t type, uint8_t * payload, size_t length) {
//webscket event method
    String cmd = "";
    switch(type) {
        case WStype_DISCONNECTED:
            Serial.println("Websocket is disconnected");
            //case when Websocket is disconnected
            break;
        case WStype_CONNECTED:{
            //wcase when websocket is connected
            Serial.println("Websocket is connected");
            Serial.println(webSocket.remoteIP(num).toString());
            webSocket.sendTXT(num, "connected");}
            break;
        case WStype_TEXT:
            cmd = "";
            Serial.println(cmd);
            for(int i = 0; i < length; i++) {
                cmd = cmd + (char) payload[i]; 
            } //merging payload to single string
            
            if(cmd == "open"){
               servo.write(0);
            }else if(cmd == "close"){
              servo.write(90);
              digitalWrite(outPin, HIGH);
              delay(1000);
              digitalWrite(outPin, LOW);
              val = 0;
              delay(1000);
            }
             webSocket.sendTXT(num, cmd+":success");
             //send response to mobile, if command is "poweron" then response will be "poweron:success"
             //this response can be used to track down the success of command in mobile app.
            break;
        case WStype_FRAGMENT_TEXT_START:
            break;
        case WStype_FRAGMENT_BIN_START:
            break;
        case WStype_BIN:
            hexdump(payload, length);
            break;
        default:
            break;
    }
}


void setup() {
  pinMode(inPin, INPUT);
  pinMode(outPin, OUTPUT);
  servo.attach(4);
  servo.write(70);
  Serial.begin(115200);
  Serial.println("Connecting to wifi");
   
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
   webSocket.begin(); //websocket Begin
   webSocket.onEvent(webSocketEvent); //set Event for websocket
   Serial.println("Websocket is started");
  server.begin();
  digitalWrite(outPin, LOW);
}

void loop() {
  
  if(val){
    webSocket.loop();
  }
}
