const int trigger = 11;
const int echo = 12;

long time_taken;
int dist;
 
void setup() {

  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(trigger, OUTPUT);
  pinMode(echo, INPUT);
}


void calculate_distance(int trigger, int echo) // can be any trigger & echo
{
  digitalWrite(trigger, LOW);
  delayMicroseconds(2);
  digitalWrite(trigger, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigger, LOW);

  time_taken = pulseIn(echo, HIGH); //echo is input (of sensors) so pulseIn reads the pulse of the distance recorded by the sensors
  dist = time_taken * 0.034 / 2; //sets the pulse taken to dist
  if (dist > 150)
    dist = 150; // basically makes 60 the maximum distance/pulse
}


void loop() {
  // put your main code here, to run repeatedly:
  calculate_distance(trigger, echo);


  if ( dist < 70)
  {
    Serial.println("Going Right");
    delay(500);
  }
  else if ( dist < 90)
  {
    Serial.println("Neutral");
    delay(500);
  }
  else 
  {
    Serial.println("Going Left");
    delay(500);
  }
}
