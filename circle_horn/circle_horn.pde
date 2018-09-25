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
void settings()
{
	//needed if image size given by parameters
	width = w; 
	height = h;
}
void setup()
{
	//all those statements to be executed only once
	background(255);

	d = -r;
	drawCircle();
}
//_____________________________________________________
//LOOPING
void draw()
{
	//background(255);
}

void drawCircle(){
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
