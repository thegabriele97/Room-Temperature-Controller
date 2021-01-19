void setup() {
  // put your setup code here, to run once:
  pinMode(5, OUTPUT);
  analogWrite(5, 0);

  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:

  static uint8_t i = 0;
  static bool down = false;
  
  analogWrite(5, i);

  Serial.println(i, HEX);

  if (i == 0xff) {
    down = true;
    delay(10000);
    Serial.println("HEY");
  } else if (i == 0) {
    down = false;
    delay(10000);
  }

  i = down ? (i - 1) : (i + 1);
  delay(100);
}
