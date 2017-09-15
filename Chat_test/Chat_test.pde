//networking
import processing.net.*;

VScrollbar vs1;
Server s;
Client c;
String input;
int data[];

//strings
//display and message creation
StringList Msg = new StringList(); //Contains all Messages
String txt= ""; //Contains Input for a Message
String username; //Contains Username for User
//Ints
int maxFrameRate = 30;
//Bools
boolean jeff = false; //It's name is jeff
boolean user = false; //For checking to see if username had been input
//colors
color TC = color(114, 72, 194);//text color
color BC = color(135, 135, 135);//background color
color SBC = color(160,160,170);//ScrollBackground

void setup(){
 Msg.append("Start of Chat");
 Msg.append("");
 username = "MARX";

 //Start of chat time stamp in PRINTLN
 print (hour() + ":" + minute() + ":" + second() + " " + day() + "/" + month() + "/" + year());
 
 /*
 String[] fontList = PFont.list();
 println(fontList); */
 
   //size of default image, 
 size(600, 450); 
   //making box resizeable
 if(frame != null){
    surface.setResizable(true); 
 }
 //Making frame rate Max frame rate
 frameRate(maxFrameRate);
 
 vs1 = new VScrollbar(width-10, 0, 20, height, 3*5+1);
}


void draw(){
  //Get Position of Scrollbar
  float Pos = vs1.getPos()-height+150;
  
  // Make background Background Colour
  background(BC);
  
  //Text
  fill(TC);
  //Prints messages
  if (user == true){
    textSize(12);
    for (int i = Msg.size()-1; i > -1; i--){
      text(Msg.get(i), 15, (Msg.size()-i)*-15+(height+125)-(Pos));
    }
    //makes username be input first
  } else {
    textSize(15);
    text("Input Username", 15, -15+(height-30));
  }
  
   //fill the box with the Background Color
  fill(BC);
  strokeWeight(2);
  //border of box as Text color
  stroke(TC);
  //box resizing
  rect(0, (height-30), (width-1), 29);
  
  //make the rest text colour
  fill(TC);
  // determines when to show |
  if ((frameCount % maxFrameRate) == 0){
    jeff = true;
  } else if ((frameCount % (maxFrameRate/2)) == 0){
    jeff = false;
  }
  //making it appear
  if(jeff){
    text((txt+"|"), 20, height-10);
  } else {
    text((txt), 20, height-10);
  }
  
  vs1.update();
  vs1.display();
}

void keyPressed(){
  //adds the typed 
  if(keyCode == ENTER && txt != "" && user == true){
  //Msg.append(hour() + ":" + minute() + " " + day() + "/" + month() + "/" + year());
    //adds username to text
    Msg.append(username + ": " + txt);
    //resets the text to nothing
    Msg.append("");
    txt = "";
  } else if (keyCode == ENTER && txt != "" && user == false) {
    //making if no username inputed username be inputed
    username = txt;
    user = true;
    txt = "";
    Msg.append(hour() + ":" + minute() + " " + day() + "/" + month() + "/" + year());
    Msg.append("SERVER: " + username + " has entered the chat");
    //allowing backspace
  } else if(keyCode == BACKSPACE && txt.length() > 0){
    txt = txt.substring(0,txt.length()-1);
  } else if ((key >= ' ' && key <= '~')){
    txt += key;
  }
}
/////NOT IMPORTANT
void mousePressed(){
 if(mousePressed){
  println(mouseX,":",mouseY); 
 }
}