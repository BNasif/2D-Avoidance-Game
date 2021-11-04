/*
Class for the blocks

*/

class blockBounds{
  float x,y,w,h;
  blockBounds(float sx, float sy, float sw, float sh){
    x = sx;
    y = sy;
    w = sw;
    h = sh;
  }
  void display(){
    fill(120);
    rect(x,y,w,h);
  }
}
