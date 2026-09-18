#include <Wire.h>
#include <Adafruit_NeoPixel.h>

#define PIN 6
#define NUMPIXELS 9

Adafruit_NeoPixel pixels(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

byte board[9];

void setup() {
  Wire.begin(8); // UNOはI2Cスレーブ（アドレス8）
  Wire.onReceive(receiveEvent);

  pixels.begin();
  pixels.clear();
  pixels.show();
}

void loop() {
  // UNOは受信したら光らせるだけなので何もしない
}

void receiveEvent(int howMany) {
  int i = 0;
  while (Wire.available() && i < 9) {
    board[i] = Wire.read();
    i++;
  }
  showBoard();
}

void showBoard() {
  for (int i = 0; i < 9; i++) {
    if (board[i] == 0) {
      pixels.setPixelColor(i, pixels.Color(0, 0, 0)); // 空白＝消灯
    } else if (board[i] == 1) {
      pixels.setPixelColor(i, pixels.Color(0, 0, 255)); // ○＝青
    } else if (board[i] == 2) {
      pixels.setPixelColor(i, pixels.Color(255, 0, 0)); // ×＝赤
    }
  }
  pixels.show();
}
