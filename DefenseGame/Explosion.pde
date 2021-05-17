class Explosion {
  int leftFrames;
  int initFrames;
  float x, y, size;
  float rotation;
  
  Explosion(float x, float y, float time, float radius) {
    leftFrames = initFrames = floor(time * 60);
    this.x = x;
    this.y = y;
    size = radius * 2;
    rotation = random(TWO_PI);
  }
  
  void update(){
    if(leftFrames > 0) leftFrames--;
  }
  
  void display(){
    pushMatrix();
    pushStyle();
    translate(x, y);
    rotate(rotation);
    imageMode(CENTER);
    float alpha = (float)leftFrames / initFrames * 255;
    tint(#FA8100, alpha);
    image(explosionImg, 0, 0, size, size);
    tint(#FAC800, alpha);
    image(explosionImg, 0, 0, size * 0.8, size * 0.8);
    tint(#FFF646, alpha);
    image(explosionImg, 0, 0, size * 0.8, size * 0.6);
    popStyle();
    popMatrix();
  }
  
  boolean hasEnded(){ return leftFrames <= 0; };
}
