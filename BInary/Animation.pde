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
  Integer counter;
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
  
  static ArrayList<Integer> convertToBinary(Integer no){
    ArrayList<Integer> container = new ArrayList<Integer>();
    while (no > 0){
        container.add(no%2);
        no = no/2;
    }
    return container;
   }
   
   public ArrayList<Integer> reverse(ArrayList<Integer> list) {
    if(list.size() > 1) {                   
        Integer value = list.remove(0);
        reverse(list);
        list.add(value);
    }
    return list;
   }

    
  // The update block will be repeated for each frame. This is where the
  // action should be programmed.
  void update() {
    
    ArrayList<Integer> binary = reverse(convertToBinary(counter));
    System.out.println("counter: " + counter);
    //int dec = 1;
    for (int i = binary.size()-1; i>=0;i--){
          
      for (int j =4; j> 0; j--){
        DWSlat slat = wall.slats[wallLength-1];
        slat.setBottom(binary.get(i));
        slat.setTop(binary.get(i));

        wallLength--;
      }   
    }
    counter++;
    wallLength = 128;
  
  }
  //  for (int i = binary.size()-1; i>=0;i--){
  //    DWSlat slat = wall.slats[wallLength-1];
  //    System.out.println("wallLength: " + wallLength);
      
  //    slat.setBottom(binary.get(i));
  //    slat.setTop(binary.get(i));
  //    wallLength--;
  //  }
  //  counter++;
  //  wallLength = 128;
  
  //}
  

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
