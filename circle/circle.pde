/*___________________________________________________
 //CIRCLE
 
 //A particle system alignd to a circle is reacting to
 //distrubances caused by perlin-noise
 //
 //
 //
 //Minimal Aestetic Disturbance
 //Walter Benjamin
 // Lagrange Interpolation
 //
 //Felix Wagner - 20/06/18
 __________________________________________________*/
//GLOBAL PARAMETERS
//all global parameters with values & comments, e.g.
int w = 900; 
int h = 900;
int sect = 900;
DotSystem system;
int range = 50;
int cRadius = w/4;
float n = 0;
float nfAng = 0.01;
float nfTime = 0.005;
ArrayList<Dot> dots;

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
	colorMode(HSB, 360, 100, 100);
	background(0,0,100);
	noFill();
	system = new DotSystem();
  
  	for (int i = 0; i < sect; i++) {
  		float q = map(i, 0, sect, 0, 180);
  		float theta = q * PI/180;
  		system.addDot(new Dot(cRadius, theta));

	  	/*
		angle × π / 180° = theta
	  	*/
  }
}
//_____________________________________________________
//LOOPING
void draw()
{
	//background(0,0,100);
	for(int i = 0; i < dots.size(); i++){
			Dot d = dots.get(i);
			d.move(map(noise(i*nfAng, frameCount*nfTime),0,1,cRadius-range,cRadius+range));
		}
	system.run();
}
//______________________________________________________
//FUNCTIONS
//your functions for better structuring
//functions for event handling

class DotSystem{
	PShape s;

	DotSystem(){
		dots = new ArrayList<Dot>();
	}

	void addDot(Dot d){
		dots.add(d);
	}

	void display(){
		s = createShape();
		s.setStroke(color(0,0,0,10));
		s.beginShape();
		pushMatrix();
		translate(width/2,height/2);
		for(Dot d : dots){
			d.run();
			s.vertex(d.position.x,d.position.y);
		}
		for(int i = dots.size()-1; i >= 0; i--){
			Dot d = dots.get(i);
			s.vertex(d.position.x,d.position.y*(-1));
		}
		s.endShape();
		shape(s);
		popMatrix();
	}

	void run(){
		display();
	}
}

class Dot{
	PVector position;
	PVector change;
	float t; //theta
	float r; //radius

	Dot(int radius, float theta){
		r = radius;
		t = theta;
		position = new PVector(r*cos(t),r*sin(t));
		change = new PVector(0,1);
	}


	void display(){
		noFill();
		ellipse(position.x,position.y,5,5);	
	}

	void move(float noise){
		r = noise;
	}

	void run(){
		position.x = r*cos(t);
		position.y = r*sin(t);
		//display();
	}
}