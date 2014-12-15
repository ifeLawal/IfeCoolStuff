
// this is the junk the program needs to do the physics
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing e; // this is our world

float FRICTION = 0;

ArrayList<lukeBox> theboxes;
ArrayList<lukeWall> thewalls;


float posX, posY, wid, hei;
float vr, vg, vb, va;
lukeSideWall leftWall, rightWall, topWall, bottomWall;
lukeBall b;
//lukePlatform pl;


int i;

void setup()
{
  size(800, 600, OPENGL);

  // this sets up the box2d physics engine to deal with us
  e = new Box2DProcessing(this); // this creates the engine
  e.createWorld(); // this starts the engine
  e.setGravity(0, 0); // this is gravity (x, y)

  theboxes = new ArrayList<lukeBox>();
  thewalls = new ArrayList<lukeWall>();
  //pl = new lukePlatform(width/2, height/2+50, 30, 30);
  
  // TURN ON COLLISION DETECTION!
  e.listenForCollisions();

  wid = 50;
  hei = 30;
  vr = 255;
  vg = 0;
  vb = 255;
  va = 255;

  for (int a = 0; a < height/2; a+=hei)
  {
    for (int b = 0; b < width; b+=wid)
    {
      lukeWall w = new lukeWall(b, a, wid, hei, vr, vg, vb, va);
      thewalls.add(w);
    }
    vg += 30;
  }
  leftWall = new lukeSideWall(-10, 0, 0, height);
  rightWall = new lukeSideWall(width+10, 0, 1, height);
  topWall = new lukeSideWall(0, 0, width, 1);
  bottomWall = new lukeSideWall(0, height+5, width, 1);  

  b = new lukeBall(width/2, height-50, 20, 20);
}

void draw()
{
  background(0);
  e.step(); // advances the physics engine one frame

  leftWall.display();
  rightWall.display();
  topWall.display();
  bottomWall.display();
  //pl.display();

  for (int i = 0; i < theboxes.size (); i++)
  {
    theboxes.get(i).display();
  }

  for (lukeWall w : thewalls)
  {
    w.display();
  }

  b.display();
}

void keyPressed()
{
  /*
  if (key == 'd')
  {
    pl.moveRight = true;
    //pl.increaseRVelocity();
  }
  if (key == 'a') 
  {
    pl.moveLeft = true;
    //pl.increaseLVelocity();
  }
  //if (key == 'w') pl.moveUp();
  //if (key == 's') pl.moveDown();
  */
}

void keyReleased()
{
  /*
  pl.moveRight = false;
  pl.moveLeft = false;
  */
}

void mouseDragged()
{
  if (mouseY > height/2 + 20)
  {
    lukeBox temp = new lukeBox(mouseX, mouseY, random(5, 30), random(5, 30));
    theboxes.add(temp);
  }
}

// THIS HAPPENS WHEN THIS HIT EACH OTHER
void beginContact(Contact cp) {
  // Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  int wallhitsword = 0;
  if (o1.getClass() == lukeWall.class && o2.getClass() == lukeBall.class) wallhitsword = 1;
  if (o2.getClass() == lukeWall.class && o1.getClass() == lukeBall.class) wallhitsword = 2;

  if (wallhitsword==1)
  {
    lukeBall b = (lukeBall) o2;
    b.boink();
  } else if (wallhitsword==2)
  {
    lukeBall b = (lukeBall) o1;
    b.boink();
  }
}

// THIS HAPPENS WHEN THINGS STOP HITTING EACH OTHER
void endContact(Contact cp) {
}


