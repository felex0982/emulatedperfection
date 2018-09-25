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

float n1 = 0.3;
float n2 = 0.4;
float n3 = 2;
float m = 0;
float a = 1;
float b = 1;
float radius = 200;
float oscM = 0;
float oscN1 = 1;
float oscN2 = 1;
float oscN3 = 1;

boolean bg = true;


void settings()
{
	//needed if image size given by parameters
	//width = w; 
	//height = h;
	fullScreen();
}

void setup()
{	
	//all those statements to be executed only once
	colorMode(HSB, 360, 100, 100);
	background(0,0,100);

}
//_____________________________________________________
//LOOPING
void draw()
{
	if(bg == true){
		background(0,0,100);
	}

	m = map(sin(oscM), -1, 1, 2, 15);
	oscM += 0.02;

	n1 = map(sin(oscN1), -1, 1, 2, 10);
	oscN1 += 0.04;

	n2 = map(sin(oscN2), -1, 1, 2, 12);
	oscN2 += 0.01;

	n3 = map(sin(oscN3), -1, 1, 2, 5);
	oscN3 += 0.02;

	
	int resolution = 300;
	float increment = TWO_PI / resolution;

	pushMatrix();
	translate(width/2, height/2);
	noFill();
	stroke(0,0,0, 50);
	beginShape();
	for(float angle = 0; angle < TWO_PI; angle += increment){
		float r = supershape(angle);
		float x = radius * r * cos(angle);
		float y = radius * r * sin(angle);

		vertex(x, y);

	}
	endShape(CLOSE);
	popMatrix();
}

//_____________________________________________________
//FUNCTIONS

int sgn(float val){
	if(val > 0){
		return 1;
	} else if (val < 0){
		return -1;
	} else{
		return 0;
	}
}

float supershape(float theta){
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