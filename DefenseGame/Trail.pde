class Trail {
  int maxPositions = 16;
  PVector[] positions;
  int latestIndex = 0;
  int updateCount = 0;
  
  float maxSize = 25;
  float sizeMultiplier = 0.85;
  
  Trail(float startX, float startY){
    positions = new PVector[maxPositions];
    positions[0] = new PVector(startX, startY);
    updateCount++;
  }
  
  void update(float x, float y){
    latestIndex = (latestIndex + 1) % positions.length;
    positions[latestIndex] = new PVector(x, y);
    updateCount++;
  }
  
  void update(){
    update(width * 2, height * 2);
  }
  
  void display(){
    pushStyle();
    ellipseMode(CENTER);
    noStroke();
    float currentSize = maxSize;
    for(int i = 0; i < min(updateCount, maxPositions); i++){
      int index = latestIndex - i;
      if(index < 0) index += maxPositions;
      fill(#FFF646, (float)i / maxPositions * 255);
      ellipse(positions[index].x, positions[index].y, currentSize, currentSize);
      currentSize *= sizeMultiplier;
    }
    popStyle();
  }
}
