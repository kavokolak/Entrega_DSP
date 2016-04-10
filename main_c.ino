#define pinOUT 12

int timer1_counter;

// the setup routine runs once when you press reset:
void setup() {                
  // initialize the digital pin as an output.
  pinMode(pinOUT,  OUTPUT);
  Serial.begin(57600);

  // initialize timer1 
  noInterrupts();           // disable all interrupts
  TCCR1A = 0;
  TCCR1B = 0;

  // Set timer1_counter to the correct value for our interrupt interval
  timer1_counter = 65224;   // preload timer 65536-16MHz/256/200Hz
  //timer1_counter = 34286;   // preload timer 65536-16MHz/256/2Hz

  TCNT1 = timer1_counter;   // preload timer
  TCCR1B |= (1 << CS12);    // 256 prescaler 
  TIMSK1 |= (1 << TOIE1);   // enable timer overflow interrupt
  
  interrupts();             // enable all interrupts
}

ISR(TIMER1_OVF_vect)        // interrupt service routine 
{
  TCNT1 = timer1_counter;   // preload timer
  //digitalWrite(pinOUT, digitalRead(pinOUT) ^ 1);
  int i = analogRead(A0);
  Serial.print(i);
  Serial.print(";");
  
}
   

// the loop routine runs over and over again forever:
void loop() {
  //int i = analogRead(A0);
 // Serial.print(i);
}
