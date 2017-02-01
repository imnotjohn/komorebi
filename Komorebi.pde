import de.looksgood.ani.*; //test
import de.looksgood.ani.easing.*; //test

/**
 * Komorebi Light 
 *
 */
import ddf.minim.*;
import java.util.*;
import toxi.geom.*;
import toxi.math.*;
import plethora.core.*;
import processing.opengl.*;
import processing.video.*; 
import codeanticode.syphon.*;

//NightScene Variables
  float globalRotation;
  //maximum number of active particles for NightScene
  int maxPGparticles = 800; //originally 800
  int maxBGparticles = 4000; //originally 4000
  //particles are stored in ArrayList PARTICLES
  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<ParticleBGimage> particlesBG = new ArrayList<ParticleBGimage>();
  color BACKGROUND_COLOR = color(0);
  color PGRAPHICS_COLOR = color(0);
  PGraphics pg; //drawing path layer
  PGraphics bg; //default bg image
  PImage sourceImage;
//end NightScene Variables  

//SunnyScene Variables
  //color sunnyFromBGColor = color(#FBFFC4);
  //color sunnyFromBGColor = color(#FF9E00);
  //color sunnyToBGColor = color(#FFC276); //original
  //color sunnyToBGColor = color(#FF530D);
  //color sunnyToBGColor = color(255, 87, 55);
//end SunnyScene Variables  
  
//CloudScene Variables
  //color cloudFromBGColor = color(#000000);
  //color cloudToBGColor = color(#000020);
//end CloudScene Variables 

//FireflyScene Variables
  color fireFlyFromBGColor;
  color fireFlyToBGColor;
  ArrayList <Ple_Agent> fireflyBoids;
  int fireflyPopulation = 800;
//end FireflyScene

long count;
Minim minim;
AudioPlayer BGMplayer;

RainScene rainScene;
NightScene nightScene;
CloudyScene cloudyScene;
SunnyScene sunnyScene;
FireflyScene fireflyScene;
RootsScene rootsScene;
BlackOut blackOut;

int currentScene = 0;
int sceneLength = toMillisecond(2,0);
int elapsedTime = 0; 
boolean scenePaused = false; 

boolean resetFullscreen = false;
Capture cam;

SyphonServer syphon;

void settings() {
  size(1920, 2400, P3D); //fps 50 -- for running at NDC
  //size(1280, 800, P3D); //laptop testing
  //fullScreen(P3D, SPAN);
  PJOGL.profile=1; 
}

