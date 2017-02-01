class RootsClass { 
  PVector p, pOld;
  boolean isOutside = false;
  float stepSize, angle, noiseScale, noiseStrength;
  
  RootsClass() {
   p = new PVector(random(width), random(height));
   pOld = new PVector(p.x, p.y);
   stepSize = random(3,6.5);
   noiseScale = 480;
   noiseStrength = random(84,87);
  }
  
  void update() {
   angle = noise(p.x/noiseScale, p.y/noiseScale) * noiseStrength; //was random(84,87)
   
   p.x += cos(angle) * stepSize;
   p.y += sin(angle) * stepSize;
   
   if (p.x < -10) isOutside = true;
   else if (p.x > width+10) isOutside = true;
   else if (p.y < -10) isOutside = true;
   else if (p.y > height + 10) isOutside = true;
   
   if (isOutside) {
    p.x = random(width);
    p.y = random(height);
    pOld.set(p);
   }
   
   strokeWeight(0.6 * stepSize);
   //stroke(random(255), random(255), random(155,250),50); //rainbowish
   //stroke(random(50, 150), random(75, 150), 25, 100); //green
   //stroke(random(40), random(50), random(50), 100);
   float strokeTransition = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength, 0, 1);
   stroke(lerpColor(color(random(40), random(60), random(50)), color(random(50,255),random(50,255),random(35,250)), strokeTransition), 100); //test
   line(pOld.x, pOld.y, p.x, p.y);
   
   pOld.set(p);
   isOutside = false;
}
  
  void modulateNoiseStrength() {
   noiseStrength = noiseStrength + 0.05; //+0.1 for no P3D renderer
   noiseStrength = noiseStrength - random(0.0065, 0.009); //-0.05 no P3D renderer
   if (noiseStrength > 85) noiseStrength = 78;
  }
}