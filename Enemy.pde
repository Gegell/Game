class Enemy extends GameObject {
  GameObject focusedOn;
  float speed = 1;
  float radius = 10;
  float damage = 1;

  Enemy() {
    id = ID.Enemy;
    chunk = handler.chunks[0][0];
    pos.set(random(width), random(height));
    focusedOn = handler.getEntityByID(ID.Player);
    fullHealth = 10;
    health = random(fullHealth * 0.05, fullHealth);
  }

  void render() {
    fill(100, 200, 0);
    noStroke();
    ellipse(pos.x, pos.y, radius*2, radius*2);
    renderHealth();
    processed = false;
  }

  void renderHealth() {
    if (health < fullHealth * 0.975) {
      fill(100);
      stroke(50);
      rect(pos.x-radius, pos.y-radius-2, pos.x+radius, pos.y-radius-8);
      noStroke();
      if (health > fullHealth * 0.65) fill(0, 200, 0);
      else if (health > fullHealth * 0.35) fill(200, 200, 0);
      else if (health > fullHealth * 0.15) fill(200, 100, 0);
      else fill(200, 100, 0);
      rect(pos.x-radius+1, pos.y-radius-3, pos.x+health*(2*radius-2)/fullHealth-radius-1, pos.y-radius-7);
    }
  }

  void renderDebug() {
    stroke(0, 0, 255);
    line(pos.x, pos.y, vel.x * 3 + pos.x, vel.y * 3 + pos.y);
    stroke(0, 255, 0);
    line(pos.x, pos.y, looking.x * 15 + pos.x, looking.y * 15 + pos.y);
    stroke(255, 0, 0, 100);
    rect(pos.x-radius, pos.y-radius, pos.x+radius, pos.y+radius);
  }

  void tick() {
    updateLooking();
    checkOutOfBounds();
    updatePos();
    processed = true;
  }

  void updatePos() {
    vel.set(looking);
    vel.mult(speed);
    checkCollision();
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

  void checkCollision() {
    PVector chunkpos = handler.getChunkPosition(this);
    for (int cy = (int)chunkpos.y-1; cy <= (int)chunkpos.y+1; cy++) {
      if (cy < 0 || cy > handler.chunks[0].length - 1) continue;  
      //if (chunkpos.y*chunkSize < pos.y-radius || (chunkpos.y+1)*chunkSize > pos.y+radius) continue;
      for (int cx = (int)chunkpos.x-1; cx <= (int)chunkpos.x+1; cx++) {
        if (cx < 0 || cx > handler.chunks.length - 1) continue;  
        //if (chunkpos.x*chunkSize < pos.x-radius || (chunkpos.x+1)*chunkSize > pos.x+radius) continue;
        for (GameObject entity : handler.chunks[cx][cy].entities) {
          if (entity == this || entity.processed) continue;
          if (!(entity.id == ID.Enemy || entity.id == ID.Player)) continue;
          if (entity.pos.dist(this.pos) < this.radius* 2) {
            PVector difference = this.pos.copy();
            difference.sub(entity.pos);
            difference.setMag(speed);
            this.vel.add(difference);
            entity.vel.sub(difference);
            entity.pos.add(entity.vel);
          }
        }
      }
    }
  }

  void updateLooking() {
    looking = focusedOn.pos.copy().sub(pos);
    looking.normalize();
  }
}