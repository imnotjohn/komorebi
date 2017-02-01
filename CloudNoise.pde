/**
<p>SimplexNoise demo showing the noise space in 1-4 dimensions.</p>
<p><strong>Key controls</strong><br/>
1 - 4 : set new number of dimensions for the noise to be computed
</p>
*/

/* 
 * Copyright (c) 2009 Karsten Schmidt
 * 
 * This demo & library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
import toxi.math.noise.*;

class CloudNoise{

int NOISE_DIMENSIONS=2; // increase upto 4; 2 seems to yield larger & more frequent bright spots

float NS = 0.005f; // noise scale (try from 0.005 to 0.5)
float noiseOffset = 100;
PImage img;

ArrayList<Drips> dripsArrayList1;
ArrayList<Drips> dripsArrayList2;

int maxDrips;
float fadeToBlackTransition;

CloudNoise(){
  
  img = createImage(width/3, height/3, RGB);
  
  maxDrips = height*7;//use width for testing on laptop; use height for NDC
  fadeToBlackTransition = 250;
  
  dripsArrayList1 = new ArrayList<Drips>();
  for (int i = 0; i < maxDrips; i++) {
   dripsArrayList1.add(new Drips()); 
  }
  
  dripsArrayList2 = new ArrayList<Drips>();
  for (int i = 0; i < maxDrips; i++) {
   dripsArrayList2.add(new Drips()); 
  }
  
}


 

void draw() {
   
  
  
  for (int i = 0; i < width/3; i++) {
    for (int j = 0; j < height/3; j++) {
      float noiseVal=0;
      float noiseVal1=0;
      switch(NOISE_DIMENSIONS) {
      case 1:
      default:
        noiseVal = (float) SimplexNoise.noise(i * NS + noiseOffset, 0); 
        break;
      case 2:
        noiseVal = (float) SimplexNoise.noise(i * NS + noiseOffset, j * NS + noiseOffset); 
        break;
      case 3: 
        noiseVal = (float) SimplexNoise.noise(i * NS + noiseOffset, j * NS + noiseOffset , frameCount * 0.001); 
        noiseVal1 =  (float) SimplexNoise.noise(i * NS + noiseOffset, j * NS + noiseOffset); 
        break;
      case 4: 
        noiseVal = (float) SimplexNoise.noise(i * NS + noiseOffset, j * NS + noiseOffset, 0 , frameCount * 0.001); 
        break;
      }
//      //int c = (int) (noiseVal * 127 + 128);
      
      
      /*int alpha = (int)(noiseVal * 127 + 128);      
      color c = color((int) (noiseVal * 127 + 128),alpha);
      */
      float thresh = 0.007;
      //noiseVal = (noiseVal + 1)/2 - thresh;
      noiseVal = (noiseVal + 1)*.58 - thresh;
      noiseVal = pow(noiseVal,2)*1.8;
      noiseVal = constrain(noiseVal,0,1);
      int colorVal = (int)map(noiseVal, 0,1, noise(frameCount * 0.4)*random(30), 255);
      color c = color(colorVal);
      
      //img.set(i, j,  c << 16 | c << 8 | c | 0xff000000);
      
      //test
      //float u = map(elapsedTime - toMillisecond(currentScene*2, 00), 0, sceneLength, 0, 1); //test
      //println("\t\t\t\t\t\t\t\t*** " + "elapsed: " + (elapsedTime - toMillisecond(currentScene*2, 00)) + " sceneLength: " + sceneLength + " ***u: " + u);
      //if (u > 0.85) {
      //fadeToBlackTransition = lerp(250, 0, u*u);
      //img.set(i, j, (int)fadeToBlackTransition); //test
      //} else {
      img.set(i, j, c); //original
      tint(color(255,255,210));
      //}
      //tint(color(255,255,210));
      //img.filter(BLUR, 2);
    }
  }
  noiseOffset+=NS/2;
  
 
  image(img,0,0,width,height);
  
  addRemoveDrips();
  //Drips
  for (Drips d : dripsArrayList1) {
    d.cloudGrow();
    d.cloudDisplay();
  }
  
  //while (dripsArrayList1.size() < random(maxDrips/2, maxDrips)) {
  // dripsArrayList1.add(new Drips()); 
  //}
  
  //for (Drips d : dripsArrayList2) {
  //  fill(255);
  //  d.cloudGrow();
  //  d.cloudDisplay();
  //}
  
  //while (dripsArrayList2.size() < random(maxDrips/2, maxDrips)) {
  // dripsArrayList2.add(new Drips()); 
  //}
  
  //println(frameRate);
}

void addRemoveDrips() {
 //removes particles w/ no life remaining
 for (int i = dripsArrayList1.size() - 1; i >= 0; i--) {
  if(frameCount%2==0) {
   Drips d = dripsArrayList1.get(i);
   if (d.finished()){
   dripsArrayList1.remove(i);
   }
  }
 }
 //add particles until the maximum has been reached
 while (dripsArrayList1.size() < maxDrips) {
  dripsArrayList1.add(new Drips()); 
 }
}

void keyPressed() {
  if (key>'0' && key<'5') NOISE_DIMENSIONS=key-'0';
}

}