import codeanticode.syphon.*;
SyphonServer server;

void settings() {
  fullScreen(P3D, SPAN);
  //size(1280,800, P3D);
  PJOGL.profile=1;
}

void setup() {
  server = new SyphonServer(this, "Calibrate MadMapper");
}

void draw() {
  background(127);
  
  noStroke();
  fill(0);
  ellipse(width/3, height/3, 150, 150);
  ellipse(width/5, height/5, 150, 150);
  ellipse(width/8, height/8, 150, 150);
  ellipse(width/2, height/2, 150, 150);
  
  fill(255,0,0);
  ellipse(0, height/3, 150, 150);
  ellipse(0, height/5, 150, 150);
  ellipse(0, height/8, 150, 150);
  ellipse(0, height/2, 150, 150);
  
  fill(0,0,255);
  ellipse(width, height/3, 150, 150);
  ellipse(width, height/5, 150, 150);
  ellipse(width, height/8, 150, 150);
  ellipse(width, height/2, 150, 150);
  
  stroke(255);
  strokeWeight(10);
  line(width/3,0, width/3, height);
  line(0,height/3, width, height/3);
  
  lights();
  noFill();
  translate(width/2, height/2);
  //rotateX(frameCount * 0.01);
  //rotateY(frameCount * 0.01);  
  box(150);

  server.sendScreen();
}