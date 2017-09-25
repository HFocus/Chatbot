//networking
import processing.net.*;
Server s;
Client c;
String dataIn;

//objects
VScrollbar vs1;

//strings
String input;
StringList Msg = new StringList(); //Contains all Messages
String txt= ""; //Contains Input for a Message
String username; //Contains Username for User
String time;

//Ints
int maxFrameRate = 30;
int data[];

//Bools
boolean jeff = false; //It's name is jeff
boolean user = false; //For checking to see if username had been input

//colors
color TC = color(153,138,255);//text color
color BC = color(29,34,42);//background color
color SBC = color(160, 160, 170);//ScrollBackground
//float
float Pos;



void setup() {
  //Initialization
  size(750, 600); //size of default image
  vs1 = new VScrollbar(width-10, 0, 20, height, 3*5+1);
  username = "Guest"; 
  frameRate(maxFrameRate); //Making frame rate Max frame rate
  //Starting Server connections
  s = new Server(this, 1234);
   try {
    c = new Client(this, "127.0.0.1", 5678);
  }
  catch( Exception e) {
    e.printStackTrace();
    println("failed to connect");
  }
  //Startup
  Msg.append("Start of Chat");
  Msg.append("");

  //making box resizeable
  /*if(frame != null){
   surface.setResizable(true); 
   }*/
}

void draw() {
  //checks for incomming data
  int ava = c.available();
  if (ava > 0) { 
    dataIn = c.readString();
    Msg.append(dataIn);
    Msg.append("");
  }

  //Update Variables
  time = hour() + ":" + minute() + ":" + second() + " " + day() + "/" + month() + "/" + year(); //Get Time
  Pos = vs1.getPos()-height+150; //Get Position of Scrollbar
  background(BC); // Make background Background Colour

  //Prints messages
  fill(TC);
  if (user == true) { //If the username field has been filled, print Input as Message
    textSize(12);
    for (int i = Msg.size()-1; i > -1; i--) {
      text(Msg.get(i), 15, (Msg.size()-i)*-15+(height+125)-(Pos));
    }
  } else { //Else make Input Username
    textSize(15);
    text("Input Username", 15, -15+(height-30));
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
  if (keyCode == ENTER && txt != "" && user == true) { //If Message is sent
    //Msg.append(time); //Adds Timestamp to Msg()
    Msg.append(username + ": " + txt); //adds txt to Msg
    s.write(username + ":" + txt);
    Msg.append(""); //Makes a space between Messages
    txt = ""; //Clears txt
  } else if (keyCode == ENTER && txt != "" && user == false) {
    //making if no username inputed username be inputed
    username = txt;
    user = true;
    txt = "";
    Msg.append(hour() + ":" + minute() + " " + day() + "/" + month() + "/" + year());
    Msg.append("SERVER: " + username + " has entered the chat");
    s.write("SERVER: " + username + " has entered the chat");
    //allowing backspace
  } else if (keyCode == BACKSPACE && txt.length() > 0) {
    txt = txt.substring(0, txt.length()-1);
  } else if ((key >= ' ' && key <= '~')) {
    txt += key;
  }
}
/////DEBUGGING
/*void mousePressed(){
 if(mousePressed){
 println(mouseX,":",mouseY); 
 }
 }*/