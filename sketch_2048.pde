Game game;

void setup() {
  size(500,500);
  game = new Game();
  frameRate(120);
}

void draw() {
  game.draw();
}

void keyPressed() {
  if(key==CODED) 
    game.move(keyCode);
  else if(key == 'r' || key == 'R')
    game = new Game();
}
