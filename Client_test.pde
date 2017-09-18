  
import processing.net.*;

Client myClient;
int dataIn;

void setup() {
  size(200, 200);
  myClient = new Client(this, "164.104.40.117", 12345);
}

void draw() { }  // Empty draw keeps the program running

// ClientEvent message is generated when the server 
// sends data to an existing client.
void clientEvent(Client myClient) {
  print("Server Says:  ");
  dataIn = myClient.read();
  println(dataIn);
  background(dataIn);

}