class Player extends GameObject {
  float speed = 5;
  float radius = 5;
  ArrayList<Gun> guns;
  int selectedGun;

  Player() {
    id = ID.Player;
    pos = new PVector(width/2, +height/2);
    chunk = handler.chunks[0][0];
    guns = new ArrayList<Gun>();
    guns.add(new Gun(this, "Test", 500, 10, 1, 10, 100, 100, 5));
    selectedGun = 0;
    health = 100;
  }

  void render() {
    fill(255, 127, 0);
    noStroke();
    ellipse(pos.x, pos.y, radius*2, radius*2);
  }
  
  void renderDebug() { 
    stroke(0, 0, 255);
    line(pos.x, pos.y, vel.x * 3 + pos.x, vel.y * 3 + pos.y);
    stroke(0, 255, 0);
    line(pos.x, pos.y, looking.x * 15 + pos.x, looking.y * 15 + pos.y);
    noFill();
    stroke(0, 0, 255);
    ellipse((chunk.x+.5)*chunkSize, (chunk.y+.5)*chunkSize, 10, 10);
  }

  void tick() {
    updatePos();
    checkOutOfBounds();
    updateLooking();
    updateAction();
  }

  void updatePos() {
    vel = input.getMovementVector().mult(speed);
    pos.add(vel);
  }

  void checkOutOfBounds() {
    if (pos.x < radius) {
      pos.x = radius;
    } else if (pos.x > width - radius) {
      pos.x = width - radius;
    }
    if (pos.y < radius) {
      pos.y = radius;
    } else if (pos.y > height - radius) {
      pos.y = height - radius;
    }
  }

  void updateLooking() {
    looking = new PVector(mouseX, mouseY).sub(pos);
    looking.normalize();
  }

  void updateAction() {
    if (selectedGun >= 0 && input.wasShoot() && guns.size() > 0) {
      Gun gun = guns.get(selectedGun);
      gun.shoot();
    }
  }
}