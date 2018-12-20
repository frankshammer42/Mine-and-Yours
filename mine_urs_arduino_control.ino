#include <Servo.h>  
Servo myservoA;  
Servo myservoB;
Servo myservoC;
Servo myservoD;
Servo myservoE;
Servo myservoF;
int i,pos,myspeed,myshow;
int sea,seb,sec,sed,see,sef;
static int v=0;
String mycommand = "reset_shit";

void move_to_snow_position_first(){
   Serial.println("Start to move to snow position");
   sea=myservoA.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
		myservoA.write(int(map(pos,1,myspeed,sea,120)));
		delay(1);
   }
}

void move_to_snow_position_second(){
   delay(1000);  
   sea=myservoB.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
    myservoB.write(int(map(pos,1,myspeed,sea, 40)));
    delay(1);
   }
}

void move_to_snow_position_third(){
   delay(1000);  
   sea=myservoC.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoC.write(int(map(pos,1,myspeed,sea, 90)));
	delay(1);
   }
}

void move_to_snow_position_fourth(){
   delay(1000);  
   sea=myservoD.read();
   myspeed=500;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoD.write(int(map(pos,1,myspeed,sea, 45)));
	delay(1);
   }
}

void move_to_snow_position_fifth(){
   delay(1000);  
   sea=myservoE.read();
   myspeed=500;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoE.write(int(map(pos,1,myspeed,sea, 20)));
	delay(1);
   }
}

void move_to_snow_position_sixth(){
   delay(1000);  
   sea=myservoF.read();
   myspeed=500;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoF.write(int(map(pos,1,myspeed,sea, 100)));
	delay(1);
   }
}

void move_to_stop_position_first(){
   Serial.println("Start to move to stop position");
   sea=myservoA.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
		myservoA.write(int(map(pos,1,myspeed,sea,60)));
		delay(1);
   }
}

void move_to_stop_position_second(){
   delay(1000);  
   sea=myservoB.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
    myservoB .write(int(map(pos,1,myspeed,sea, 40)));
    delay(1);
   }
}

void move_to_stop_position_third(){
   delay(1000);  
   sea=myservoC.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoC .write(int(map(pos,1,myspeed,sea, 60)));
	delay(1);
   }
}

void move_to_stop_position_fourth(){
   delay(1000);  
   sea=myservoD.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoD.write(int(map(pos,1,myspeed,sea, 70)));
	delay(1);
   }
}

void move_to_stop_position_fifth(){
   delay(1000);  
   sea=myservoE.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoE.write(int(map(pos,1,myspeed,sea, 20)));
	delay(1);
   }
}

void move_to_stop_position_sixth(){
   delay(1000);  
   sea=myservoF.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoF.write(int(map(pos,1,myspeed,sea, 80)));
	delay(1);
   }
}

void reset_position_first(){
   Serial.println("Reset");
   sea=myservoA.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
		myservoA.write(int(map(pos,1,myspeed,sea,90)));
		delay(1);
   }
   /*delay(3000);  */
}

void reset_position_second(){
//   Serial.println("Reset Snow");
   delay(1000);
   sea=myservoB.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
    myservoB.write(int(map(pos,1,myspeed,sea, 30)));
    delay(1);
   }
}

void reset_position_third(){
//   Serial.println("Reset Snow");
   delay(1000);
   sea=myservoC.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoC.write(int(map(pos,1,myspeed,sea,90)));
	delay(1);
   }
}

void reset_position_fourth(){
//   Serial.println("Reset Snow");
   delay(1000);
   sea=myservoD.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoD.write(int(map(pos,1,myspeed,sea,170)));
	delay(1);
   }
}

void reset_position_fifth(){
//   Serial.println("Reset Snow");
   delay(1000);
   sea=myservoE.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoE.write(int(map(pos,1,myspeed,sea,30)));
	delay(1);
   }
}

void reset_position_sixth(){
//   Serial.println("Reset Snow");
   delay(1000);
   sea=myservoF.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
	myservoF.write(int(map(pos,1,myspeed,sea,90)));
	delay(1);
   }
}

void reset_arm(){
  reset_position_first();
  reset_position_second();
  reset_position_third();
  /*reset_position_fourth();*/
  /*reset_position_fifth();*/
  /*reset_position_sixth();*/
}

void move_snow(){
  move_to_snow_position_first(); 
  move_to_snow_position_second(); 
  move_to_snow_position_third(); 
  /*move_to_snow_position_fourth(); */
  /*move_to_snow_position_fifth(); */
  /*move_to_snow_position_sixth(); */
}

void move_stop(){
  move_to_stop_position_first(); 
  move_to_stop_position_second(); 
  move_to_stop_position_third(); 
  /*move_to_stop_position_fourth(); */
  /*move_to_stop_position_fifth(); */
  /*move_to_stop_position_sixth(); */
}

void move_to_snow(){
   sea=myservoA.read();
   seb=myservoA.read();
   sec=myservoA.read();
   sed=myservoA.read();
   see=myservoA.read();
   sef=myservoA.read();
   myspeed=1000;
   for(pos=0;pos<=myspeed;pos+=1)
   {
		myservoA.write(int(map(pos,1,myspeed,sea,120)));
		delay(1);
   }
   delay(1000);
   for(pos=0;pos<=myspeed;pos+=1)
   {
		myservoB.write(int(map(pos,1,myspeed,seb,90)));
		delay(1);
   }
   delay(1000);
   for(pos=0;pos<=myspeed;pos+=1)
   {
		myservoC.write(int(map(pos,1,myspeed,sec,30)));
		delay(1);
   }
   delay(1000);
   for(pos=0;pos<=myspeed;pos+=1)
   {
		myservoD.write(int(map(pos,1,myspeed,sed,20)));
		delay(1);
   }
   delay(1000);
   for(pos=0;pos<=myspeed;pos+=1)
   {
		myservoE.write(int(map(pos,1,myspeed,see,45)));
		delay(1);
   }
   delay(1000);
   for(pos=0;pos<=myspeed;pos+=1)
   {
		myservoE.write(int(map(pos,1,myspeed,see,45)));
		delay(1);
   }
}

void setup() {
  // put your setup code here, to run once:
  pinMode(13,INPUT);
  pinMode(12,INPUT);  
  Serial.begin(9600);
  myservoA.attach(3);  // 控制腰部（A）的端口是~3号
  myservoB.attach(5); // 控制大臂（B）的端口是~5号
  myservoC.attach(6); // 控制小臂（C）的端口是~6号
  myservoD.attach(9); // 控制小臂旋转（D）的端口是~9号*/
  myservoE.attach(10); // 控制腕部（E）的端口是~10号*/
  myservoF.attach(11); // 控制腕部旋转（F）的端口是~11号
  
  myservoA.write(90);
  myservoB.write(30);
  myservoC.write(90);
  myservoD.write(170);
  myservoE.write(30);
  myservoF.write(90);    
}

void loop() {
  while (Serial.available() > 0)  
  {
  	 mycommand += char(Serial.read());
     delay(20);
  }
  if (mycommand.length() > 0){
    mycommand.trim();
    Serial.println(mycommand);
    if (mycommand == "rest"){
	  Serial.println("Move Back");
      reset_arm();
    }
    if (mycommand == "snow"){
      Serial.println("Move to snow");
      move_snow();
    }
	if (mycommand == "stop"){
      Serial.println("Move to stop");
      move_stop();
	}
  }
  mycommand = "";
  // put your main code here, to run repeatedly:
////  move_to_snow_position();
}
