import java.util.*;

class Game {
  
  private Grid grid;
  private Grid newGrid;
  private PFont Font1 = createFont("Arial Bold", 50);

  Game() {
   noStroke(); 
   grid = new Grid(4);
   genTile();
   genTile();
   newGrid = grid;
  }
  
  void draw() {
    background(#baaea0);
    drawTiles();
  }
  
  void drawTiles() {
    for(int i=0; i<4; i++)
      for(int j=0; j<4; j++) {
        fill(#cdc1b5);
        rect(120*(i+1),120*(j+1),-100,-100);
      }
      boolean temp=true;
    for(int i=0; i<4; i++)
      for(int j=0; j<4; j++) {
        Tile tile = grid.get(i,j);
        if (tile != null) {
          fill(tile.getColor());
          int px = tile.getPositionX();
          int py = tile.getPositionY();
          int pnx = tile.getNewPositionX();
          int pny = tile.getNewPositionY();
          if(px<pnx) {px+=10; temp=false;}
          else if(px>pnx) {temp=false;px-=10;}
          else if(py<pny) {temp=false;py+=10;}
          else if(py>pny) {temp=false;py-=10;}
          
          tile.setPosition(px,py);
          rect(px,py,-100,-100);
          textAlign(CENTER,CENTER);
          textFont(Font1);
          fill(tile.getValue()<=4?#71675e:#faffff);
          text(tile.getValue()+"", px,py,-100,-100);
        }
      }
      
    if(temp && !grid.equals(newGrid)) { 
      grid = newGrid;
      genTile(); 
    }
  }
  
  void genTile() {
    int zero = 0;
    int n = Math.random()<0.9?2:4;
    for(int i=0; i<4; i++)
      for(int j=0; j<4; j++)
        if(grid.get(i,j) == null) zero++;
    int randLoc = (int) (Math.random()*zero);
    
    int temp=0;
    for(int i=0; i<4; i++)
      for(int j=0; j<4; j++) {
        if(grid.get(i,j) == null) {
          if(temp==randLoc)
            grid.set(i,j, new Tile(n,120*(i+1),120*(j+1)));
          temp++;
        }
      }
    if (zero==0)
      checkGameEnd();
  }
  
  void checkGameEnd() {
    boolean gameEnd = true;
    for(int i=0; i<4; i++) {
      for(int j=0; j<4; j++) {
        if(i<3 && grid.get(i,j).equals(grid.get(i+1,j))) {
          gameEnd = false;
          break;
        }
        if(j<3 && grid.get(i,j).equals(grid.get(i+1,j))) {
          gameEnd = false;
          break;
        }
      }
    }
    if(gameEnd)
      gameEnd();
  }
  
  void gameEnd() {
    print("Game End");
  }
  
  void move(int keyCode) {
    if(!grid.equals(newGrid)) {
      grid = newGrid;
      genTile();
    }
      switch(keyCode) {
        case UP: moveUp(); break;
        case DOWN: moveDown(); break;
        case LEFT: moveLeft(); break;
        case RIGHT: moveRight(); break;
      }   
  }
 
  private void moveLeft() {
    newGrid = new Grid(4);
    for(int j=0; j<4; j++) {
      int n = 0;
      for(int i=0; i<4; i++) {
        if(this.grid.get(i,j) != null) 
          newGrid.set(n++,j,this.grid.get(i,j));
          
      }
    }
    for(int j=0; j<4; j++) {
      for(int i=0; i<3; i++) {
        if(newGrid.get(i,j) != null && newGrid.get(i,j).equals(newGrid.get(i+1,j))) {
          newGrid.get(i+1,j).setNewPosition(120*(i+1),120*(j+1));
          newGrid.set(i,j,newGrid.get(i,j).add(newGrid.get(i+1,j)));
          for(int k=i+1; k<3; k++) {
            newGrid.set(k,j,newGrid.get(k+1,j));
          }
          newGrid.set(3,j,null);
        }
      }
    }
  }
  private void moveDown() {
    newGrid = new Grid(4);
    for(int i=3; i>=0; i--) {
      int n = 3;
      for(int j=3; j>=0; j--) {
        if(this.grid.get(i,j) != null) 
          newGrid.set(i,n--,this.grid.get(i,j));
      }
    }
    for(int i=3; i>=0; i--) {
      for(int j=3; j>0; j--) {
        if(newGrid.get(i,j) != null && newGrid.get(i,j).equals(newGrid.get(i,j-1))) {
          newGrid.get(i,j-1).setNewPosition(120*(i+1),120*(j+1));
          newGrid.set(i,j,newGrid.get(i,j).add(newGrid.get(i,j-1)));
          
          for(int k=j-1; k>0; k--) {
            newGrid.set(i,k,newGrid.get(i,k-1));
          }
          newGrid.set(i,0,null);
        }
      }
    }
  }
  private void moveUp() {
    newGrid = new Grid(4);
    for(int i=0; i<4; i++) {
      int n = 0;
      for(int j=0; j<4; j++) {
        if(this.grid.get(i,j) != null) 
          newGrid.set(i,n++,this.grid.get(i,j));
      }
    }
    for(int i=0; i<4; i++) {
      for(int j=0; j<3; j++) {
        if(newGrid.get(i,j) != null && newGrid.get(i,j).equals(newGrid.get(i,j+1))) {
          newGrid.get(i,j+1).setNewPosition(120*(i+1),120*(j+1));
          newGrid.set(i,j,newGrid.get(i,j).add(newGrid.get(i,j+1)));
          for(int k=j+1; k<3; k++) {
            newGrid.set(i,k,newGrid.get(i,k+1));
          }
          newGrid.set(i,3,null);
        }
      }
    }
  }
  private void moveRight() {
    newGrid = new Grid(4);
    for(int j=3; j>=0; j--) {
      int n = 3;
      for(int i=3; i>=0; i--) {
        if(this.grid.get(i,j) != null) 
          newGrid.set(n--,j,this.grid.get(i,j));
      }
    }
    for(int j=3; j>=0; j--) {
      for(int i=3; i>0; i--) {
        if(newGrid.get(i,j) != null && newGrid.get(i,j).equals(newGrid.get(i-1,j))) {
          newGrid.get(i-1,j).setNewPosition(120*(i+1),120*(j+1));
          newGrid.set(i,j,newGrid.get(i,j).add(newGrid.get(i-1,j)));
          for(int k=i-1; k>0; k--) {
            newGrid.set(k,j,newGrid.get(k-1,j));
          }
          newGrid.set(0,j,null);
        }
      }
    }
  }
  
  int getScore() {
    return 0;
  }
  
  private Grid getGrid() {
    Grid grid = new Grid(4);
    try {
      for(int i=0; i<4; i++)
        for(int j=0; j<4; j++) {
          grid.set(i,j,this.grid.get(i,j));
        }
    } catch(Exception ignored) {}
    return grid;
  }
}
