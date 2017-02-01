class RainDrop {
  
  float x, y; // X-coordinate, y-coordinate
  float diameter; // Diameter of the ring
  float maxDiameter;
  float strokeWeight;
  float speed; //speed of growing the ring.
  color rainDropCurrentColor;
  boolean on = false; // Turns the display on and off
  
  boolean isFinished;

  RainDrop(float xpos, float ypos,float diam,float stWeight,float _speed){
    x = xpos;
    y = ypos;
    on = true;
    diameter = diam;
    strokeWeight = stWeight;
    speed = _speed;
  
  }
  void setDiameter(float _diam){
    diameter = _diam;
  }
  void setMaxDiameter(float _maxdiam){
    maxDiameter = _maxdiam;
  }
  
  void setColorTrans(color start, color end){
    rainDropStartColor = start;
    rainDropEndColor = end;
  }

  void start(float xpos, float ypos) {
    x = xpos;
    y = ypos;
    on = true;
    
  }
  
  void grow() {
    if (on == true) {
      diameter += speed;
      float u = map(diameter,0,maxDiameter,0,1);
      rainDropCurrentColor = lerpColor(rainDropStartColor, rainDropEndColor,u);
      if (diameter > maxDiameter) {
        diameter = 0.0;
        isFinished = true;
      }
    }
  }
  
  void growRandom() {
  if(on) {
   diameter += speed;
   float u = map(diameter, 0, maxDiameter, 0, 1);
   rainDropCurrentColor = lerpColor(rainDropStartColor, rainDropEndColor, u);
   
   if(diameter > maxDiameter) {
    diameter = 0;
    x = random(width);
    y = random(height);
   }
  }
 }
  
  void display() {
    if (on == true) {
      noFill();
      strokeWeight(strokeWeight);
      stroke(255, 20);
      //fill(currentColor);
      
      ellipse(x, y, diameter, diameter);
      //fill(0);
      //ellipse(x,y,diameter-strokeWeight,diameter-strokeWeight); 
    }
  }
  
  void displayRandom() {
    if(on) {
      noFill();
      strokeWeight(strokeWeight);
      stroke(rainDropCurrentColor,200);
      ellipse(x, y, diameter, diameter);
    }
  }
  
  boolean finished() {
    if (isFinished) {
      return true;
    } else {
      return false;
    }
 }
}

class Drips {
  
 float x, y;
 float diameter = height/24;
 float diameter2 = height/28;
 float diameter3 = height/32;
 float maxDiameter = height/6;
 float maxDiameter2 = height/10;
 float strokeWeight = 5;
 float speed = random(3,6.5);
 color currentColor;
 boolean on = false;
 color rainDripStartColor = color(#000358);
 color rainDripEndColor = color(#000000);
 PVector loc;
 boolean isFinished;
 
 float cloudDiameter;
 
 Drips() {
   getPosition();
   float cloudDiameter = 5;
   
   on = true;
   isFinished = false;
 }
 
 void getPosition() {
   while (loc == null || !shouldDrip(loc)) loc = new PVector (random(width), random(height));
}

 void display1() {
  boolean special = random(1) < 0.001;
  strokeWeight(strokeWeight);
  stroke(255, 120); //TODO* change this to match bg gradation
  ellipse(loc.x, loc.y, diameter, diameter);
  }

void display2() {
  boolean special = random(1) < 0.001;
  strokeWeight(strokeWeight);
  stroke(255, 120); //TODO* change this to match bg gradation
  ellipse(loc.x, loc.y, diameter2, diameter2);
  }

void display3() {
  boolean special = random(1) < 0.001;
  strokeWeight(strokeWeight);
  stroke(255, 120); //TODO* change this to match bg gradation
  ellipse(loc.x, loc.y, diameter3, diameter3);
  }
  
void cloudDisplay() {
  boolean special = random(1) < 0.001;
  strokeWeight(random(5, 15));
  stroke(0, 20);
  fill(0,20);
  ellipse(random(width), random(height), cloudDiameter, cloudDiameter);
  }

 void grow1() {  
   if(on) {
     diameter += 6;
     float u = map(diameter, 0, maxDiameter, 0, 1);
     currentColor = lerpColor(rainDripStartColor, rainDripEndColor, u);
   
   if(diameter > maxDiameter) {
      diameter = 0;
      isFinished = true;
   }
  }
 }
 
 void grow2() {  
   if(on) {
     diameter2 += 4;
     float u = map(diameter2, 0, maxDiameter, 0, 1);
     currentColor = lerpColor(rainDripStartColor, rainDripEndColor, u);
   
   if(diameter2 > maxDiameter) {
      diameter2 = 0;
      isFinished = true;
   }
  }
 }
 
 void grow3() {  
   if(on) {
     diameter3 += 2;
     float u = map(diameter3, 0, maxDiameter2, 0, 1);
     currentColor = lerpColor(rainDripStartColor, rainDripEndColor, u);
   
   if(diameter3 > maxDiameter2) {
      diameter3 = 0;
      isFinished = true;
   }
  }
 }
 
 void cloudGrow() {
  if(on) {
    cloudDiameter += random(0.25, 0.75);
  }
  
  if(cloudDiameter > (int)random(20,30)) {
   cloudDiameter = 0;
   isFinished = true;
  }
 }

boolean shouldDrip(PVector v) {
 int camX = (int)map(v.x, 0, width, 0, cam.width);
 int camY = (int)map(v.y, 0, height, 0, cam.height);
 return (brightness(cam.get(camX, camY)) < 50);
}

boolean finished() {
    if (isFinished) {
      return true;
    } else {
      return false;
    }
 }
}

//test:
/*
class AniDrip {
   
  Ani diameterAni;
  boolean aniIsFinished;
  
  AniDrip() {
    diameterAni = new Ani(this, random(1,5), 0.5, "diameter", 50, Ani.EXPO_IN_OUT, "onEnd:randomize");
    aniIsFinished = false;
    println("\t\t\t\t***ani called!");
  }
  
  void randomize(Ani _ani) {
    //c = lerpColor(from, to, random(1));

    // new repeat count
    int newCount = 1+2*round(random(4));
    diameterAni.repeat(newCount);
    // restart
    diameterAni.start();

    // move to new position
    Ani.to(this, 1.5, "x", random(width), Ani.EXPO_IN_OUT);
    Ani.to(this, 1.5, "y", random(height), Ani.EXPO_IN_OUT);
    aniIsFinished = true;
  }
  
  void draw() {
   fill(255,120);
   stroke(5);
   ellipse(random(width/2), random(height/2), 10, 10);
  }
  
   boolean finished() {
    if (aniIsFinished) {
      return true;
    } else {
      return false;
    }
 }
  
}
*/