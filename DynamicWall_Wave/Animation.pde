public static class Animation extends WallAnimation {


  // First, we add metadata to be used in the MoMath system. Change these
  // strings for your behavior.
  String behaviorName = "Dynamic Wave Collision";
  String author = "MoMath";
  String description = "Customizable Wave Collisions";


  // Now we initialize a few helpful global variables.
  boolean forward = true;
  boolean debug = false;
  float step = 0.0003;
  float loc = 0;

  int wallLength = 128;
  int counter = 0;
  
  //LEFT WAVE 
  int rangeL = 20;
  float phaseSliceL = TWO_PI;
  float shiftL = 0;
  float ampL = 1;
  float shiftAmpL = 0;
  float freqL = 1;
  boolean dampenL = false;
  float dampL = 80;
  
  //RIGHT WAVE
  int rangeR = 20;
  float phaseSliceR = TWO_PI;
  float shiftR = 0;
  float ampR = 1;
  float shiftAmpR = 0;
  float freqR = 1;
  boolean dampenR = false;
  float dampR = 80;
  
  /////////////////////
  //EXAMPLE PRE-SETS///
  /////////////////////
  /* The default values right now display 2 full phase sine waves interacting
  with phase length of 20 slabs, freq 1. Set one of the below booleans to
  true to see some examples of what can be shown. The user can customize
  every aspect.*/
  
  //Shift phase of first wave by PI/2.
  boolean phaseShiftedDefault = false; 
  
  //Use only the left wave, increase amplitude by factor of 2\
  //We can do this since no more wave interaction occurs
  boolean basicSingleWave = false; 
  
  //Dampen a single wave with a phase length of 80 and frequency of 4
  boolean dampenedWave = false;
  
  //Two wave collision. Left wave: length 80, freq 4. Right wave: length 40, freq 1.
  boolean multiLeftSingleRight = false;
  
  //Two wave collision where the phases are wide enough so that the interaction
  //happens through most of the animation
  boolean widePhase = false;
  
  //Slice the phase in half to allow for even more visible amplitude (since only positive values now).
  boolean singleWaveHalfPhase = false;
  
  float[] leftWave = new float[wallLength];
  float[] rightWave = new float[wallLength];
  float[] wallValue = new float[wallLength];
  
  // The setup block runs at the beginning of the animation. You could
  // also use this function to initialize variables, load data, etc.
  void setup() {
    for (int index = 0; index < wall.slats.length; index++) {
          wallValue[index] = 0.25;
          rightWave[index] = 0.25;
          leftWave[index] = 0.25;
    }
    for (DWSlat slat : wall.slats) {
      slat.setBottom(0);
      slat.setTop(0);
    }
    //SET VALUES OF MODE CHOSEN ABOVE
    if(phaseShiftedDefault){
      shiftL = PI/2.0;
    }
    if(basicSingleWave){
     ampR = 0; ampL = 2; rangeL = 30;
    }
    if(dampenedWave){
      ampR = 0; ampL = 2; rangeL = 80; freqL = 4; dampenL = true; 
    }
    if(multiLeftSingleRight){
      rangeL = 80; freqL = 4; rangeR = 40; 
    }
    if(widePhase){
      rangeL = 50; freqL = 2; rangeR = 50; freqR = 2; 
    }
    if(singleWaveHalfPhase){
      ampR = 0; ampL = 2; rangeL = 30; phaseSliceL = PI; shiftAmpL = -0.5;
      for (int index = 0; index < wall.slats.length; index++) {
          wallValue[index] = 0.0;
          rightWave[index] = 0.0;
          leftWave[index] = 0.0;
      }
    }

  }		 

  // The update block will be repeated for each frame. This is where the
  // action should be programmed.
  void update() {
    if(counter == wallLength-1){
          counter = 0;
    }
   
    //Determine the values of the left and right waves
    for (int index = counter; index < counter+rangeL && index < wall.slats.length; index++) {
       leftWave[index] = ampL*0.25*sin(freqL*(phaseSliceL/rangeL)*(index-counter)+shiftL)+0.25+shiftAmpL;
       if(dampenL){
         leftWave[index] = (1.0/exp(index/dampL))*leftWave[index];
       }
    }
    
    for (int index = counter; index < counter+rangeR && index < wall.slats.length; index++) {
       rightWave[wallLength - index - 1] =  ampR*0.25*sin((phaseSliceR/rangeR)*(index-counter)+shiftR)+0.25+shiftAmpR;
       if(dampenR){
         rightWave[index] = (1.0/exp(index/dampR))*rightWave[index];
       }
    }
    
    //Make the waves interact
    for (int i = 0; i < wallLength; i++){
       wallValue[i] = rightWave[i] + leftWave[i];   
    }
  
    if(debug){
      String ret = "";
      for (int i = 0; i < wallLength; i++){
        ret += wallValue[i] + ", "; 
      }
      ret += "\n";
      System.out.println(ret);
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