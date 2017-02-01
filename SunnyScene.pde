class SunnyScene {
  Flock flock1, flock2, flock3;
  int numberOfBoids = 25;
  
  color sunnyFromBGColor;
  color sunnyToBGColor;
  
  SunnyScene() {
    
    flock1 = new Flock();
    flock2 = new Flock();
    flock3 = new Flock();
    // Add an initial set of boids into the system
    for (int i = 0; i < numberOfBoids; i++) {
      float maxSpeed1 = 2.5;
      float maxSpeed2 = random(5.5, 7.5); 
      float maxSpeed3 = 1.0; 
      float maxForce = 2.05;
      //float size = random(20,80);
       float size = random(10,40);
    
      Vec2D loc1 = new Vec2D(random(width),random(height));
      Vec2D loc2 = new Vec2D(random(width/3),random(height));
      Vec2D loc3 = new Vec2D(random(width/2, width),random(height));
      flock1.addBoid(new Boid(loc1, size, maxSpeed1, maxForce));
      flock2.addBoid(new Boid(loc2, random(10,25), maxSpeed2, maxForce));
      flock3.addBoid(new Boid(loc3, size, maxSpeed3, maxForce));
    }
 
    sunnyFromBGColor = color(#FF9E00);
    //sunnyToBGColor = color(#F05800); //old
    sunnyToBGColor = color(255, 87, 55); //transitions to roots bgColor
  } 
  void display() {
    background();
    update();
    draw();
  }
  void background() {

    float u = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength, 0, 1);
    if (u < 0.2) {
      float s = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength/5, 0, 1);
      fill(lerpColor(color(#000000), sunnyFromBGColor, s), 50); //test
    } else {
      fill(lerpColor(sunnyFromBGColor, sunnyToBGColor, u), 50);
    }
    println("\t\t\t\t\t\t\t\t*** " + "elapsed: " + (elapsedTime - toMillisecond(currentScene*2, 00)) + " sceneLength: " + sceneLength + " ***u: " + u);
    noStroke();
    rect(width/2, height/2, width, height);
  }

  void update() {
  }

  void draw() {
    flock1.run();
    flock2.run();
    flock3.run();
  }
}