void setup() {
  //size(1920, 1200); //fps 22
  
  //fullScreen(P3D, SPAN); //during exhibit
  //background(0);
  noCursor();
  syphon = new SyphonServer(this, "Komorebi");
  
  String[] cameras = Capture.list();
  //println(cameras);
  cam = new Capture(this, cameras[0]);
  noStroke();
  rectMode(CENTER);
  frameRate(35);

  rainScene = new RainScene();
  nightScene = new NightScene();
  cloudyScene = new CloudyScene();
  sunnyScene = new SunnyScene();
  fireflyScene = new FireflyScene();
  rootsScene = new RootsScene();
  blackOut = new BlackOut();
  
  minim = new Minim(this);  
  //  BGMplayer = minim.loadFile("jingle.mp3");
  BGMplayer = minim.loadFile("soundscape-rainy.wav"); 
  //BGMplayer.play();

  /*
   * FireflyScene Begin 
   */

  //initialize the arrayList
  fireflyBoids = new ArrayList <Ple_Agent>();
  fireFlyFromBGColor = color(#000380); //from rainScene final blue 
  fireFlyToBGColor = color(#000000); //to black for NightScene

  for (int i = 0; i < fireflyPopulation; i++) {
    //set the initial location as 0,0,0
    Vec3D v = new Vec3D ();
    v.x = random(width);
    v.y = random(height);
    v.z = 0;
    //create the plethora agents!
    Ple_Agent pa = new Ple_Agent(this, v);

    //generate a random initial velocity
    Vec3D initialVelocity = new Vec3D (random(-1, 1), random(-1, 1), random(-1, 1));

    //set some initial values:
    //initial velocity
    pa.setVelocity(initialVelocity);
    //initialize the tail
    pa.initTail((int)random(5, 10)); //originally 5 --> larger number = harder glow outline.

    //add the agents to the list
    fireflyBoids.add(pa);
  }
  /*
   * FireflyScene End 
   */
}

int sceneTimer() {
  int hour = hour();
  int minute = minute();
  int second = second();
  
  if(!resetFullscreen && hour == 18 && minute == 55){
    launch(dataPath("MadFullscreen.app"));
    resetFullscreen = true;
  }
  else if(hour == 3) resetFullscreen = false; //change this depending on day of the week: M—Th = 00; F—Sa = 03

  if( (hour >= 0 && hour < 2) || (hour >= 19 && hour <= 23)) { //change this depending on day of the week: M—Th = hour < 23; F—Sa = hour < 02
  //if((hour >= 19 && hour < 23)) { //change this depending on day of the week: M—Th = hour < 23; F—Sa = hour < 02
  //if( hour >= 16 && hour < 19){
      elapsedTime = toMillisecond(minute%15,second);    
  }else{
      elapsedTime = -1;
  }
  //elapsedTime = toMillisecond(minute%15,second);  
   //elapsedTime = BGMplayer.position();
  println("currentScene"+currentScene);
  println("elapsedTime:"+ elapsedTime);

  if (elapsedTime >= 0 && elapsedTime < toMillisecond(2, 00) ) {
    if(currentScene==-1) {
      
     BGMplayer.rewind();
      BGMplayer.play();
    }
    currentScene = 0;
  } else if (elapsedTime >= toMillisecond(2, 00) && elapsedTime < toMillisecond(4, 00) ) {
    currentScene = 1;
  } else if (elapsedTime >= toMillisecond(4, 00) && elapsedTime < toMillisecond(6, 00)) {
    currentScene = 2;
  } else if (elapsedTime >= toMillisecond(6, 00) && elapsedTime < toMillisecond(8, 00)) {
    currentScene = 3;
  } else if (elapsedTime >= toMillisecond(8, 00) && elapsedTime < toMillisecond(10,00)) {
    currentScene = 4;
  } else if (elapsedTime >= toMillisecond(10,00) && elapsedTime < toMillisecond(12,00)) {
    currentScene = 5; 
  } else if(elapsedTime < 0 || (elapsedTime >= toMillisecond(12,00) && elapsedTime < toMillisecond(15,00))){
    currentScene = -1;
  }

  return currentScene;
}

void draw() {
  
  
  if (!scenePaused) currentScene = sceneTimer();

  switch(currentScene) {
  case -1:
    blackOut.display();
    break;
  case 0:
    rainScene.display();
    break;
  case 2:
    nightScene.display();
    break;
  case 3:
    cloudyScene.display();
    break;
  case 4:
    sunnyScene.display();
    break;
  case 1:
    fireflyScene.display();
    break;
  case 5:
    rootsScene.display();
    break;
  }

  /*noStroke();
   fill(255, 204);
   ellipse(mouseX, mouseY, mouseY/2+10, mouseY/2+10);
   fill(255, 204);
   int inverseX = width-mouseX;
   int inverseY = height-mouseY;
   ellipse(inverseX, inverseY, (inverseY/2)+10, (inverseY/2)+10);
   */

  syphon.sendScreen();
}

//NightScene refresh with random globalRotation of particle generation
void keyPressed() {
  switch(key) {
  case 'r':
    //clears the screen
    background(BACKGROUND_COLOR);
    particles.clear();
    //randomly sets the global rotation / direction of the Particles
    globalRotation = random(TWO_PI);

    pg.beginDraw();
    pg.clear();
    pg.endDraw();

    bg.beginDraw();
    bg.clear();
    bg.endDraw();

    break;
    
  case ' ':
    scenePaused = !scenePaused;
    break;
    
  case  'b':
    scenePaused = true;
    currentScene = -1;
    break;
  case 'm':
     println("mental");
     launch(dataPath("MadFullscreen.app"));
     break;
  }
  
  if (key >= 48 && key <= 54) {
    scenePaused = true;
    currentScene = key - 49;
    println("current:" + currentScene);
  }
}

void captureEvent(Capture cam) {
  cam.read();
  
}