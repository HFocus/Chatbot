class State
{
  
  State (){}

  void IP(String s) {
    if (s == "draw") {
      textSize(15);
      text("Input Ip For Connection", 15, -15+(height-30));
    } else if (s == "confirm") {
      ConnectIp = txt;
      state = "cPort";
      txt = "";
    }
  }

  void cPort(String st) {
    if (st == "draw") {
      textSize(15);
      text("Input your port for other to connect", 15, -15+(height-30));
    } else if (st == "confirm") {
      cPort = int(txt);
      state = "sPort";
      txt = "";
    }
  }

  void sPort(String st) {
    if (st == "draw") {
      textSize(15);
      text("Input other's port for you to connect", 15, -15+(height-30));
    } else if (st == "confirm") {
      sPort = int(txt);
      state = "username";
      txt = "";
    }
  }

  void username(String st) {
    if (st == "draw") {
      textSize(15);
      text("Input Username", 15, -15+(height-30));
    } else if (st == "confirm") {
      username = txt;
      Msg.append(hour() + ":" + minute() + " " + day() + "/" + month() + "/" + year());
      Msg.append("SERVER: " + username + " has entered the chat");
      s.write("SERVER: " + username + " has entered the chat");
      Msg.append("");
      state = "chat";
      txt = "";
    }
  }

  void chat(String st) {
    if (st == "draw") {

      textSize(12);
      for (int i = Msg.size()-1; i > -1; i--) {
        text(Msg.get(i), 15, (Msg.size()-i)*-15+(height+125)-(Pos));
      }
    } else if (st == "confirm") {
      if (txt.length() != 0 && txt.charAt(0) != '/') {
        //Msg.append(time); //Adds Timestamp to Msg()
        Msg.append(username + ": " + txt); //adds txt to Msg
        s.write(username + ":" + txt);
        Msg.append(""); //Makes a space between Messages
        txt = ""; //Clears txt
      } else {
        cmd.Order(txt);
        txt = ""; //Clears txt
      }
    }
  }
}