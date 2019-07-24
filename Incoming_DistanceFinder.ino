int trigger = 9;
int echo = 10;

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
  if (dist > 200)
    dist = 200; // basically makes 60 the maximum distance/pulse
}


void loop() {
  // put your main code here, to run repeatedly:
  calculate_distance(trigger, echo);


   if (dist <= 90)
  {
    Serial.print(dist);
    Serial.println(" : -1"); //You're going right
    delay(750);
  }
  else if (dist <= 120)
  {
    Serial.print(dist);
    Serial.println(" : 0"); //You'r in a neutral position
    delay(750);
  }
  else 
  {
    Serial.print(dist);
    Serial.println(" : 1"); //You're going left 
    delay(750);
  }
}
