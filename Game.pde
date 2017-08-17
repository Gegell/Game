float chunkSize = 75;

Handler handler;
KeyInput input;

void setup() {
  input = new KeyInput();
  handler = new Handler();

  rectMode(CORNERS);
  size(600, 600);
  handler.addEntity(new Player());
}

void draw() {
  handler.tick();
  handler.render();
}

void keyPressed() {
  if (key == 'e') {
    for (int i = 0; i < 1; i++) {
      handler.addEntity(new Enemy());
    }
  }
  input.keyPressed();
}

void keyReleased() {
  input.keyReleased();
}

void mouseClicked() {
  int cx = (int)(mouseX/chunkSize) + handler.border;
  int cy = (int)(mouseY/chunkSize) + handler.border;
  ArrayList<GameObject> debugEntityList = handler.chunks[cx][cy].entities;
  println("Chunk (" + cx + "|" + cy + ") contains" + (debugEntityList.size()>0 ? ":" : " apparently nothing."));
  for (GameObject entity : debugEntityList) {
    println("  " + entity.id);
  }
}