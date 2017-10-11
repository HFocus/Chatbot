class State
{


  State () {
  }

  void IP(String s) {
    if (s == "draw") {
      fill(TC);
      textSize(15);
      text("Input Ip For Connection", 15, -15+(height-30));
    } else if (s == "confirm") {
      connectIp = txt;
      state = "cPort";
      txt = "";
    }
  }

  void cPort(String s) {
    if (s == "draw") {
      fill(TC);
      textSize(15);
      text("Input your port for other to connect", 15, -15+(height-30));
    } else if (s == "confirm") {
      cPort = int(txt);
      state = "sPort";
      txt = "";
    }
  }

  void sPort(String s) {
    if (s == "draw") {
      fill(TC);
      textSize(15);
      text("Input other's port for you to connect", 15, -15+(height-30));
    } else if (s == "confirm") {
      sPort = int(txt);
      state = "username";
      txt = "";
     
    }
  }

  void username(String s) {
    if (s == "draw") {
      fill(TC);
      textSize(15);
      text("Input Username", 15, -15+(height-30));

      int ava = C.available();
      if (ava > 0) { 
        dataIn = C.readString();
        Msg.append(dataIn);
        Msg.append("");
      }
    } else if (s == "confirm") {
      username = txt;
      Msg.append(hour() + ":" + minute() + " " + day() + "/" + month() + "/" + year());
      Msg.append("SERVER: " + username + " has entered the chat");
      S.write("SERVER: " + username + " has entered the chat");
      Msg.append("");
      state = "chat";
      txt = "";
    }
  }

  void chat(String s) {
    if (s == "draw") {
      fill(TC);
      textSize(12);
      
      for (int i = Msg.size()-1; i > -1; i--) {
        text(Msg.get(i), 15, (Msg.size()-i)*-15+(height+125)-(Pos));
      }
      
      int ava = C.available();
      if (ava > 0) { 
        dataIn = C.readString();
        Msg.append(dataIn);
        Msg.append("");
      }
      
    } else if (s == "confirm") {
      if (txt.length() != 0 && txt.charAt(0) != '/') {
        //Msg.append(time); //Adds Timestamp to Msg()
        Msg.append(username + ": " + txt); //adds txt to Msg
        S.write(username + ":" + txt);
        Msg.append(""); //Makes a space between Messages
        txt = ""; //Clears txt
      } else {
        cmd.Order(txt);
        txt = ""; //Clears txt
      }
    }
  }
}