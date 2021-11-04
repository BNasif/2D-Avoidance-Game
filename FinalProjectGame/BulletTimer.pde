/*
Processes the interval between each bullets, or rate of fire
*/

class BulletTimer{
  int sTime;
  int interval;
  
  BulletTimer(int finInterval){
    interval = finInterval;
  }
  
  void start(){
    sTime = millis();
  }
  boolean bulletFired(){
    int spentTime = millis() - sTime;
    if(spentTime > interval){
      //add bullet sound
      return true;
    } else {
      return false;
    }
  }
  
  void setBulletTimer(int time){
    interval = time;
  }
}
