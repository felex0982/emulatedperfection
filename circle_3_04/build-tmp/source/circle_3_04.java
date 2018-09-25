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

public class circle_3_04 extends PApplet {

/*___________________________________________________
 //CIRCLE
 
 // Using Supershapes to play with Circles
 //
 //
 //Felix Wagner - 20/06/18
 __________________________________________________*/
//GLOBAL PARAMETERS
//all global parameters with values & comments, e.g.

int w = 600;
int h = 600;

float n1 = 0.3f;
float n2 = 0.4f;
float n3 = 2;
float m = 0;
float a = 1;
float b = 1;
float radius = 300;
float oscM = 0;
float oscN1 = 1;
float oscN2 = 1;
float oscN3 = 1;
float rotation = 0;

boolean bg = true;


public void settings()
{
	//needed if image size given by parameters
	//width = w; 
	//height = h;
	fullScreen();
}

public void setup()
{	
	//all those statements to be executed only once
	colorMode(HSB, 360, 100, 100);
	background(0,0,100);

}
//_____________________________________________________
//LOOPING
public void draw()
{
	if(bg == true){
		background(0,0,100);
	}

	m = map(sin(oscM), -1, 1, 2, 7);
	oscM += 0.02f;

	n1 = map(sin(oscN1), -1, 1, 2, 7);
	oscN1 += 0.04f;

	n2 = map(sin(oscN2), -1, 1, -0.5f, 5);
	oscN2 += 0.01f;

	n3 = map(sin(oscN3), -1, 1, 2, 5);
	oscN3 += 0.02f;

	
	int resolution = 300;
	float increment = TWO_PI / resolution;

	pushMatrix();
	translate(width/2, height/2);
	rotate(rotation);
	noFill();
	stroke(0,0,0,40);
	beginShape();
	for(float angle = 0; angle < TWO_PI; angle += increment){
		float r = supershape(angle);
		float x = radius * r * cos(angle);
		float y = radius * r * sin(angle);

		vertex(x, y);

	}
	endShape(CLOSE);
	popMatrix();
	rotation += 0.03f;
}

//_____________________________________________________
//FUNCTIONS

public int sgn(float val){
	if(val > 0){
		return 1;
	} else if (val < 0){
		return -1;
	} else{
		return 0;
	}
}

public float supershape(float theta){
	//http://paulbourke.net/geometry/supershape/
	//equation to code by daniel shiffman
	float part1 = (1 / a) * cos(theta * m / 4);
	part1 = abs(part1);
	part1 = pow(part1, n2);

	float part2 = (1 / b) * sin(theta * m / 4);
	part2 = abs(part2);
	part2 = pow(part2, n3);

	float part3 = pow(part1 + part2, 1 / n1);

	if(part3 == 0){
		return 0;
	}

	return (1 / part3);
}

public void keyPressed() {
  if (key == 'b') {
  	if(bg == true){
  		bg = false;
  		println("background: OFF");
  	}
  	else{
  		bg = true;
  		println("background: ON");
  	}
  }
  if (key == 'p'){
  	saveFrame("output/circle_5_####.png");
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "circle_3_04" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
