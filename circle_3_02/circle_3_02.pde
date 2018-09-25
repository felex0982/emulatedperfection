/*___________________________________________________
 //CIRCLE
 
 // Using Lamé Curves to play with Circles
 //
 //
 //Felix Wagner - 05/08/18
 __________________________________________________*/
//GLOBAL PARAMETERS
//all global parameters with values & comments, e.g.

int w = 800;
int h = 800;
//int r = 200;
int a = 400;
int b = 400;
float n = 2;
float rotation = 2;
int dir = 1;
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

	pushMatrix();
	translate(width/2, height/2);
	rotate(rotation);
	noFill();
	stroke(0,0,0,30);
	beginShape();
	for(float angle = 0; angle < TWO_PI; angle += 0.1){
		//code for a circle
		//int x = int(r * cos(angle));
		//int y = int(r * sin(angle));

		// code for a superellipse
		float na = 2/n;
		int x = int(pow(abs(cos(angle)), na) * a * sgn(cos(angle)));
		int y = int(pow(abs(sin(angle)), na) * b * sgn(sin(angle)));

		vertex(x, y);

	}
	endShape(CLOSE);
	popMatrix();

	rotation += 0.01;

	if(n <= 4){
		if(dir == 1){
			n += 0.1;
		}
		if(dir == 0){
			n -= 0.1;
		}
	}
	if(n >= 4){
		dir = 0;
		n = 4;
	}
	if(n <= 1){
		dir = 1;
		n = 1;
	}
}

int sgn(float val){
	if(val > 0){
		return 1;
	} else if (val < 0){
		return -1;
	} else{
		return 0;
	}
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
  	saveFrame("output/circle_4_####.png");
  }
}