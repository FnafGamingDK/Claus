import processing.net.*;

final String IP = "10.130.153.119";
final int PORT = 10000;

TextBox nameBox;
Button joinButton;

Client client;
int dataIn;
int state = 1;
int punktum;
int x;
String Punktum;

void setup() {
  fullScreen();
  client = new Client(this, IP, PORT);
  nameBox = new TextBox(width / 2 - width / 6, height / 2-100, width / 3, height / 12);
  joinButton = new Button(width / 2 - width / 10, round(height / 1.5-150), width / 5, height / 12, "Join!");
}

void draw() {
  dataIn = client.read();
  background(#3399ff);
  if (state == 2) punktum++;
  if (state == 1) {
    fill(255);
    rect(width/2-400, height/2-175, 800, 350);
    textSize(45);
    nameBox.draw();
    joinButton.draw();
  } else if (state == 2) {
    fill(255);
    text("Waiting for host to start" + Punktum, width/2, height/2);
    if (dataIn == 1) state = 3;
  } else if (state == 3) {
    fill(255);
    stroke(0);
    strokeWeight(5);
    rect(width/4 - width/8, height/2-height/2.75, width-width*0.263, height);
    rect(-40, 25, width+50, 100);
    rect(width-width/7.5, height/2-height/2.75, width, height);
  }
  if (state == 2 && punktum == 0) Punktum = "";
  if (state == 2 && punktum == 35) Punktum = ".";
  if (state == 2 && punktum == 70) Punktum = "..";
  if (state == 2 && punktum == 105) Punktum = "...";
  if (state == 2 && punktum == 110) punktum = 0;
}

void keyPressed() {
  if (key == '+') state++;
  if (state == 1) {
    nameBox.getUserInput();
    updateName();
  }
}

void mouseClicked() {
  if (state == 1) {
    if (joinButton.hovering()) {
      joinButton.joined = state = 2;
      updateName();
    }
  }
}
