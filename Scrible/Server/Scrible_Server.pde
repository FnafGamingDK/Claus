import processing.net.*;
import java.util.Arrays;

Server server;

int state = 2;
int dataOut = 0;
boolean toggle = false;
//boolean LeftButton = false;

ArrayList<Player> players;
//ArrayList<ArrayList<PVector>> groups;
TextBox nameBox;
Button startButton;
Button restartButton;
Draw tegn;

void setup() {
  fullScreen();
  server = new Server(this, 10000);
  players = new  ArrayList<Player>();
  nameBox = new TextBox(width / 4 - width / 6, round(height / 1.8), width / 3, height / 12);
  startButton = new Button(width / 4 - width / 10, round(height / 1.5), width / 5, height / 12, "START!");
  restartButton = new Button(width / 2 - width / 10, height / 2 - height / 24, width / 5, height / 12, "RESTART");
  //groups = new ArrayList<ArrayList<PVector>>();
  Player host = new Player(null);
  host.joined = true;
  players.add(host);
}

void draw() {
  server.write(dataOut);
  background(#3399ff);
  if (state == 2  ) {
    fill(255);
    textSize(40);
    rect(width / 4 - width / 6 -20, round(height / 1.8) -100, 685, 350);
    fill(0);
    players.get(0).name = nameBox.text;
    line(width / 2, 0, width / 2, height);
    text(players.size() > 1 ? str(players.size()) + " players connected" : "1 player connected", width / 4, height / 2);
    startButton.draw();
    nameBox.draw();
    textAlign(LEFT);
    for (int i = 0; i < players.size(); i++) {
      final Player player = players.get(i);
      text(player.name, width / 1.8, height / 11 * (i + 1));
      text(player.joined ? "READY" : "...", width / 1.2, height / 11 * (i + 1));
    }
    textAlign(CENTER);
    Client player = server.available();
    if (player != null) {
      final byte[] rbytes = player.readBytes();
      for (int i = 1; i < players.size(); i++) {
        Player p = players.get(i);
        if (p.client.ip().equals(player.ip())) {
          if (int(rbytes[0]) == 1) {
            p.joined = boolean(rbytes[1]);
            p.name = new String(Arrays.copyOfRange(rbytes, 2, rbytes.length));

            if (p.name.length() > 20 & p.name != "Mangus Langkildehus") {
              p.name = p.name.substring(0, 20);
            }
            if (p.name.length() > 20 & p.name != "Svensker er ikke mennesker") {
              p.name = p.name.substring(0, 20);
            }
          }
          return;
        }
      }
      byte[] bytes = new byte[6];
      bytes[0] = byte(0);
      players.add(new Player(player));
    }
  } else if (state == 3) {
    fill(255);
    stroke(0);
    strokeWeight(5);
    rect(width/4 - width/8, height/2-height/2.75, width-width*0.263, height);
    rect(-40, 25, width+50, 100);
    rect(width-width/7.5, height/2-height/2.75, width, height);
    noFill();
    if (toggle == true) beginShape();
    if (toggle == false) endShape();
    /* if (LeftButton) {
     groups.get(groups.size() - 1).add(new PVector(mouseX, mouseY));
     }
     
     for (ArrayList<PVector> group : groups) {
     beginShape();
     for (PVector pos : group) {
     vertex(pos.x, pos.y);
     }
     }
     endShape();*/
  }
}

void keyPressed() {
  if (state == 2) {
    nameBox.getUserInput();
  }
}

void mouseClicked() {
  if (state == 2) {
    if (startButton.hovering()) {
      startButton.joined = state = 2;
      state = 3;
      dataOut = 1;
    }
  }
}


void mousePressed() {
  if (state == 3) {
    //LeftButton = true;
    //groups.add(new ArrayList<PVector>());
    
    toggle = true;
  }
}

void mouseReleased() {
  if (state == 3) {
    toggle = false;
    //LeftButton = false;
  }
}
