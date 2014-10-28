class spirograph {

  int NUMSINES = 20; // how many of these things can we do at once?
  float[] sines = new float[NUMSINES]; // an array to hold all the current angles
  int i; // a counter variable

  // play with these to get a sense of what's going on:
  float fund = 0.01; // the speed of the central sine
  float ratio = 1.; // what multiplier for speed is each additional sine?
  int alpha = 50; // how opaque is the tracing system
  int mainCol = 255;
  int subCol = 0;
  int subCol2 = 0;
  float startingPointx, startingPointy;
  float note;
  float spiroRad;


  boolean trace = false; // are we tracing?

  spirograph(float x, float y, float rad)
  {
    startingPointx = x;
    startingPointy = y;
    spiroRad = rad; // compute radius for central circle
    for (int i = 0; i<sines.length; i++)
    {
      sines[i] = PI; // start EVERYBODY facing NORTH
    }
  }

  void drawSpirograph()
  {
    //if (!trace) background(255); // clear screen if showing geometry
    if (!trace) {
      fill(255, 10);
      rect(0, 0, width - 1, height - 1);
    }
    if (!trace) {
      stroke(0, 255); // black pen
      noFill(); // don't fill
    }  

    // MAIN ACTION
    pushMatrix(); // start a transformation matrix
    translate(startingPointx, startingPointy); // move to middle of screen

    for (i = 0; i<sines.length; i++) // go through all the sines
    {
      float erad = 0; // radius for small "point" within circle... this is the 'pen' when tracing
      // setup tracing
      if (trace) {
        stroke(subCol, subCol2, mainCol*(float(i)/sines.length), alpha); // blue
        fill(subCol2, subCol, mainCol, alpha/2); // also, um, blue
        erad = 5.0*(1.0-float(i)/sines.length); // pen width will be related to which sine
      }
      float radius = spiroRad/(i+1); // radius for circle itself
      rotateZ(sines[i]); // rotate circle
      if (!trace) ellipse(0, 0, radius*2, radius*2); // if we're simulating, draw the sine
      pushMatrix(); // go up one level
      translate(0, radius); // move to sine edge
      if (!trace) ellipse(0, 0, 5, 5); // draw a little circle
      if (trace) ellipse(0, 0, erad, erad); // draw with erad if tracing
      popMatrix(); // go down one level
      translate(0, radius); // move into position for next sine
      sines[i] = (sines[i]+(fund+(fund*i*ratio))%TWO_PI); // update angle based on fundamental
      note = sines[i]*noise(0, 60);
    }
    popMatrix(); // pop down final transformation
  }

/*
  void activateRainbdow() {
    float split = width/12;
    if (x1 < split) {
      r = 255;
      g = 255;
      b = 255;
    }

    // orange
    if (x1 > split && x1 < split*2)
    {
      r = 255;
      g = random(51, 153);
      b = random(0, 51);
    }

    // yellow
    if (x1 > split*2 && x1 < split*3)
    {
      r = 255;
      g = 255;
      b = random(0, 102);
    }

    // green
    if (x1 > split*3 && x1 < split*4)
    {
      r = random(128, 153);
      g = 255;
      b = random(0, 51);
    }

    // green
    if (x1 > split*4 && x1 < split*5)
    {
      r = random(0, 51);
      g = 255;
      b = random(0, 51);
    }

    // aqua
    if (x1 > split*5 && x1 < split*6)
    {
      r = random(0, 51);
      g = 255;
      b = random(128, 153);
    }

    // light blue
    if (x1 > split*6 && x1 < split*7)
    {
      r = random(0, 51);
      g = 255;
      b = 255;
    }

    // blue
    if (x1 > split*7 && x1 < split*8)
    {
      r = random(0, 51);
      g = random(128, 153);
      b = random(128, 153);
    }

    // purple
    if (x1 > split*8 && x1 < split*9)
    {
      r = random(0, 51);
      g = random(0, 51);
      b = 255;
    }

    // pink
    if (x1 > split*9 && x1 < split*10)
    {
      r = random(127, 153);
      g = random(0, 51);
      b = 255;
    }

    // more pink
    if (x1 > split*10 && x1 < split*11)
    {
      r = 255;
      g = random(0, 51);
      b = 255;
    }

    // gray
    if (x1 > split*11 && x1 < split*12)
    {
      r = 255;
      g = random(0, 51);
      b = random(127, 153);
    }  
    if (x1 < split)
    {
      r = 255;
      g = 255;
      b = 255;
    }

    // orange
    if (x1 > split && x1 < split*2)
    {
      r = 255;
      g = random(51, 153);
      b = random(0, 51);
    }

    // yellow
    if (x1 > split*2 && x1 < split*3)
    {
      r = 255;
      g = 255;
      b = random(0, 102);
    }

    // green
    if (x1 > split*3 && x1 < split*4)
    {
      r = random(128, 153);
      g = 255;
      b = random(0, 51);
    }

    // green
    if (x1 > split*4 && x1 < split*5)
    {
      r = random(0, 51);
      g = 255;
      b = random(0, 51);
    }

    // aqua
    if (x1 > split*5 && x1 < split*6)
    {
      r = random(0, 51);
      g = 255;
      b = random(128, 153);
    }

    // light blue
    if (x1 > split*6 && x1 < split*7)
    {
      r = random(0, 51);
      g = 255;
      b = 255;
    }

    // blue
    if (x1 > split*7 && x1 < split*8)
    {
      r = random(0, 51);
      g = random(128, 153);
      b = random(128, 153);
    }

    // purple
    if (x1 > split*8 && x1 < split*9)
    {
      r = random(0, 51);
      g = random(0, 51);
      b = 255;
    }

    // pink
    if (x1 > split*9 && x1 < split*10)
    {
      r = random(127, 153);
      g = random(0, 51);
      b = 255;
    }

    // more pink
    if (x1 > split*10 && x1 < split*11)
    {
      r = 255;
      g = random(0, 51);
      b = 255;
    }

    // gray
    if (x1 > split*11 && x1 < split*12)
    {
      r = 255;
      g = random(0, 51);
      b = random(127, 153);
    }
  }*/
}

