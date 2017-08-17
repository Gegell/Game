class Handler {
  Chunk[][] chunks;
  int border;

  Handler() {
    border = 1; //how many chunks are out of view
    genChunks();
  }

  void genChunks() {
    chunks = new Chunk[ceil(width/chunkSize)+ border*2][ceil(height/chunkSize)+border*2];
    for (int cy = 0; cy < chunks[0].length; cy++) {
      for (int cx = 0; cx < chunks.length; cx++) {
        chunks[cx][cy] = new Chunk(cx-border, cy-border);
      }
    }
  }

  void moveOverChunks() {
    for (int cy = 0; cy < chunks[0].length; cy++) {
      for (int cx = 0; cx < chunks.length; cx++) {
        ArrayList<GameObject> chunkEntities = chunks[cx][cy].entities;
        for (int i = chunkEntities.size() - 1; i >= 0; i--) {
          GameObject entity = chunkEntities.get(i);
          PVector chunkpos = getChunkPosition(entity);
          int xPos = (int)chunkpos.x;
          int yPos = (int)chunkpos.y;
          if (xPos < 0 || xPos > chunks.length-1 || yPos < 0 || yPos > chunks[0].length-1) {
            chunks[cx][cy].removeEntity(entity);
            continue;
          }
          if (xPos != cx || yPos != cy) {
            chunks[(int)chunkpos.x][(int)chunkpos.y].addEntity(entity);
            chunks[cx][cy].removeEntity(entity);
          }
        }
      }
    }
  }

  PVector getChunkPosition(GameObject entity) {
    PVector coords = new PVector();
    coords.x = floor(entity.pos.x/chunkSize) + border;
    coords.y = floor(entity.pos.y/chunkSize) + border;
    return coords;
  }

  void addEntity(GameObject entity) {
    PVector chunkpos = getChunkPosition(entity);
    chunks[(int)chunkpos.x][(int)chunkpos.y].addEntity(entity);
  }

  GameObject getEntityByID(ID id) {
    for (int cy = 0; cy < chunks[0].length; cy++) {
      for (int cx = 0; cx < chunks.length; cx++) {
        for (GameObject entity : chunks[cx][cy].entities) {
          if (entity.id == id) {
            return entity;
          }
        }
      }
    }
    return null;
  }

  void tick() {
    for (int cy = 0; cy < chunks[0].length; cy++) {
      for (int cx = 0; cx < chunks.length; cx++) {
        chunks[cx][cy].tick();
      }
    }
    moveOverChunks();
  }

  void render() {
    background(255);
    for (int cy = 0; cy < chunks[0].length; cy++) {
      for (int cx = 0; cx < chunks.length; cx++) {
        chunks[cx][cy].renderBackground();
      }
    }
    for (int cy = 0; cy < chunks[0].length; cy++) {
      for (int cx = 0; cx < chunks.length; cx++) {
        chunks[cx][cy].renderForground();
      }
    }
  }
}