class Commands
{
  Commands(){}

  String orderIn;

  void Order(String orderIn_) {
    orderIn = orderIn_;
    trim(orderIn);
    orderIn.toLowerCase();


    int iOrderIn = orderIn.indexOf("leave");
    if (iOrderIn == 1) {
      Leave();
    }

    iOrderIn = orderIn.indexOf("ip");
    if (iOrderIn == 1) {
      myIp();
    }

    iOrderIn = orderIn.indexOf("oip");
    if (iOrderIn == 1) {
      otherIp();
    }
  }

  void Leave() {
    S.write("SERVER: " + username + " has left the chat");
    C.stop();
    C.stop();
    exit();
  }

  void myIp() {
    Msg.append("SERVER: Your Ip: " + ip[0]);
  }

  void otherIp() {
    Msg.append("SERVER: Their Ip:" + connectIp);
  }
}