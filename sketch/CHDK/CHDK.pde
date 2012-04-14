/*
  Copyright 2009-2010 Manuel Rábade <manuel@rabade.net>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.
  
  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
  
  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#define CAM 13
#define LUZ 0
#define BTN 7
#define INC 50

int nivel = 0;
int estado = 0;
double adc = 0;

void setup() {
  Serial.begin(9600);
  pinMode(CAM, OUTPUT);
  pinMode(BTN, INPUT);
  digitalWrite(CAM, LOW);
  Serial.println("listo...");
}

void loop() {
  adc = analogRead(LUZ);
  if (digitalRead(BTN) == LOW) {
    estado = 1;
  }
  if (digitalRead(BTN) == HIGH && estado == 1) {
    Serial.print("nivel configurado (");
    Serial.print(adc);
    Serial.println(")");
    nivel = adc;
    estado = 2;
    delay(3000);
  }
  if (adc < (nivel - INC) && estado == 2) {
    Serial.print("dispara (");
    Serial.print(adc);
    Serial.println(")");
    disparo();
    delay(2000);
    estado = 3;
  }
  if (estado == 3 && adc > (nivel - INC)) {
    Serial.println("esperando...");
    delay(1000);
    estado = 2;
  }
}

void disparo () {
  digitalWrite(CAM, HIGH);
  delay(750);
  digitalWrite(CAM, LOW);
}

;
