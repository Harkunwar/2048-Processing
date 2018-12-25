class Grid implements Iterable<Tile>{
  
  Tile[][] grid;
  int size;
  
  Grid(int size) {
    this.size = size;
    grid = new Tile[size][size];
  }
  
  Tile get(int i, int j) {
    return grid[i][j];
  }
  
  void set(int i, int j, Tile tile) {
    grid[i][j] = tile;
    if (tile!=null)
      tile.setNewPosition(120*(i+1),120*(j+1));
  }
  
  public boolean containsTile(Tile t) {
    for(Tile[] tiles: grid) {
      for(Tile tile: tiles) {
        if(tile==t) return true;
      }
    }
    return false;
  }
  
  public List<Tile> getAtPosition(int i, int j) {
    List<Tile> ts = new ArrayList<Tile>();
    for(Tile[] tiles: grid) {
      for(Tile tile: tiles) {
        if(tile!=null && tile.getNewPositionX()==120*(i+1) && tile.getNewPositionY()==120*(j+1))
          ts.add(tile);
      }
    }
    return ts;
  }
   
  public int hashCode() {
    int i = 0;
    int hashCode = 0;
    for(Tile[] tiles: grid) {
      for(Tile tile: tiles) {
        hashCode += ++i*tile.hashCode();
      }
    }
    return hashCode;
  }
 
  public boolean equals(Object obj) {
    if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Grid other = (Grid) obj;
        for(int i=0; i<size; i++) {
          for(int j=0; j<size; j++) {
            if(get(i,j)==null && other.get(i,j)!=null) return false;
            else if(get(i,j)==null && other.get(i,j)==null) continue;
            else if(!get(i,j).equals(other.get(i,j))) return false;
          }
        }
        return true;
   }
   
   public Iterator<Tile> iterator() {
     return new TileIterator();
   }
   
   class TileIterator implements Iterator<Tile> {
     
     int x=0;
     
     boolean hasNext() {
       return x<size*size;
     }
     
     Tile next() {
       int i = x%size;
       int j = x/size;
       x++;
       return grid[i][j];
     }
   }
  
}
