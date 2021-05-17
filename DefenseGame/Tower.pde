class Tower {
  int maxCannonCount = 16;
  float hitRadius = 26;
  
  float towerTopXOffset = 0;
  float towerTopXMaxOffset = 16;
  
  Cannon[] cannons;
  
  Tower(){
    cannons = new Cannon[maxCannonCount];
  }
  
  void fire(){
    for(int i = 0; i < cannons.length; i++){
      if(cannons[i] == null || !cannons[i].isAlive){
        cannons[i] = new Cannon(width / 2, height / 2, atan2(mouseY - height / 2, mouseX - width / 2));
        towerTopXOffset = towerTopXMaxOffset;
        break;
      }
    }
  }
  
  void update(){
    for(int i = 0; i < cannons.length; i++){
      if(cannons[i] != null && cannons[i].isAlive){
        cannons[i].update();
      }
    }
    
    towerTopXOffset = lerp(towerTopXOffset, 0, 0.2);
  }
  
  void display(){
    for(int i = 0; i < cannons.length; i++){
      if(cannons[i] != null && cannons[i].isAlive){
        cannons[i].display();
      }
    }
    
    pushStyle();
    imageMode(CENTER);
    image(towerBase, width / 2, height / 2);
    
    pushMatrix();
    translate(width / 2, height / 2);
    rotate(atan2(mouseY - height / 2, mouseX - width / 2));
    image(towerImg, -towerTopXOffset, 0);
    popMatrix();
    popStyle();
  }
  
  boolean isHit(Soldier soldier){
    return soldier != null && soldier.isAlive && dist(width / 2, height / 2, soldier.x, soldier.y) <= hitRadius + soldier.getRadius();
  }
}
