import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 
import processing.net.*; 
import controlP5.*; 
import peasy.org.apache.commons.math.*; 
import peasy.org.apache.commons.math.geometry.*; 
import blueTelescope.dynamicWall.util.*; 
import blueTelescope.dynamicWall.core.*; 
import blueTelescope.dynamicWall.cacher.*; 
import blueTelescope.dynamicWall.anim.*; 
import blueTelescope.dynamicWall.lib.*; 
import blueTelescope.dynamicWall.app.*; 

import com.google.gson.*; 
import com.google.gson.stream.*; 
import com.google.gson.internal.*; 
import com.google.gson.internal.bind.*; 
import com.google.gson.annotations.*; 
import com.google.gson.reflect.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class BInary extends PApplet {













DynamicWallLib wallLib;

WallAnimation anim = new Animation();

public void setup() {
  

  frameRate(6);

  wallLib = new DynamicWallLib(this, true);

  anim.setup();
  wallLib.currentAnimation = anim;
}

public void draw() {
  wallLib.draw();
}

public void keyPressed() {
  wallLib.keyPressed();
}
public static class Animation extends WallAnimation {

  
  // First, we add metadata to be used in the MoMath system. Change these
  // strings for your behavior.
  String behaviorName = "Binary Wall Behavior";
  String author = "Jeffrey Zhang";
  String description = "Binary Counting Time.";


  // Now we initialize a few helpful global variables.
  boolean forward = true;
  float step = 0.0003f;
  float loc = 0;

  // Number of wall slats
  int wallLength = 128;
  int counter;
  int delay;
  
  // The setup block runs at the beginning of the animation. You could
  // also use this function to initialize variables, load data, etc.
  public void setup() {
    for (DWSlat slat: wall.slats){
      slat.setBottom(0);
      slat.setTop(0);
    }
    counter = 0;
    delay = 100;
  }		 
  
  public static int[] charToInt(char[] arr){
    int[] intArr = new int[arr.length];
    for (int i = 0; i< arr.length; i++){
      intArr[i] = Character.getNumericValue(arr[i]);
    }
    return intArr;
  }
  
  public static int[] convertToBinary(int no){
    int container[] = new int[100];
    int i = 0;
    while (no > 0){
        container[i] = no%2;
        i++;
        no = no/2;
    }
    return container;
   }

    
  // The update block will be repeated for each frame. This is where the
  // action should be programmed.
  public void update() {
    
    int[] binary = convertToBinary(counter);
    System.out.println("counter: " + counter);
    //for ( char c : binaryStrArr){
    //      System.out.println("binary: " + c);

    //}
    for (int index = 0; index < wallLength-1;index++){
        if (index < binary.length){
          DWSlat slat = wall.slats[index];
          DWSlat slat1 = wall.slats[index+1];
          DWSlat slat2 = wall.slats[index+2];
          DWSlat slat3 = wall.slats[index+3];

          slat.setBottom(binary[index]);
          slat1.setBottom(binary[index]);
          slat2.setBottom(binary[index]);
          slat3.setBottom(binary[index]);
          
          slat.setTop(binary[index]);
          slat1.setTop(binary[index]);
          slat2.setTop(binary[index]);
          slat3.setTop(binary[index]);
          
          //try        
          //{
          //    Thread.sleep(1000);
          //} 
          //catch(InterruptedException ex) 
          //{
          //    Thread.currentThread().interrupt();
          //}

              
        }
    }
    counter++;

  }
  

  // Leave this function blank
  public void exit() {
  }
  
  // You can ignore everything from here.
  public String getBehaviorName() {
    return behaviorName;
  }
  
  public String getAuthorName() {
    return author;
  }
  
  public String getDescription() {
    return description;
  }
  
}
  public void settings() {  size(1280, 480, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BInary" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
