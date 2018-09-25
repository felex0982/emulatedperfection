import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class circle_horn extends PApplet {

/*___________________________________________________
 //CIRCLE
 
//Draw a circle using Horn's Algorithm
 //
 //Felix Wagner - 31/08/18
 __________________________________________________*/
//GLOBAL PARAMETERS
//all global parameters with values & comments, e.g.

int w = 500;
int h = 500;
int r = 100;
int d;

//____________________________________________________
//SETTING UP
public void settings()
{
	//needed if image size given by parameters
	width = w; 
	height = h;
}
public void setup()
{
	//all those statements to be executed only once
	background(255);

	d = -r;
	drawCircle();
}
//_____________________________________________________
//LOOPING
public void draw()
{
	//background(255);
}

public void drawCircle(){
	pushMatrix();
	translate(width/2, height/2);
	int x = r;
	for(int y = 0; y < x; y++){
		noStroke();
		fill(0,100);
		ellipse(x, y, 2, 2);
		ellipse(y, x, 2, 2);
		ellipse(y, -x, 2, 2);
		ellipse(x, -y, 2, 2);
		ellipse(-x, -y, 2, 2);
		ellipse(-y, -x, 2, 2);
		ellipse(-y, x, 2, 2);
		ellipse(-x, y, 2, 2);
		d = d + 2 * y +1;
		if(d > 0){
			x = x -1;
			d = d - 2 * x;
		}
	}
	popMatrix();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "circle_horn" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
