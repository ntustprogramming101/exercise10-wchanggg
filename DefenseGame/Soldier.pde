class Soldier {
  boolean isAlive = true;
  float health;
  int scoreValue;
  float x, y;
  float speed;
  float targetAngle;
  PImage img;
  
  Soldier(float x, float y){
    this.x = x;
    this.y = y;
    health = 10;
    speed = 1.2;
    scoreValue = 1;
    img = soldierImg;
    targetAngle = atan2(height / 2 - y, width / 2 - x);
  }
  
  void update() {
    x += cos(targetAngle) * speed;
    y += sin(targetAngle) * speed;
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
  
  void hurt(float damage){
    health -= damage;
    if(health <= 0 && isAlive){
      isAlive = false;
      addScore(scoreValue);
    }
  }
  
  float getRadius(){
    return img.width / 2;
  }
}
