const int m1 =  13;
const int m2 =  12;
const int m3 =  11;
const int m4 =  10;
const int m5 =  9;
const int m6 =  8;
 
void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
  pinMode(m1, OUTPUT);
  pinMode(m2, OUTPUT);
  pinMode(m3, OUTPUT);
  pinMode(m4, OUTPUT);
  pinMode(m5, OUTPUT);
  pinMode(m6, OUTPUT);
}
 
void loop() {
  char a;
  if (Serial.available()>0) {
    a = Serial.read();
    switch (a) {
    case 'A'://all on
      {
        digitalWrite(m1,HIGH);
        digitalWrite(m2,HIGH);
        digitalWrite(m3,HIGH);
        digitalWrite(m4,HIGH);
        digitalWrite(m5,HIGH);
        digitalWrite(m6,HIGH);
        break;
      }
     
    case 'B'://all off
      {
        digitalWrite(m1,LOW);
        digitalWrite(m2,LOW);
        digitalWrite(m3,LOW);
        digitalWrite(m4,LOW);
        digitalWrite(m5,LOW);
        digitalWrite(m6,LOW);
        break;
      }   
      
    case 'C'://m1 on
    {
      all_Off();
      digitalWrite(m1,HIGH);
      break;
    }
    case 'D'://m2 on
    {
      all_Off();
      digitalWrite(m2,HIGH);
      break;
    }
    case 'E'://m3 on
    {
      all_Off();
      digitalWrite(m3,HIGH);
      break;
    }
    case 'F'://m4 on
    {
      all_Off();
      digitalWrite(m4,HIGH);
      break;
    }
    case 'G'://m5 on
    {
      all_Off();
      digitalWrite(m5,HIGH);
      break;
    }
    case 'H'://m6 on
    {
      all_Off();
      digitalWrite(m1,HIGH);
      break;
    }
    case 'I'://m1 and m2 on
    {
      all_Off();
      digitalWrite(m1,HIGH);
      digitalWrite(m2,HIGH);
      break;
    }
    case 'J'://m1, m2, m3 on
    {
      all_Off();
      digitalWrite(m1,HIGH);
      digitalWrite(m2,HIGH);
      digitalWrite(m2,HIGH);
      break;
    }
    case 'K'://m4, m5, m6 on
    {
      all_Off();
      digitalWrite(m4,HIGH);
      digitalWrite(m5,HIGH);
      digitalWrite(m6,HIGH);
      break;
    }
    case 'L'://m1, m2, m3 and m4 on
    {
      all_Off();
      digitalWrite(m1,HIGH);
      digitalWrite(m2,HIGH);
      digitalWrite(m3,HIGH);
      digitalWrite(m4,HIGH);
      break;
    }
    case 'M'://m1, m2, m3 m4 and m5 on
    {
      all_Off();
      digitalWrite(m1,HIGH);
      digitalWrite(m2,HIGH);
      digitalWrite(m3,HIGH);
      digitalWrite(m4,HIGH);
      digitalWrite(m5,HIGH);
      break;
    }
    case 'N'://Pattern left to right
    {
      all_Off();
      digitalWrite(m1,HIGH);
      digitalWrite(m4,HIGH);
      delay(200);
      digitalWrite(m2,HIGH);
      digitalWrite(m5,HIGH);
      delay(200);
      digitalWrite(m3,HIGH);
      digitalWrite(m6,HIGH);
      break;
    }
    case 'O'://Pattern right to left
    {
      all_Off();
      digitalWrite(m3,HIGH);
      digitalWrite(m6,HIGH);
      delay(200);
      digitalWrite(m2,HIGH);
      digitalWrite(m5,HIGH);
      delay(200);
      digitalWrite(m1,HIGH);
      digitalWrite(m4,HIGH);
      break;
    }
    case 'P'://m3 and m4 on
    {
      all_Off();
      digitalWrite(m3,HIGH);
      digitalWrite(m4,HIGH);
      break;
   
    }
    case 'Q'://m5 and m6 on
    {
      all_Off();
      digitalWrite(m1,HIGH);
      digitalWrite(m2,HIGH);
      break;
    }
        case 'Z'://Left
    {
      all_Off();       
      digitalWrite(m1,HIGH);
      digitalWrite(m2,HIGH);
      delay(1000);
      digitalWrite(m1,HIGH);
     digitalWrite(m2,HIGH);
      digitalWrite(m3,HIGH);
      digitalWrite(m4,HIGH);
      delay(1000);
      digitalWrite(m1,HIGH);
      digitalWrite(m2,HIGH);
      digitalWrite(m3,HIGH);
      digitalWrite(m4,HIGH);
      digitalWrite(m5,HIGH);
      digitalWrite(m6,HIGH);
      delay(1000);  
      break;
    }
        case 'Y'://Right
    {
      all_Off();
      digitalWrite(m5,HIGH);
      digitalWrite(m6,HIGH);
      delay(1000);
      digitalWrite(m5,HIGH);
      digitalWrite(m6,HIGH);
      digitalWrite(m3,HIGH);
      digitalWrite(m4,HIGH);
      delay(1000);
      digitalWrite(m1,HIGH);
      digitalWrite(m2,HIGH);
      digitalWrite(m3,HIGH);
      digitalWrite(m4,HIGH);
      digitalWrite(m5,HIGH);
      digitalWrite(m6,HIGH);
      delay(1000);
      break;
    }
    default:
      // statements
      break;
    }
    Serial.println(a);    //remove this line when done testing
      
  }
  
}
 
void all_Off(){
  delay(100);
  digitalWrite(m1,LOW);
  digitalWrite(m2,LOW);
  digitalWrite(m3,LOW);
  digitalWrite(m4,LOW);
  digitalWrite(m5,LOW);
  digitalWrite(m6,LOW);
}
