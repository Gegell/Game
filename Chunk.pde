class Chunk {
  ArrayList<GameObject> entities;
  int x;
  int y;

  Chunk(int x, int y) {
    entities = new ArrayList<GameObject>();
    this.x = x;
    this.y = y;
  }

  void addEntity(GameObject entity) {
    entities.add(entity);
    entity.chunk = this;
  }

  void removeEntity(GameObject entity) {
    entities.remove(entity);
  }

  void tick() {
    for (int i = 0; i < entities.size(); i++) {
      GameObject entity = entities.get(i);
      entity.tick();
      if (entity.id == ID.Player) {
        noFill();
        stroke(0, 0, 255);
        ellipse((x+.5)*chunkSize, (y+.5)*chunkSize, 10, 10);
      }
    }
  }
  
  void renderForground() {
    for (int i = 0; i < entities.size(); i++) {
      GameObject entity = entities.get(i);
      entity.render();
      //entity.renderDebug();
    }
  }

  void renderBackground() {
    noFill();
    stroke(225);
    rect(x*chunkSize, y*chunkSize, (x+1)*chunkSize, (y+1)*chunkSize);
  }
}