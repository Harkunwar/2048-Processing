class Tile {
  
  private int value;
  private Map<Integer, Integer> colors;
  private int positionX;
  private int positionY;
  private int newPositionX;
  private int newPositionY;
  
  public Tile(int value, int positionX, int positionY) {
    this.positionX = positionX;
    this.positionY = positionY;
    this.newPositionX = positionX;
    this.newPositionY = positionY;
    this.value = value;
    generateColors();
  }
  
  private void generateColors() {
    colors = new HashMap<Integer,Integer>();
    colors.put(2,#eee4db);
    colors.put(4,#eedfc8);
    colors.put(8,#f2b179);
    colors.put(16,#ec8d55);
    colors.put(32,#f77b5f);
    colors.put(64,#ea5a38);
    colors.put(128,#f2d04b);
    colors.put(256,#f2d04b);
    colors.put(512,#f2d04b);
    colors.put(1024,#e3ba14);
    colors.put(2048,#e3ba14);
  }

  public int getValue() {
    return value;
  }
  
  public void growTile() {
    value = value*2;  
  }
  
  public int getPositionX() {
    return positionX;
  }
  
  public int getPositionY() {
    return positionY;
  }
  
  public int getNewPositionX() {
    return newPositionX;
  }
  
  public int getNewPositionY() {
    return newPositionY;
  }
  
  public void setPosition(int positionX, int positionY) {
    this.positionX = positionX;
    this.positionY = positionY;
  }
  
  public void setNewPosition(int newPositionX, int newPositionY) {
    this.newPositionX = newPositionX;
    this.newPositionY = newPositionY;
  }
  
  public String toString() {
    return value+"";
  }
  
  public Tile add(Tile tile) {
    tile.setNewPosition(newPositionX,newPositionY);
    return new Tile(this.value + tile.value,newPositionX,newPositionY);
  }
  
  public color getColor() {
    return colors.getOrDefault(this.value,#e3ba14);
  }
  
  public int hashCode() {
        return Objects.hashCode(value);
    }
 
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Tile other = (Tile) obj;
        return Objects.equals(this.value, other.value);
    }
  
}
