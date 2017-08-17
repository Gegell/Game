class Bullet extends GameObject {
  GameObject shooter;
  PVector prevPos;
  Gun gun;

  Bullet(GameObject shooter, Gun gun) {
    id = ID.Bullet;
    chunk = handler.chunks[0][0];
    this.gun = gun;
    this.shooter = shooter;
    pos = shooter.pos.copy();
    prevPos = pos.copy();
    vel = shooter.looking.copy().rotate(random(-radians(gun.accuracy)/2, radians(gun.accuracy)/2)).mult(gun.bulletSpeed);
  }

  void tick() {
    updatePos();
    checkOutOfBounds();
  }

  void render() {
    stroke(210, 210, 0);
    line(pos.x, pos.y, prevPos.x, prevPos.y);
  }

  void updatePos() {
    prevPos = pos.copy();
    pos.add(vel);
  }

  void checkOutOfBounds() {
    if (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      chunk.removeEntity(this);
    }
  }
}