import java.util.Arrays;

void updateName() {
  final int reserved = 2; // 0: 1 means not a new player
  // 1: 1 means ready
  byte[] bytes = new byte[reserved + nameBox.text.length()];
  bytes[0] = byte(1);
  bytes[1] = byte(joinButton.joined);
  for (int i = 0; i < nameBox.text.length(); i++) {
    bytes[i + reserved] = byte(nameBox.text.charAt(i));
  }
  client.write(bytes);
}
