public static class Animation extends WallAnimation {


  // First, we add metadata to be used in the MoMath system. Change these
  // strings for your behavior.
  String behaviorName = "Example Dynamic Wall Behavior";
  String author = "MoMath";
  String description = "Simple forward-backward behavior.";


  // Now we initialize a few helpful global variables.
  boolean forward = true;
  float step = 0.0003;
  float loc = 0;
  int index2 =0;
  String test = binary(44);
  int range = 20;//int(pApplet.random(30));

  // Number of wall slats
  int wallLength = 128;
  int counter = 0;
  
  float[] wallValue = new float[wallLength];

  
  // The setup block runs at the beginning of the animation. You could
  // also use this function to initialize variables, load data, etc.
  void setup() {
    // reset back to back
    println(test);
    println(test.charAt(test.length()-1));
    for (DWSlat slat : wall.slats) {
    slat.setBottom(0);
    slat.setTop(0);
    }
  }		 

  // The update block will be repeated for each frame. This is where the
  // action should be programmed.
  void update() {
    if(counter == wallLength-1){
         //reset
         
          //wallValue[wall.slats.length-index] += 0.5;   
          //range = int(pApplet.random(30));
          counter =0;
      
    }
    for (int index = 0; index < wall.slats.length; index++) {
          wallValue[index] = 0.5;}
          
    // the 10 forward
    int value =0;
    for (int index = counter; index < counter+range && index < wall.slats.length; index++) {
      //updating the values
          float value2 = value/3;
          wallValue[index] = sin(value2);
          if(wallValue[wall.slats.length-index-1]<0.5 && sin(value2+1) >0.5){
          wallValue[wall.slats.length-index-1] = wallValue[wall.slats.length-index-1]+sin(value2+1);            
          }else{
          wallValue[wall.slats.length-index-1] = wallValue[wall.slats.length-index-1]-sin(value2+1);              
          }

          
          value++;
    }
    
     value =0;
    for (int index = counter; index > counter-range && index >=0; index--) {
      //updating the values
          float value2 = value/3;
          wallValue[index] = sin(value2);
                    if(wallValue[wall.slats.length-index-1]<0.5 && sin(value2+1) >0.5){
          wallValue[wall.slats.length-index-1] = wallValue[wall.slats.length-index-1]+sin(value2+1);            
          }else{
          wallValue[wall.slats.length-index-1] = wallValue[wall.slats.length-index-1]-sin(value2+1);              
          }
          value++;
    }
    

    
    
    for (DWSlat slat : wall.slats) {
       
      for (int index = 0; index < wall.slats.length; index++) {
          
            slat = wall.slats[index];
            slat.setBottom(wallValue[index]);
            slat.setTop(wallValue[index]);
      }
      
     }
    

          counter++;

  }

  // Leave this function blank
  void exit() {
  }
  
  // You can ignore everything from here.
  String getBehaviorName() {
    return behaviorName;
  }
  
  String getAuthorName() {
    return author;
  }
  
  String getDescription() {
    return description;
  }
  


}
