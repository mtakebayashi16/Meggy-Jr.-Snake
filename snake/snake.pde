/*
0 = right
90 = up
180 = left
270 = down
*/

#include <MeggyJrSimple.h>     //Required code line 1 of 2

void setup(){
  MeggyJrSimpleSetup();        //Required code line 2 of 2
}
       
int dotX = random(8);         //instance variables for dot
int dotY = random(8);
int directions = 0;            //create direction variable
int snakeSpeed = 270;
boolean eaten = false;
boolean alive = false;
int score = 1;
int marker = 4;              //represents last index filled in the array

struct Point {              //names the class
  int x;
  int y;
};

Point s1 = {3,4};          //starting points of the snake
Point s2 = {4,4};
Point s3 = {5,4};
Point s4 = {6,4};

Point snakeArray[64] = {s1, s2, s3, s4};

void loop(){                //each time through the loop...
  SetAuxLEDs(score - 1); 
  CheckButtonsDown();        //Check with buttons are pressed
  if (Button_Up)
    directions = 90;
  if (Button_Down)
    directions = 270;
  if (Button_Left)
    directions = 180;
  if (Button_Right)
    directions = 0;
    
  if (directions == 90)        //if direction is 90, add one to y
    snakeArray[0].y ++;
  if (directions == 270)       //if direction is 270, decrease y
    snakeArray[0].y --;
  if (directions == 0)         //if direction is 0, increase x
    snakeArray[0].x ++;
  if (directions == 180)        //if direction is 180, decrease x
    snakeArray[0].x --;
    
  if (snakeArray[0].y > 7)              //adjust values (allows for wrapping of snake)
    snakeArray[0].y = 0;
  if (snakeArray[0].y < 0)
    snakeArray[0].y = 7;
  if (snakeArray[0].x > 7)
    snakeArray[0].x = 0;
  if (snakeArray[0].x < 0)
    snakeArray[0].x = 7;
  
  drawSnake();                    //Display, delay, clear
  DisplaySlate();
  delay(snakeSpeed);
  ClearSlate();
  updateSnake();
  
  DrawPx(dotX, dotY, 1);          //draws the apple
  DisplaySlate();
  
  if (snakeArray[0].x == dotX && snakeArray[0].y == dotY){      //if the snake gets to the dot...
    Tone_Start(ToneC3, 100);    
    ClearSlate();                        //clears everything
    delay(100);
    eaten = true;
    snakeSpeed = snakeSpeed-15;          //increases speed as game progresses
    score = score*2;                     //increases score for Aux LEDs
    marker ++;                           //adds to the body of the snake when the apple is eaten
      if (snakeSpeed < 170)              // makes sure the game doesn't get too fast
        snakeSpeed = 170;
  }
    
  if (eaten == true){                    //redraws dot if the snake eats it
    dotX = random(8);
    dotY = random(8);
    eaten = false; 
  }
  
  if (score > 256)                        //after all the Aux LEDs are lit, they restart from the beginning
    score = 1; 
}                                         //ends loop


void drawSnake(){
  for (int i = 1; i < marker; i++){
    DrawPx(snakeArray[0].x,snakeArray[0].y, Blue);
    DrawPx(snakeArray[i].x, snakeArray[i].y, Green);
    if (snakeArray[0].x == snakeArray[i].x && snakeArray[0].y == snakeArray[i].y)
      alive = true;   
    if (alive){                    //death sequence
      ClearSlate();
      delay(2000);
      Tone_Start(ToneA3, 1000);
      score = 1;                    //resets score and length
      marker = 4;
      alive = false;
}  
  }
}
  
void updateSnake(){                   
  for (int i = marker-1; i > 0; i--){
    snakeArray[i].x = snakeArray[i-1].x;
    snakeArray[i].y = snakeArray[i-1].y;
  }
}


