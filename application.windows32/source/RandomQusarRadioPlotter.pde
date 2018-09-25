import processing.pdf.*;

int xloop = 30; // How many curve points there are (the higher - the more peaks and spaghetti there will be)
int yLoop = 45; // Number of lines. The lower, the further apart they are.

float stepped = 0; // x coordinate for each curve point 
float yStepped = 0; // y coordinate for each curve point

float distro(float x, float mid) // distributes higher peaks towards the center (x is the point coordinate, mid is the middle of the screen)
{
  float clamp = 50;
  float diff = abs(mid - x);
  float y = random(1750)/(diff);
  
  if(y >= clamp)
    y = random(80);
  
  return -y;
}


void display()
{
  beginRecord(PDF, "dataVis.pdf");
  
  background(0);
  strokeWeight(2);
  stroke(255);

  
  float step = float(width / xloop); // finds how far apart on the x axis curve points should be to be spread evenly
  float yStep = height / yLoop; // finds how far apart the *first curve points* should be sto be spread evenly
  
  yStepped = 0;

  yStepped += yStep * 5; // gives a bit of margin from the top
  
  for(int i = 0; i < yLoop-10; i++) // yLoop - 10 due to the margin above. Additional 5 to give margin from the bottom. Essentially twice as big as the margin above.
  {
    //stroke(random(255), 150, 255); // Add colour if you want
    //println("x step size: " + step);
    stepped = 0;
    fill(0, 255);
    beginShape();
    
    curveVertex(stepped, yStepped);
    curveVertex(stepped, yStepped); // You need two points on the same coordinates at the start and the end of the shape.
    
    stepped += step;
    curveVertex(stepped, yStepped); // Just to make the endings smoother, there are two additional spots on the relative (to the stepped line) 0y.
    stepped += step;
    curveVertex(stepped, yStepped);
    stepped += step;
    
    
    for (int o = 0; o < xloop-4; o++) // Due to the additional 4 steps added at the start and the end, 4 have to be removed in the loop.
    {
      curveVertex(stepped, yStepped+distro(stepped, random(width / 3) + width/3)); // random(width / 3) adds a bit of x offset on each line, + width/3 keeps it at the center.
      stepped += step;
      //println(stepped);
    }
    
    
    curveVertex(stepped, yStepped);
    stepped += step;
    curveVertex(stepped, yStepped);
    stepped += step;
    curveVertex(stepped, yStepped);
    curveVertex(stepped, yStepped);
    //println(stepped);
    
    
    yStepped += yStep;
    endShape();
  }
}

void setup()
{
  size(700, 900);


  display();

}

void draw()
{
}

void keyPressed()
{
  if (key == DELETE)
    display();
  else if (key == ENTER)
  {
    endRecord();
  }
}
