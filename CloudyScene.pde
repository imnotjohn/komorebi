import toxi.math.noise.*;
class CloudyScene {
  CloudNoise cloud;
  color cloudFromBGColor;
  color cloudToBGColor;
  float opacityTransition;
  
  CloudyScene() {
    cloud = new CloudNoise();
    //opacityTransition = 0;
    //cloudFromBGColor = color(#000000);
    //cloudToBGColor = color(#FF0020);
  }

  //void background() {
    //float u = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength, 0, 1); //test
    //fill(lerpColor(cloudFromBGColor, cloudToBGColor, u));
    //println("\t\t\t\t\t\t\t\t*** " + "elapsed: " + (elapsedTime - toMillisecond(currentScene*2, 00)) + " sceneLength: " + sceneLength + " ***u: " + u);
    //thunder test
    /*if((count++ % 2) < 1 ){
     fill(0);}else fill(255);*/
    //fill(#00057C,10);
    //fill(255);
    //noStroke();
    //rect(width/2, height/2, width, height);
  //}

  void update() {
  }

  void draw() {
    cloud.draw();
    //float u = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength, 0, 1); //test
    //println("\t\t\t\t\t\t\t\t*** " + "elapsed: " + (elapsedTime - toMillisecond(currentScene*2, 00)) + " sceneLength: " + sceneLength + " ***u: " + u);
    //if (u > 0.85) {
    //opacityTransition = lerp(0, 255, u*u);
    //fill(0, opacityTransition);
    //rectMode(CENTER);
    //rect(width/2, height/2, width, height);
    //}
  }

  void display() {
    //background();
    //float d = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength, 0, 1); //test
    //if (d%0.1 == 0) {
    //  cloud.switchNoiseDim();  
    //  println("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\n\n\n\nSwitched!");
    //}
    draw();
  }
}