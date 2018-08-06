public static class Animation extends WallAnimation {


  // First, we add metadata to be used in the MoMath system. Change these
  // strings for your behavior.
  String behaviorName = "Dynamic Wave Collision";
  String author = "MoMath";
  String description = "Customizable Wave Collisions";


  // Now we initialize a few helpful global variables.
  boolean debug = false;
 
  int wallLength = 128;
  int counter = 0;
  int totalCounter = 0;
  int animateDirection = 1;
  int animateNum = 0;
  
  //LEFT WAVE 
  int rangeL = 40;
  float phaseSliceL = TWO_PI;
  float shiftL = 0;
  float ampL = 1;
  float shiftAmpL = 0;
  float freqL = 1;
  boolean dampenL = false;
  float dampL = 80;
  
  //RIGHT WAVE
  int rangeR = 40;
  float phaseSliceR = TWO_PI;
  float shiftR = 0;
  float ampR = 1;
  float shiftAmpR = 0;
  float freqR = 1;
  boolean dampenR = false;
  float dampR = 80;
  
  /*
  If continual is true, then the left and right waves will continue moving
  and interacting as if each wave was actually defined for infinite slabs and
  repeated with period 128.
  If continual is false, the left and right wave interact once per iteration
  */
  boolean continual = true;
  
  /////////////////////
  //EXAMPLE PRE-SETS///
  /////////////////////
  /* The default values right now display 2 full phase sine waves interacting
  continually (see definition for the "continual" variable below) with phase
  length of 40 slabs, freq 1. Set one (and only one) of the below booleans to true
  to see some examples of what can be shown. The user can customize every aspect.
  */
  
  //Standing wave: two sine waves, one whose phase is shifted by PI
  //travelling in opposite directions and creating a standing wave
  boolean standingWave = true;
  
  //dynamic standing wave: changes the wavelength of the standing wave
  boolean animatedStandingWave = true;
  
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
    
    //SET VALUES FOR THE PRE-SET CHOSEN ABOVE
    if(standingWave || animatedStandingWave){
      continual = true; rangeL = 128; freqL = 1; rangeR = 128; freqR = 1;
    }
    if(phaseShiftedDefault){
      shiftL = PI/2.0;
    }
    if(basicSingleWave){
     ampR = 0; ampL = 2; rangeL = 30;
    }
    if(dampenedWave){
      ampR = 0; ampL = 2; rangeL = 80; freqL = 4; dampenL = true;  dampL = 80;
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
  

  //Determines value of the wave at slab numbered index, the arguments do as described above
  float makeWave(int index, float ampF, float freqF, float phaseSliceF,
                 int rangeF, float shiftF, float shiftAmpF, boolean dampenF, float dampF){
    float val =  ampF*0.25*sin(freqF*(phaseSliceF/rangeF)*(index-counter)+shiftF)+0.25+shiftAmpF;
    if(dampenF){
      val = (1.0/exp(index/dampF))*val;
    }
    if(dampenF && continual){
      val = (1.0/exp(totalCounter/dampF))*val;
    }
    return val;
  }
  
  float leftWaveVal(int index){
    return makeWave(index, ampL, freqL, phaseSliceL, rangeL, shiftL, shiftAmpL, dampenL, dampL);
  }
  
  float rightWaveVal(int index){
    return makeWave(index, ampR, freqR, phaseSliceR, rangeR, shiftR, shiftAmpR, dampenR, dampR);
  }
  
  //Allow a right wave to continue on the left after passing slab 0
  int zeroBasedMod(int index){
    int newIndex = index;
    if(index < 0){
      newIndex += wallLength;
    }
    return newIndex;
  }
  
  // The update block will be repeated for each frame. This is where the
  // action should be programmed.
  void update() {
    if(counter == wallLength-1){
        counter = 0;
    }
    if(animatedStandingWave){
        if( (totalCounter % 64) == 0){
          if(animateNum == 6){
             animateDirection = -1; 
          }
          if(animateNum == -6){
             animateDirection = 1; 
          }
          if(animateDirection == 1){
            freqL += 1;
            freqR += 1;
            animateNum += 1;
          }else{
            freqL -= 1;
            freqR -= 1;   
            animateNum -= 1;
          }
        }
    }
   
    //Set the array for the right and left waves
    if(!continual){
      for (int index = counter; index < counter+rangeL && index < wall.slats.length; index++) {
          leftWave[index] = leftWaveVal(index);
      }
    
      for (int index = counter; index < counter+rangeR && index < wall.slats.length; index++) {
         rightWave[wallLength - index - 1] =  rightWaveVal(index);
      }
    }else{
      for (int index = counter; index < counter+rangeL; index++) {
         leftWave[index % 128] = leftWaveVal(index);
      }
      for (int index = counter; index < counter+rangeR; index++) {
         rightWave[(zeroBasedMod(wallLength - index - 1))] = rightWaveVal(index);
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
    totalCounter++;
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