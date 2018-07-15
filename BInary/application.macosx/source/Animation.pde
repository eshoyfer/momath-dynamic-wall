public static class Animation extends WallAnimation {

  
  // First, we add metadata to be used in the MoMath system. Change these
  // strings for your behavior.
  String behaviorName = "Binary Wall Behavior";
  String author = "Jeffrey Zhang";
  String description = "Binary Counting Time.";


  // Now we initialize a few helpful global variables.
  boolean forward = true;
  float step = 0.0003;
  float loc = 0;

  // Number of wall slats
  int wallLength = 128;
  int counter;
  int delay;
  
  // The setup block runs at the beginning of the animation. You could
  // also use this function to initialize variables, load data, etc.
  void setup() {
    for (DWSlat slat: wall.slats){
      slat.setBottom(0);
      slat.setTop(0);
    }
    counter = 0;
    delay = 100;
  }		 
  
  static int[] charToInt(char[] arr){
    int[] intArr = new int[arr.length];
    for (int i = 0; i< arr.length; i++){
      intArr[i] = Character.getNumericValue(arr[i]);
    }
    return intArr;
  }
  
  static int[] convertToBinary(int no){
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
  void update() {
    
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
