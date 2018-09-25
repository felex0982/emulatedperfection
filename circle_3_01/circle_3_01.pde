/*___________________________________________________
 //CIRCLE
 
 // Using Lamé Curves to play with Circles
 //
 //
 //Felix Wagner - 20/06/18
 __________________________________________________*/
//GLOBAL PARAMETERS
//all global parameters with values & comments, e.g.

int w = 600;
int h = 600;
int r = 200;
int a = 200;
int b = 200;
float n = 2;
float countA = 0;
float rotation = 2;
int dirN = 1;

void settings()
{
	//needed if image size given by parameters
	width = w; 
	height = h;
	//fullScreen();
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
	//background(0,0,100);

	pushMatrix();
	translate(width/2, height/2);
	rotate(rotation);
	noFill();
	stroke(0,0,0,10);
	beginShape();
	for(float angle = 0; angle < TWO_PI; angle += 0.01){
		//code for a circle
		//int x = int(r * cos(angle));
		//int y = int(r * sin(angle));

		// code for a superellipse
		float na = 2/n;
		int x = int(pow(abs(cos(angle)), na) * a * sgn(cos(angle)));
		int y = int(pow(abs(sin(angle)), na) * b * sgn(sin(angle)));

		if(angle == countA){
			stroke(0,0,0);
			ellipse(x,y,1,1);
		}

		stroke(0,0,0,10);
		//vertex(x, y);

	}
	endShape(CLOSE);
	popMatrix();

	rotation += 0.005;

	if(countA <= TWO_PI){
			countA += 0.01;
	}
	if(countA > TWO_PI ){
		countA = 0;
	}

	if(n <= 4){
		if(dirN == 1){
			n += 0.05;
		}
		if(dirN == 0){
			n -= 0.05;
		}
	}
	if(n >= 4){
		dirN = 0;
		n = 4;
	}
	if(n <= 1){
		dirN = 1;
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