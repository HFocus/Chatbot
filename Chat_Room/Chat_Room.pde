//networking
import processing.net.*;
Server S;
Client C;
String dataIn;
String[] ip;

//Prerun Constants
int cPort = 1234;                     //Their sPort
int sPort = 5678;                     //Their cPort
String connectIp = "";  //Type connect ip here

//objects
VScrollbar vs1;
Commands cmd;
State st;

//strings
String input;
StringList Msg = new StringList(); //Contains all Messages
String txt= "";                    //Contains Input for a Message
String username;                   //Contains Username for User
String time;                       //Containts current timestamp
String state = "IP";                      //State of program

//Ints
int maxFrameRate = 30;
int data[];

//Bools
boolean jeff = false; //It's name is jeff
boolean user = false; //For checking to see if username had been input
boolean cConnect = false;


//colors
color TC = color(153, 138, 255);//text color
color BC = color(29, 34, 42);//background color
color SBC = color(160, 160, 170);//ScrollBackground
//float
float Pos;
float txtSize = 15;
float sscale;                      //scale of the slider


void setup() {
  //Initialization
  size(750, 600); //size of default image
  //load IP's
  ip = loadStrings("http://" + "icanhazip.com/");
  //Load objects
  vs1 = new VScrollbar(width-10, 0, 20, height, 3*5+1);
  cmd = new Commands();
  st = new State();
  
  username = "Guest"; 
  frameRate(maxFrameRate); //Making frame rate Max frame rate
  
  //Startup
  Msg.append("Start of Chat");
  Msg.append("");
}

void draw() {

  //Update Variables
  sscale = (txtSize*Msg.size())+35+txtSize;
  time = hour() + ":" + minute() + ":" + second() + " " + day() + "/" + month() + "/" + year(); //Get Time
  Pos = vs1.getPos()-height*(sscale/height)+150; //Get Position of Scrollbar
  background(BC); // Make background Background Colour

  //makes the username input if you are connected
  if (state == "IP") {
    st.IP("draw");
  } else if (state == "cPort") {
    st.cPort("draw");
  } else if (state == "sPort") {
    st.sPort("draw");
  } else if (state == "username") {
    st.username("draw");
  } else if (state == "chat") {
    st.chat("draw");
  }


  //Create Textbox
  fill(BC);
  strokeWeight(2);
  stroke(TC);
  rect(0, (height-30), (width-1), 29);

  //Create Blinking Cursor and Draw the Input in the textbox
  fill(TC);
  if ((frameCount % maxFrameRate) == 0) { //If the amount of frames displayed is a multible of the Maxframerate (Every Second), show cursor
    jeff = true;
  } else if ((frameCount % (maxFrameRate/2)) == 0) { //Same thing but Every Second + 1/2 Second
    jeff = false;
  }
  if (jeff) {
    text((txt+"|"), 20, height-10);
  } else {
    text((txt), 20, height-10);
  }

  //Update Scrollbar
  vs1.update();
  vs1.display();
}

void keyPressed() {
  if (keyCode == ENTER && txt != "") { //If Message is sent

    if (state == "IP") {
      st.IP("confirm");
    } else if (state == "cPort") {
      st.cPort("confirm");
    } else if (state == "sPort") {
      st.sPort("confirm");
    } else if (state == "username") {
      st.username("confirm");
    } else if (state == "chat") {
      st.chat("confirm");
    }
  } else if (keyCode == BACKSPACE && txt.length() > 0) {
    txt = txt.substring(0, txt.length()-1);
  } else if ((key >= ' ' && key <= '~')) {
    txt += key;
  }
}

void clientOpen(){
  C = new Client(this, connectIp, cPort);
}

void serverOpen(){
  S = new Server(this, sPort);
}