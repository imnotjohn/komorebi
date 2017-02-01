
class BlackOut {

  color FromBGColor;
  color ToBGColor;
  BlackOut() {
    FromBGColor = color(255,87,55); //rootsScene color
    ToBGColor = color(255, 250, 200); //LPA color
  }

  void background() {

    //float u = map(frameCount%1000, 0, 1000, 0, 1);
    //float u = map(elapsedTime, 0, sceneLength, 0, 1);
    float u = map(elapsedTime - toMillisecond(12, 00), 0, toMillisecond(3,00), 0, 1);
    println("\t\t\t\t\t\t\t\t*** " + "elapsed: " + (elapsedTime - toMillisecond(12, 00)) + " sceneLength: " + toMillisecond(3,00) + " ***u: " + u);
  
    fill(lerpColor(FromBGColor,ToBGColor, 2*u));
    //thunder test
    /*if((count++ % 2) < 1 ){
     fill(0);}else fill(255);*/
    //fill(#00057C,10);
    //fill(255);
    noStroke();
    rect(width/2, height/2, width, height);
  }

  void update() {
  }

  void draw() {

  }

  void display() {
    background();
    update();
    draw();
  }
}