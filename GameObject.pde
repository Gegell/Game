abstract class GameObject {
  PVector pos;
  PVector vel;
  PVector looking;
  boolean processed;
  float fullHealth;
  float health;
  Chunk chunk;
  ID id;

  GameObject() {
    pos = new PVector();
    vel = new PVector();
    looking = new PVector();
  }

  void render() {
  }
  
  void renderDebug() { 
  }

  void tick() {
  }
  
}