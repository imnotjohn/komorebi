//RainScene Variables
  color rainDropStartColor = color(255, 255, 255); //rainDrop
  color rainDropEndColor = color(0, 255, 200);   //rainDrop
  
  color rainDripStartColor = color(055, 255, 255); //rainDrop
  color rainDripEndColor = color(0, 255, 200);   //rainDrop
class RainScene {
  
  
  color rainSceneFromBGColor = color(#000358); //rainScene
  color rainSceneToBGColor = color(#000000);   //rainScene -- should be FireflyScene bg start color
//end RainScene Variables
  
  RainDrop rain;
  ArrayList<Drips> dripsArrayList1;
  ArrayList<Drips> dripsArrayList2;
  ArrayList<Drips> dripsArrayList3;
  
  //ArrayList<AniDrip> aniArrayList; //test
  int maxDrips = 2;
  float fadeBGAmount = 10;
  RainScene() {
    rain = new RainDrop(width/2, height/2, 10, 10, 4);
    rain.setMaxDiameter(width);
    rain.setColorTrans(rainDropStartColor, rainDropEndColor);
    
    dripsArrayList1 = new ArrayList<Drips>();
    dripsArrayList2 = new ArrayList<Drips>();
    dripsArrayList3 = new ArrayList<Drips>();
  }
  void display() {
    background();
    update();
    
    addRemoveDrips1();
    addRemoveDrips2();
    addRemoveDrips3();
    updateDrips();
 
    draw();
  }
  
  
  void background() {
    
    float u = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength, 0, 1);
    println("\t\t\t\t\t\t\t\t*** " + "elapsed: " + (elapsedTime - toMillisecond(currentScene*2, 00)) + " sceneLength: " + sceneLength + " ***u: " + u);
    fill(lerpColor(rainSceneFromBGColor, rainSceneToBGColor, u), fadeBGAmount);

    noStroke();
    rect(width/2, height/2, width, height);
  }

  void update() {
    rain.growRandom();
  }

  void draw() {
    rain.displayRandom(); 
  }
  
  void updateDrips() {
   for (Drips d1 : dripsArrayList1) {
     d1.display1();
     d1.grow1();
  }
  
  for (Drips d2 : dripsArrayList2) {
     d2.display2();
     d2.grow2();
  }
  
  for (Drips d3 : dripsArrayList3) {
     d3.display3();
     d3.grow3();
  }
}

void addRemoveDrips1() {
 for (int i = dripsArrayList1.size() - 1; i >= 0; i--) {
  Drips d = dripsArrayList1.get(i);
  
  if (d.finished()) {
   dripsArrayList1.remove(i); 
  }
 }
 
 while ((dripsArrayList1.size() < maxDrips)) {
  dripsArrayList1.add(new Drips()); 
 }
}

void addRemoveDrips2() {
 for (int i = dripsArrayList2.size() - 1; i >= 0; i--) {
  Drips d2 = dripsArrayList1.get(i);
  
  if (d2.finished()) {
   dripsArrayList2.remove(i); 
  }
 }
 
 while ((dripsArrayList2.size() < maxDrips)) {
  dripsArrayList2.add(new Drips()); 
 }
}

void addRemoveDrips3() {
 for (int i = dripsArrayList3.size() - 1; i >= 0; i--) {
  Drips d3 = dripsArrayList3.get(i);
  
  if (d3.finished()) {
   dripsArrayList3.remove(i); 
  }
 }
 
 while ((dripsArrayList3.size() < maxDrips)) {
  dripsArrayList3.add(new Drips()); 
 }
}

//void addRemoveAniDrips() {
// for (int i = aniArrayList.size() - 1; i >= 0; i--) {
//  AniDrip a = aniArrayList.get(i);
//  a.draw();
  
//  if (a.finished()) {
//   dripsArrayList.remove(i); 
//  }
// }
 
// while (dripsArrayList.size() < maxDrips) {
//  dripsArrayList.add(new Drips()); 
// }
//}
}