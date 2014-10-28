// SPIROGRAPH
// http://en.wikipedia.org/wiki/Spirograph
// also (for inspiration):
// http://ensign.editme.com/t43dances
//
// this processing sketch uses simple OpenGL transformations to create a
// Spirograph-like effect with interlocking circles (called sines).  
// press the spacebar to switch between tracing and
// showing the underlying geometry.
//
// your tasks:
// (1) tweak the code to change the simulation so that it draws something you like.
// hint: you can change the underlying system, the way it gets traced when you hit the space bar,
// or both.  try to change *both*.  :)
// (2) use minim to make the simulation MAKE SOUND.  the full minim docs are here:
// http://code.compartmental.net/minim/
// hint: the website for the docs has three sections (core, ugens, analysis)... look at all three
// another hint: minim isn't super efficient with a large number of things playing at once.
// see if there's a simple way to get an effective sound, or limit the number of shapes
// you're working with.

spirograph spiro1, spiro2, spiro3, spiro4, spiro5;
float rad; // an initial radius value for the central sine

import ddf.minim.*; // this loads the minim library
import ddf.minim.ugens.*; // this loads more stuff out of the minim library

Minim minim; // this is the audio engine
AudioOutput out; // this represents the output (speakers)
Oscil wave1, wave2; // this is an oscillator


void setup()
{
  size(800, 600, P3D); // OpenGL mode
  //spiro

  rad = 100; // compute radius for central circle
  
  /*
  background(255); // clear the screen
   spiro1 = new spirograph(random(100, width-100), random(100, height-100), random(height/5, height/4.));
   spiro2 = new spirograph(random(100, width-100), random(100, height-100), random(height/5, height/4.));
   spiro3 = new spirograph(random(100, width-100), random(100, height-100), random(height/5, height/4.));
   spiro4 = new spirograph(random(100, width-100), random(100, height-100), random(height/5, height/4.));
   //spiro5 = new spirograph(width/2, height/2);
   print(height/4);
   */
   
  // flower setup

  spiro1 = new spirograph(width/2, height/2, rad);
  spiro2 = new spirograph(width/2-100, height/2, rad);
  spiro3 = new spirograph(width/2, height/2-100, rad);
  spiro4 = new spirograph(width/2+100, height/2, rad);
  spiro5 = new spirograph(width/2, height/2+100, rad);

  // initialize the minim and out objects
  minim = new Minim(this); // start the audio engine
  out   = minim.getLineOut(); // sets the output to your laptop output

    wave1 = new Oscil( 440., 0.3, Waves.SINE ); // this sets up the oscillator
  wave2 = new Oscil( 440., 0.3, Waves.SINE ); // this sets up the oscillator
  wave1.patch( out ); // this plugs into the speakers
  wave2.patch( out ); // this plugs into the speakers
}

void draw()
{
  spiro1.drawSpirograph();
  spiro2.drawSpirograph();
  spiro3.drawSpirograph();
  spiro4.drawSpirograph();
  spiro5.drawSpirograph();

  wave1.setFrequency(mtof(int(spiro1.note)));
  wave2.setFrequency(mtof(int(spiro2.note*2.)));
}


void keyReleased()
{
  if (key==' ') {
    spiro1.trace = !(spiro1.trace); 
    spiro2.trace = !(spiro2.trace); 
    spiro3.trace = !(spiro3.trace); 
    spiro4.trace = !(spiro4.trace); 
    spiro5.trace = !(spiro5.trace); 
    background(255);
  }

  if  (key=='c') {
    spiro1.mainCol = int(random(0, 255));
    spiro2.mainCol = int(random(0, 255));
    spiro3.mainCol = int(random(0, 255));
    spiro4.mainCol = int(random(0, 255));
    spiro5.mainCol = int(random(0, 255));
    spiro1.subCol = int(random(0, 255));
    spiro2.subCol = int(random(0, 255));
    spiro3.subCol = int(random(0, 255));
    spiro4.subCol = int(random(0, 255));    
    spiro5.subCol = int(random(0, 255));    
    spiro1.subCol2 = int(random(0, 255));
    spiro2.subCol2 = int(random(0, 255));
    spiro3.subCol2 = int(random(0, 255));
    spiro4.subCol2 = int(random(0, 255));
    spiro5.subCol2 = int(random(0, 255));
  }

  if (key=='f') {
    spiro1.fund = random(0.005, 0.015);
    spiro2.fund = random(0.005, 0.015);
    spiro3.fund = random(0.005, 0.015);
    spiro4.fund = random(0.005, 0.015);
    spiro5.fund = random(0.005, 0.015);
  }

  if (key=='r') {
    spiro1.ratio = random(.5, 1.5);
    spiro2.ratio = random(.5, 1.5);
    spiro3.ratio = random(.5, 1.5);
    spiro4.ratio = random(.5, 1.5);
    spiro5.ratio = random(.5, 1.5);
  }

  if (key=='a') {
    spiro1.alpha = int(random(10, 50));
    spiro2.alpha = int(random(10, 50));
    spiro3.alpha = int(random(10, 50));
    spiro4.alpha = int(random(10, 50));
    spiro5.alpha = int(random(10, 50));
  }
}

float mtof(int note) // mtof
{
  return (440. * exp(0.057762265 * (note - 69.)));
}

/*
  if (key=='c') {
 mainCol = int(random(0, 255));
 subCol = int(random(0, 255));
 subCol2 = int(random(0, 255));
 }
 if (key=='s') {
 fund = random(0.0001, 0.05);
 } 
 if (key=='r')  {
 ratio = random(.1, 2);
 }
 if (key=='a') {
 alpha = int(random(0, 255));
 }
 
 
 }
 */
