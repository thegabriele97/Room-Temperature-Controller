#include <SoftwareSerial.h>
#include <stdint.h>

#define BITPIN(byte, pos) (byte & (1 << pos) ? HIGH : LOW) 

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  //pinMode(12, INPUT);  //Comparator Input

  pinMode(12, OUTPUT); //Comparator output

  pinMode(2, OUTPUT); //Reg0
  pinMode(3, OUTPUT); //Reg1
  pinMode(4, OUTPUT); //Reg2
  pinMode(5, OUTPUT); //Reg3
  pinMode(6, OUTPUT); //Reg4
  pinMode(7, OUTPUT); //Reg3
  pinMode(8, OUTPUT); //Reg4
  
  //pinMode(13, INPUT):  //SOC
}

void loop() {

  /*uint8_t val = 0x1f;

  digitalWrite(2, BITPIN(val, 4));
  digitalWrite(3, BITPIN(val, 4));
  digitalWrite(4, BITPIN(val, 4));
  digitalWrite(5, BITPIN(val, 4));
  digitalWrite(6, BITPIN(val, 4));
  delay(500);*/

  /*uint8_t val, i;
  for (i = 0; i < 128; i += 2) {
    val = i;
    
    digitalWrite(2, BITPIN(val, 6));
    digitalWrite(3, BITPIN(val, 5));
    digitalWrite(4, BITPIN(val, 4));
    digitalWrite(5, BITPIN(val, 3));
    digitalWrite(6, BITPIN(val, 2));
    digitalWrite(7, BITPIN(val, 1));
    digitalWrite(8, BITPIN(val, 0));
    delay(100);
  }*/

  /*digitalWrite(2, HIGH);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  digitalWrite(8, LOW);
  delay(500);

  digitalWrite(2, LOW);
  digitalWrite(3, HIGH);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  digitalWrite(8, LOW);
  delay(500);

  digitalWrite(2, LOW);
  digitalWrite(3, LOW);
  digitalWrite(4, HIGH);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  digitalWrite(8, LOW);
  delay(500);
  
  digitalWrite(2, LOW);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, HIGH);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  digitalWrite(8, LOW);
  delay(500);

  digitalWrite(2, LOW);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
  digitalWrite(6, HIGH);
  digitalWrite(7, LOW);
  digitalWrite(8, LOW);
  delay(500);

  digitalWrite(2, LOW);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, HIGH);
  digitalWrite(8, LOW);
  delay(500);

  digitalWrite(2, LOW);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
  digitalWrite(6, LOW);
  digitalWrite(7, LOW);
  digitalWrite(8, HIGH);
  delay(500);*/
  
  //Serial.println(analogRead(A5));

  uint8_t conv;
  int comp_in;
  int minus, plus;

  conv = 0;
  for (int i = 6; i >= 0; i--) {
    conv |= (1 << i);

    //Serial.print("(" + String(conv) + ") -> ");

    digitalWrite(2, BITPIN(conv, 6));
    digitalWrite(3, BITPIN(conv, 5));
    digitalWrite(4, BITPIN(conv, 4));
    digitalWrite(5, BITPIN(conv, 3));
    digitalWrite(6, BITPIN(conv, 2));
    digitalWrite(7, BITPIN(conv, 1));
    digitalWrite(8, BITPIN(conv, 0));
    delay(100);

    minus = analogRead(A7);
    plus = analogRead(A6);
    comp_in = plus > minus ? 1 : 0;

    //Serial.println(plus);

    //comp_in = digitalRead(12);
    conv &= ~(1 << i);
    conv |= (comp_in << i);

    //Serial.println(conv, BIN);
    
  }
  Serial.println(conv * 400.0 / 128.0 / 10.0);
  /*Serial.print(plus, BIN);
  Serial.print(" - ");
  Serial.println(conv, BIN);
  *///delay(1000);

  /*int minus, plus;

  minus = analogRead(A3);
  plus = analogRead(A1) << 3;

  Serial.print(minus);
  Serial.print(" - ");
  Serial.println(plus);

  digitalWrite(12, (plus > minus) ? HIGH : LOW);*/

  Serial.print("Temp: ");
  Serial.println(analogRead(A1) / (1.0 * analogRead(A0)));
  delay(1000);
}
