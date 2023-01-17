import processing.net.Client;

class Player {
  Client client;
  String name = "";
  boolean joined = false;

  Player(Client client) {
    this.client = client;
  }
}
