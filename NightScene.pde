//color nightSceneBGColor = color(0,0,58);
color nightSceneBGColor = color(#000380); //end of fireflyscene bg color

class NightScene {  
  //PImage sourceImage; //default source image

  NightScene() {
  pg = createGraphics(width, height, JAVA2D); 
  bg = createGraphics(width, height, JAVA2D);
  //sourceImage = loadImage("nightParticleImage1280_800.png");
  
  cam.start();
 }
 
 void display() {
  //fill(nightSceneBGColor, 10); 
  float u = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength, 0, 1); //test
  fill(lerpColor(nightSceneBGColor, color(#000000), u), 10); //test
  println("\t\t\t\t\t\t\t\t*** " + "elapsed: " + (elapsedTime - toMillisecond(currentScene*2, 00)) + " sceneLength: " + sceneLength + " ***u: " + u);
  //needs bgcolor transition?
  
  noStroke();
  rect(width/2, height/2, width, height);
  /*if (cam.available() == true) {
    cam.read();
  }*/
 // sourceImage.copy(cam, 0, 0, cam.width, cam.height, 0, 0, sourceImage.width, sourceImage.height);
  //sourceImage.updatePixels();
  //cam.loadPixels();
  //image(cam,0,0,width,height);
  //image(sourceImage, 0, 0,width,height);
  //bg PGraphics object corresponds to path where particles should be born by default Image
  bg.beginDraw();
  bg.noStroke();
  //bg.image(sourceImage, 0, 0,width,height);
  //bg.image(cam, 0, 0,width,height);
  //bg.image(cam, 0, 0); //TESTED camera. really slowdown till nothing will show up.
  
  bg.endDraw();
  
  //pg Pgraphics object corresponds to the path where the particles should be born
  pg.beginDraw();
  pg.clear();
  pg.fill(0);
  
  //draws path to generate particles
  pg.noStroke();
  pg.ellipse(mouseX, mouseY, 50, 50); 
  pg.endDraw();
  
  //Mouse Cursor
  stroke(255,15);
  strokeWeight(random(6,12));
  fill(0,45);
  ellipse(mouseX, mouseY, random(48,52), random(48, 52));
  
  addRemoveParticles();
  addRemoveParticlesBG();
  
  for (Particle p : particles) {
   p.update();
   p.display();
  }
  
  for (ParticleBGimage pbg : particlesBG) {
   pbg.updateBG();
   pbg.displayBG();
  }
  
 }
 
 void addRemoveParticles() {
 //removes particles w/ no life remaining
 for (int i = particles.size() - 1; i >= 0; i--) {
  Particle p = particles.get(i);
  if(p.life <= 0) {
   particles.remove(i); 
  }
 }
 //add particles until the maximum has been reached
 while (particles.size() < maxPGparticles) {
  particles.add(new Particle()); 
 }
}

void addRemoveParticlesBG() {
 //removes particles w/ no life remaining
 for (int i = particlesBG.size() - 1; i >= 0; i--) {
  ParticleBGimage pbg = particlesBG.get(i);
  if(pbg.life <= 0) {
   particlesBG.remove(i); 
  }
 }
 //add particles until the maximum has been reached
 while (particlesBG.size() < maxBGparticles) {
  particlesBG.add(new ParticleBGimage()); 
 }
}

}