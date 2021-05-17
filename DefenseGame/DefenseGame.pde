//
//  Created by rarakasm on 2019/5/13
//  Assets courtesy of kenney.nl
//  Font by Valentin Antonov under non-commericial use
//  Revised by Prof. Jones Yu.
//

final int GAME_RUN = 0;
final int GAME_OVER = 1;

int gameState = GAME_RUN;

PImage bg, towerBase;
PImage towerImg;
PImage soldierImg, ramboImg;
PImage cannonImg, firecannonImg, rocketImg, missileImg;
PImage explosionImg;

PFont font;

int score = 0;
float scoreTextMinSize = 72;
float scoreTextMaxSize = 96;
float scoreTextSize = scoreTextMinSize;

int maxSoldierCount = 6;
float ramboSpawnChance = 0.1;
int spawnInterval = 100;
int spawnTimer = 0;

Tower tower;
Soldier soldiers[];

void setup(){
  size(512, 512);
  bg = loadImage("img/bg.png");
  towerBase = loadImage("img/tower_base.png");
  towerImg = loadImage("img/tower_lv1.png");
  soldierImg = loadImage("img/soldier.png");
  ramboImg = loadImage("img/rambo.png");
  cannonImg = loadImage("img/cannon.png");
  firecannonImg = loadImage("img/firecannon.png");
  rocketImg = loadImage("img/rocket.png");
  missileImg = loadImage("img/missile.png");
  explosionImg = loadImage("img/explosion.png");
  
  font = createFont("ObelixPro.ttf", 96, true);
  textFont(font);
  
  tower = new Tower();
  soldiers = new Soldier[maxSoldierCount];
}

void draw(){
  
  switch(gameState){
    case GAME_RUN:
  
    // draw background
    for(int i = - bg.width; i < width + bg.width; i += bg.width){
      for(int j = - bg.height; j < height + bg.height; j += bg.height){
        image(bg, i, j);
      }
    }
    
    drawScore();
    
    tower.update();
    tower.display();
    
    spawnTimer++;
    if(spawnTimer >= spawnInterval){
      spawnTimer = 0;
      spawnSoldier();
    }
    
    for(int i = 0; i < soldiers.length; i++){
      if(soldiers[i] != null && soldiers[i].isAlive){
        soldiers[i].update();
        soldiers[i].display();
        if(tower.isHit(soldiers[i])){
          gameState = GAME_OVER;
        }
      }
    }
    if(gameState == GAME_OVER){
      drawGameOverText();
    }
    break;
    
    case GAME_OVER:
    break;
  }
}

void spawnSoldier(){
  for(int i = 0; i < soldiers.length; i++){
    if(soldiers[i] == null || !soldiers[i].isAlive){
      float angle = random(TWO_PI);
      float distance = random(400, 600);
      float x = width / 2 + cos(angle) * distance;
      float y = height / 2 + sin(angle) * distance;
      // spawn a soldier
      soldiers[i] = new Soldier(x, y);
      break;
    }
  }
}


void keyReleased(){
  switch(gameState){
    case GAME_RUN:
      switch(key){
        case ' ': 
          tower.fire(); 
          break;
      }
      break;
  }
}

void mouseReleased(){
  switch(gameState){
    case GAME_RUN:
      tower.fire();
      break;
    
    case GAME_OVER:
      soldiers = new Soldier[maxSoldierCount];
      tower = new Tower();
      score = 0;
      gameState = GAME_RUN;
      break;
  }
}

void addScore(int value){
  score += value;
  scoreTextSize = scoreTextMaxSize;
}

float getRadiansDifference(float a, float b){
  float result = b - a;
  if(result > PI) result -= TWO_PI;
  else if(result < - PI) result += TWO_PI;
  return abs(result);
}

void drawScore(){
  scoreTextSize = lerp(scoreTextSize, scoreTextMinSize, 0.12);
  textAlign(CENTER, CENTER);
  textSize(scoreTextSize);
  fill(#ffffff, 100);
  text(score, width / 2, height / 2 + 100);
}

void drawGameOverText(){
  textAlign(CENTER, CENTER);
  textSize(64);
  fill(0, 120);
  text("GAME OVER", width / 2 + 3, height / 2 - 120 + 3);
  fill(#ff0000);
  text("GAME OVER", width / 2, height / 2 - 120);
  
  textSize(32);
  fill(0, 120);
  text("SCORE: " + score, width / 2 + 3, height / 2 + 3);
  text("click to restart", width / 2 + 3, height / 2 + 200 + 3);
  fill(#ffffff);
  text("SCORE: " + score, width / 2, height / 2);
  text("click to restart", width / 2, height / 2 + 200);
}
