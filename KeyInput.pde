class KeyInput {
  boolean[] keyboardStates;
  boolean[] mouseStates;
  PVector oldMovement;

  KeyInput() {
    keyboardStates = new boolean[255];
    for (int i = 0; i < keyboardStates.length; i++) {
      keyboardStates[i] = false;
    }
    mouseStates = new boolean[8];
    for (int i = 0; i < mouseStates.length; i++) {
      mouseStates[i] = false;
    }
    oldMovement = new PVector();
  }

  void keyPressed() {
    if ((int)key > keyboardStates.length) return;
    keyboardStates[(int)key] = true;
  }

  void keyReleased() {
    if ((int)key > keyboardStates.length) return;
    keyboardStates[(int)key] = false;
  }

  PVector getMovementVector() {
    PVector movement = new PVector();
    movement.y += keyboardStates[(int)'w'] ? 0 : 1;
    movement.y -= keyboardStates[(int)'s'] ? 0 : 1;
    movement.x += keyboardStates[(int)'a'] ? 0 : 1;
    movement.x -= keyboardStates[(int)'d'] ? 0 : 1;
    movement.normalize();
    movement.y = lerp(oldMovement.y, movement.y, 0.2);
    movement.x = lerp(oldMovement.x, movement.x, 0.2);
    oldMovement.set(movement.copy());
    return movement;
  }
  
  boolean wasShoot() {
    return keyboardStates[(int)' '];
  }
}