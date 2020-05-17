/*
  AnalogReadSerial

  Reads an analog input on pin 0, prints the result to the Serial Monitor.
  Graphical representation is available using Serial Plotter (Tools > Serial Plotter menu).
  Attach the center pin of a potentiometer to pin A0, and the outside pins to +5V and ground.

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/AnalogReadSerial
*/
volatile int counts = 0;
//SERIAL_8N2
// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600,SERIAL_8N2);
  attachInterrupt(digitalPinToInterrupt(2), countHandler, RISING);
}

// the loop routine runs over and over again forever:
void loop() {
  // print out the value you read:
  analogWrite(11,100);// delay in between reads for stability
  Serial.println(counts);
  counts = 0;
  delay(1000);
}

void countHandler(){
  counts++;
  
}
