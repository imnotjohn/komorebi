class ParticleBGimage
{
 PVector loc;
 float life, lifeRate;
 float particleSize; 
 
 ParticleBGimage() 
 {
   getPosition();
   //life = random(0.75, 1.25);
   life = random(6, 9);
   lifeRate = random(0.005, 0.75);
   particleSize = random(7,12);
 }
 
 void updateBG()
 {
  float angle = noise(loc.x * 0.01, loc.y*0.01) * TWO_PI;
  PVector vel = PVector.fromAngle(angle + globalRotation);
  loc.add(vel);
  life -= lifeRate;
 }
 
 void displayBG()
 {
  boolean special = random(1) < 0.001;
  //strokeWeight(special ? random(0.75, 3) : 0.75);
  noStroke();
  fill (255, special ? random(175, 255) : 65);
  //point (loc.x, loc.y);
  ellipse(loc.x,loc.y,particleSize,particleSize);
 }
 
 //get a random position from w/in the text
 void getPosition()
 {
  while (loc == null || !isInText(loc)) loc = new PVector (random(width), random(height)); 
 }
 
 //return if point is inside the text
 boolean isInText(PVector v)
 {
   //boolean test;
   
  //int x = (int)map(v.x,0,width,0,sourceImage.width);
  //int y = (int)map(v.y,0,height,0,sourceImage.height);
  int camX = (int)map(v.x,0,width,0,cam.width);
  int camY = (int)map(v.y,0,height,0,cam.height);
 /* sourceImage.loadPixels();
  test = brightness(sourceImage.pixels[x+y*sourceImage.width]) > 100;
  sourceImage.updatePixels();2*/
  
//  return test;
  //return (sourceImage.get(x, y) == PGRAPHICS_COLOR) || (brightness(cam.get(camX, camY)) < 5) ;
  //return (brightness(cam.get(camX, camY)) < 20) ; //original
  return (brightness(cam.get(camX, camY)) < 50) ; //changed to 50 for brighter environment, otherwise scene lags severely when drawing particles.
  
 }
}