int trigger = 9;
int echo = 10;
int pin = 8;

long time_taken;
long time_take;
int dist;
int newdist;
 
void setup() {

  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(trigger, OUTPUT);
  pinMode(echo, INPUT);
  pinMode (pin, OUTPUT);
}

/*
void cereal() {
  Serial.begin(9600);
} */


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

void calculate_newdistance(int trigger, int echo) {
  digitalWrite(trigger, LOW);
  delayMicroseconds (2);
  digitalWrite(trigger, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigger, LOW);

  time_take = pulseIn(echo, HIGH);
  newdist = time_take * 0.034 / 2;
  if (newdist > 200)
    dist = 200;
}
void loop() {
  // put your main code here, to run repeatedly:
  /*
  if (Serial.available()) {
    
    char data = Serial.read();
    cereal();
    Serial.println(data);
    if (data == "High") {
      digitalWrite(pin, HIGH);
      delay(500);
    }
    else if (data == "Low") {
      digitalWrite(pin, LOW);
      delay(500);
    }
  }
  */
  
  calculate_distance(trigger, echo);
  delay(1000);
  calculate_newdistance(trigger, echo);  
  Serial.println(dist);
  Serial.println(newdist);


  
   if (dist - newdist > 5)
  {
    //Serial.print(dist);
    Serial.println("right -1"); //You're going right
    delay(1000);
  }
  else if (dist - newdist > -5 and dist - newdist < 5)
  {
    //Serial.print(dist);
    Serial.println("neutral 0"); //You're in a neutral position
    delay(1000);
  }
  else if (dist - newdist < -5)
  {
    //Serial.print(dist);
    Serial.println("left 1"); //You're going left 
    delay(1000);
  }

 
  

}
