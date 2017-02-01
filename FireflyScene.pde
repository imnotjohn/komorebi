class FireflyScene {
 /*
 * Based on:
 * Simple call for agent population with a flocking behavior based on Craig Reynolds
 * at www.plethora-project.com
 *
 * Library Tutorial:
 * http://www.plethora-project.com/education/2012/10/30/plethora-library-plibs-in-processing/
 */
 
  FireflyScene() {
  }   
 
 void display() {
  setBackground();
  
  for (Ple_Agent pa : fireflyBoids) {
    //call flock: cohesion, alignment, separation.
    //first define the population, then the distances for cohesion,alignment, 
    //separation and then the scales in same order. Try playing with the scales and distances!
    //pa.flock(boids,   4, 10, 10 ,      1, 0.5, 10); //original -- works
    pa.wander2D(2500, 5, PI/2);
    
    //define the boundries of the space as bounce
    pa.bounceSpace(width, height, 0);
    
    //update the tail info every frame (1)
    pa.updateTail(1);

    //display the tail interpolating 2 sets of values:
    //R,G,B,ALPHA,SIZE - R,G,B,ALPHA,SIZE
    pa.displayTailPoints(255, 255, 0, 10,  random(15,25),   255, random(255), 0, 15, random(50,65)); //bleeding glow effect -- works
    //pa.displayTailPoints(0, 0, 0, 10,  random(15,25),   255, 255, random(255), 10, random(50,60)); //original -- works

    //set the max speed of movement:
    pa.setMaxspeed(3);
    //pa.setMaxforce(0.05);
    
    //update agents location based on past calculations
    pa.update();
    //make 2D in some Z plane
    pa.flatten(0);

    //Display the location of the agent with a point
    //strokeWeight(random(4,8));
      strokeWeight(random(4,10));
    stroke(255,255,random(255),random(100,255));
    pa.displayPoint();

    //Display the direction of the agent with a line
    //strokeWeight(0.25);
    //stroke(255,100);
    //pa.displayDir(pa.vel.magnitude());
  }
}

 void setBackground() {
   //println("here" + fireFlyFromBGColor);
   float u = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength, 0, 1); //test
   
   if (u < 0.15) {
      float s = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength/2, 0, 1);
      background(lerpColor(color(#000000), fireFlyFromBGColor, 2*s), 10); //test
    } else if (u >= 0.15 && u <= 0.85 ) {
      background(lerpColor(fireFlyFromBGColor, fireFlyToBGColor, u), 10);
    } else if (u > 0.85) {
      background(lerpColor(fireFlyToBGColor, color(#000000), u), 10);
    }
   
   //background(lerpColor(fireFlyFromBGColor, fireFlyToBGColor, u), 10); //original
   println("\t\t\t\t\t\t\t\t*** " + "elapsed: " + (elapsedTime - toMillisecond(currentScene*2, 00)) + " sceneLength: " + sceneLength + " ***u: " + u);
   //fill(lerpColor(fromBGColor, toBGColor, u), 10); //bleeding glow effect
   //rectMode(CENTER); //bleeding glow effect
   //noStroke(); //bleeding glow effect
   //rect(width/2, height/2, width, height); //bleeding glow effect
 }
}