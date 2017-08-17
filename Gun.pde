class Gun {
  GameObject holder;
  String name;
  float cooldown;
  float accuracy;
  float shotSpeed;
  float bulletSpeed;
  float timeLastShot;
  int ammunition;
  int maxAmmunition;
  int bulletsPerShot;

  Gun(GameObject holder, String name, float cooldown, float accuracy, float shotSpeed, float bulletSpeed, int ammunition, int maxAmmunition, int bulletsPerShot) {
    this.holder = holder;
    this.name = name;
    this.cooldown = cooldown;
    this.accuracy = accuracy;
    this.shotSpeed = shotSpeed;
    this.bulletSpeed = bulletSpeed;
    this.ammunition = ammunition;
    this.maxAmmunition = maxAmmunition;
    this.bulletsPerShot = bulletsPerShot;
  }

  void shoot() {
    if (timeLastShot + cooldown < millis()) {
      for (int i = 0; i < bulletsPerShot; i++) {
        holder.chunk.addEntity(new Bullet(holder, this));
      }
      timeLastShot = millis();
    }
  }
}