class Cannon {
  boolean isAlive = true;
  float damage;
  float x, y;
  float speed;
  float targetAngle;
  PImage img;
  
  Cannon(float x, float y, float targetAngle){
    this.x = x;
    this.y = y;
    speed = 5;
    damage = 10;
    img = cannonImg;
    this.targetAngle = targetAngle;
  }
  
  void move(){
    x += cos(targetAngle) * speed;
    y += sin(targetAngle) * speed;
  }
  
  void update() {
    move();
    
    if(isOutOfScreen()){
      isAlive = false;
    }else{
      for(int j = 0; j < soldiers.length; j++){
        if(isHit(soldiers[j])){
          onHit(soldiers[j]);
          break;
        }
      }
    }
  }
  
  void onHit(Soldier soldier){
    soldier.hurt(damage);
    isAlive = false;
  }
  
  void display() {
    pushMatrix();
    pushStyle();
    translate(x, y);
    rotate(targetAngle);
    imageMode(CENTER);
    image(img, 0, 0);
    popStyle();
    popMatrix();
  }
  
  float getRadius(){
    return img.width / 2;
  }
  
  boolean isHit(Soldier soldier){
    return soldier != null && soldier.isAlive && dist(x, y, soldier.x, soldier.y) <= getRadius() + soldier.getRadius();
  }
  
  boolean isOutOfScreen(){
    return x < -100 || x > width + 100 || y < -100 || y > height + 100;
  }
}
