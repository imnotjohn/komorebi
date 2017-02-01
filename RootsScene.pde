class RootsScene {
 RootsClass[] rootsArray = new RootsClass[10000];
 boolean shouldRedraw;
 color rootsSceneFromBGColor = color(255,87,55);
 //color rootsSceneToBGColor = color(0,0,0);
 
  RootsScene() {
   for (int i = 0; i < rootsArray.length; i++) {
    rootsArray[i] = new RootsClass();
  }
 }
 
 void display() {
   backgroundRect();
   
   for (RootsClass r : rootsArray) {
     r.update();
     r.modulateNoiseStrength();
   }
 }
 
 void backgroundRect() {
  rectMode(CENTER);
  
  fill(rootsSceneFromBGColor, 10);
  noStroke();
  rect(width/2, height/2, width, height);
  }
}