class Commands
{

  String orderIn;

  Commands () {
  }

  void Order(String orderIn_) {
    orderIn = orderIn_;
    trim(orderIn);
    orderIn = orderIn.substring(1, orderIn.length());

    if (orderIn.charAt(0) == 'l' && orderIn.charAt(1) == 'e' && orderIn.charAt(2) == 'a' && orderIn.charAt(3) == 'v' && orderIn.charAt(4) == 'e') {
      Leave();
    }
  }

  void Leave() {
    s.write(username+" has left the chat");
    s.stop();
    c.stop();
    exit();
  }
}
