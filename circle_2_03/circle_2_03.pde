/*___________________________________________________
 //CIRCLE
 //
 //A Flocksystem, where every dot is fighting for the best position on a circle
 //Combined with a perlin-noise distorted circle
 //
 //
 //Felix Wagner - 17/07/18
 __________________________________________________*/
//GLOBAL PARAMETERS
//all global parameters with values & comments, e.g.
int w = 900; 
int h = 900;
int sect = 1200; //controlls the segments of the circle - more = stronger disturbance
DotSystem system;
Flock flock;
int range = 70;
float seperation = 30;
int cRadius = 400;
float n = 0;
float nfAng = 0.01;
float nfTime = 0.005;
ArrayList<Dot> dots;
ArrayList<Mover>movers;
ArrayList<PVector>vertecies;

float maxspeed = 3.5;
float maxforce = 0.6;

boolean bg = true;

//____________________________________________________
//SETTING UP
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
	system = new DotSystem();
	flock = new Flock();
  
  	for (int i = 0; i < sect; i++) {
  		float q = map(i, 0, sect, 0, 360);
  		float theta = q * PI/180;
  		Dot newDot = new Dot(cRadius, theta);
  		system.addDot(newDot);
  		flock.addMover(new Mover(newDot.position));
	  	/*
		angle × π / 180° = theta
	  	*/
	}
}
//_____________________________________________________
//LOOPING
void draw()
{	
	if(bg == true){
		background(0,0,100);
	}
	for(int i = 0; i < dots.size(); i++){
			Dot d = dots.get(i);
			Mover m = movers.get(i);
			d.move(map(noise(i*nfAng, frameCount*nfTime),0,1,cRadius-range,cRadius+range));
			m.updateAncor(d.position);
		}
	vertecies = new ArrayList<PVector>();
	flock.run();
	system.run();
	drawMovers(2);
}
//______________________________________________________
//FUNCTIONS
//your functions for better structuring
//functions for event handling


void drawMovers(int i){

	if(i == 1){
		pushMatrix();
		translate(width/2,height/2);
		fill(0,0,0);
		beginShape(POINTS);
		for(PVector v : vertecies){
	    	vertex(v.x, v.y);
		}
		endShape();
		popMatrix();
	}

	if(i==2){
		pushMatrix();
		translate(width/2, height/2);
		fill(0,0,0);
		noStroke();
		for(PVector v : vertecies){
	  		ellipse(v.x,v.y,2,2);
		}
		popMatrix();
	}

	if(i==3){
		pushMatrix();
		translate(width/2,height/2);
		stroke(50);
		strokeWeight(2);
		noFill();
		beginShape();
		for(PVector v : vertecies){
	    	vertex(v.x, v.y);
		}
		endShape();
		popMatrix();
	}
}

class DotSystem{
	PShape s;

	DotSystem(){
		dots = new ArrayList<Dot>();
	}

	void addDot(Dot d){
		dots.add(d);
	}

	void updateDots(){
		for(Dot d : dots){
			d.run();
		}
	}

	void display(){
		//noFill();
		strokeWeight(1);
		stroke(0,0,0);
		s = createShape();
		s.beginShape();
		pushMatrix();
		translate(width/2,height/2);
		for(Dot d : dots){
			s.vertex(d.position.x,d.position.y);
		}
		s.vertex(dots.get(0).position.x,dots.get(0).position.y);
		s.endShape();
		shape(s);
		popMatrix();
	}

	void run(){
		updateDots();
		//display();
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
		fill(0,0,0);
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

class Flock{
	Flock(){
		movers = new ArrayList<Mover>(); //An Arraylist for all boids
	}

	void run(){
		for(Mover m : movers){
			m.run(movers);
		}
	}

	void addMover(Mover m){
		movers.add(m);
	}

	void removeMover(int i){
		movers.remove(i);
	}
}

class Mover{
	PVector position;
	PVector velocity;
	PVector acceleration;
	PVector ancor;
	float mass;
	ArrayList<Mover> neighboors;
	int size;

	Mover(PVector anc){
		size = 2;
		mass = 1;
		position = new PVector(0,0);
		velocity = new PVector(maxspeed,0);
		acceleration = new PVector(0,0);
		ancor = anc;
	}

	public void run(ArrayList<Mover> movers){
		flock(movers);
		update();
		//display();
		export();
	}

	void flock(ArrayList<Mover> mover){
		PVector sep = separate(movers);
		PVector target = arrive(ancor);

		applyForce(target);
		applyForce(sep);
	}

	public void updateAncor(PVector anc){
		ancor = anc;
	}

	void update(){
	  velocity.add(acceleration);
	  position.add(velocity);
	  velocity.limit(maxspeed);
	  acceleration.mult(0);
	}

	PVector seek(PVector target){
	  PVector desired = PVector.sub(target, position);
	  desired.setMag(maxspeed);
	  PVector steer = PVector.sub(desired,velocity);
	  steer.limit(maxforce);
	  return steer;
	}

	PVector arrive(PVector ancor){
	  PVector target = ancor;
	  PVector desired = PVector.sub(target,position);
	  float d = desired.mag();
	  
	  if(d < 100){
	    float m = map(d,0,100,0,maxspeed);
	    desired.setMag(m);
	  } else{
	    desired.setMag(maxspeed);
	  }
	  // Steering = Desired minus Velocity
	    PVector steer = PVector.sub(desired,velocity);
	    steer.limit(maxforce);  // Limit to maximum steering force
	    return steer;
	}

	PVector separate (ArrayList<Mover> movers) {
    float desiredseparation = seperation;
    PVector steer = new PVector(0,0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Mover other : movers) {
      float d = PVector.dist(position,other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position,other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }

	void applyForce(PVector force){
	  PVector f = PVector.div(force,mass);
	  acceleration.add(f);
	}

	void display(){
		pushMatrix();
		translate(width/2, height/2);
		fill(0,0,0);
		noStroke();
		ellipse(position.x,position.y,size,size);
		popMatrix();
	}

	void export(){
		vertecies.add(new PVector(position.x, position.y));
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
  	saveFrame("output/circle_3_####.png");
  }
}


