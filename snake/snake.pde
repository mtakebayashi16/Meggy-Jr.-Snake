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

int snakeX = 0;       //create instance variables for snakeX and snakeY
int snakeY = 0;        
int dotX = random(8);         //instance variables for dot
int dotY = random(8);
int directions = 0;            //create direction variable

void loop(){                  //each time through the loop...
  CheckButtonsDown();        //check with buttons are pressed
  if (Button_Up)
    directions = 90;
  if (Button_Down)
    directions = 270;
  if (Button_Left)
    directions = 180;
  if (Button_Right)
    directions = 0;
    
  if (directions == 90)        //if direction is 90, add one to y
    snakeY ++;
  if (directions == 270)       //if direction is 270, decrease y
    snakeY --;
  if (directions == 0)         //if direction is 0, increase x
    snakeX ++;
  if (directions == 180)        //if direction is 180, decrease x
    snakeX --;
    
  if (snakeY > 7)              //adjust values (allows for wrapping of snake)
    snakeY = 0;
  if (snakeY < 0)
    snakeY = 7;
  if (snakeX > 7)
    snakeX = 0;
  if (snakeX < 0)
    snakeX = 7;
  
  DrawPx(snakeX, snakeY, 4);    //Display, delay, clear
  DisplaySlate();
  delay(200);
  ClearSlate();
  
  DrawPx(dotX, dotY, 1);
  DisplaySlate();
  
  if (ReadPx(snakeX, snakeY) == 1){      //if the snake gets to the dot...
    Tone_Start(ToneC3, 100);    
    ClearSlate();                        //clears everything
    delay(100);
    do {                                 //redraws dot
       dotX = random(8);
    }
    while (snakeX == dotX);
    do {
      dotY = random(8);
    }
    while (snakeY == dotY);
  }                             //ends if
  
  
}                               //ends loop



