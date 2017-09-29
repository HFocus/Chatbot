class Commands
{

  Commands () {
  }

  void Order(String orderIn) {
    if (orderIn == "/leave" || orderIn == "/Leave") {
      Leave();
    }
  }

  void Leave() {
    c.stop();
  }
}