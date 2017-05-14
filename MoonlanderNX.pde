//A Social Lantern Media Creation 2014
//sociallantern.weebly.com

import ddf.minim.*;
import apwidgets.*; 
//the following are all pieces we need to pull in from the android sdk
import android.media.SoundPool; //this is the audio player for short quick audio files
import android.content.res.AssetManager; //the asset manager helps us find specific files and can be used in the style of an array if needed
import android.media.AudioManager; //the audio manager controlls all the audio connected to it, enabeling overall volume and such


//moon lander code 
int landingX = 0;
int[] moon;
int scoretimer = 750;
int guess; 


int numFrames = 19;
int frame = 0;
PImage[] ship = new PImage[numFrames];

int numsFrames = 23;
int framef = 0;
PImage[] explosion = new PImage[numsFrames];

int numssFrames = 5;
int frameff = 0;
PImage[] dust = new PImage[numssFrames];

//PImage ship;
PImage panel;

PImage Title;
PImage tooltip;
PImage tooltip2;
PImage tooltip3;
PImage tooltip4;
boolean landed = false;
PImage winning;
PImage background;
PImage base;
PImage baselights;
PImage signs;
PImage pad;
PImage metoer;

PImage winning1;
PImage winning2;
PImage winning3;
PImage winning4;
PImage winning5;

//level state

int WAITING =1;
int RUNNING = 2;
int PART2 = 3;
int PART3 = 4; 
int FINISHED = 5;
int state = WAITING;

//floating alien

int alienx;
int alieny;
int alienxv;
int alienyv;

//speed planes
float a = 0;
float acc = 0;

PVector pos = new PVector( 525, 15 );  //position plot
PVector speed = new PVector( 0, 0 );    //speed vect
PVector g = new PVector( 0, 1.722 );    //gravity

APMediaPlayer sucess; 
APMediaPlayer boomth;
APMediaPlayer thrust;
APMediaPlayer electricity;
APMediaPlayer click;
APMediaPlayer intro;
APMediaPlayer soundtrack;
APMediaPlayer tilt;


void setup() {
  size(800, 600);

  orientation(LANDSCAPE);
  moon = new int[width/10+1];
  for ( int i=0; i < moon.length; i++) {

    moon[i] = int( random( 10 ));
  }
  landingX = int( random(10, moon.length-10))*10;

  //ship = loadImage( "ship.png" );
  Title = loadImage( "startpage.png" );
  tooltip =  loadImage( "tooltip.png" );
  tooltip2 =  loadImage( "tooltip2.png" );
  tooltip3 =  loadImage( "tooltip3.png" );
   tooltip4 =  loadImage( "tooltip4.png" );
  panel = loadImage("GUI.png");
  winning = loadImage("winning.png");

  winning1 = loadImage("winning1.png");
  winning2 = loadImage("winning2.png");
  winning3 = loadImage("winning3.png");
  winning4 = loadImage("winning4.png");
  winning5 = loadImage("winning5.png");

  background = loadImage("background.png");

  base = loadImage("base.png");
  baselights = loadImage("baselights.png");
  signs = loadImage("sign0000.png");
  pad = loadImage("pad0000.png");
  metoer = loadImage("metoer.png");
  
  sucess = new APMediaPlayer(this);
  sucess.setMediaFile("sucesss.mp3");
 boomth = new APMediaPlayer(this);
  boomth.setMediaFile("explode.mp3");
 thrust = new APMediaPlayer(this);
 thrust.setMediaFile("thrust.mp3");
click = new APMediaPlayer(this);
 click.setMediaFile("click.mp3");
 intro = new APMediaPlayer(this);
 intro.setMediaFile("intro.mp3");
  electricity = new APMediaPlayer(this);
 electricity.setMediaFile("electricity.mp3");
 soundtrack = new APMediaPlayer(this);
 soundtrack.setMediaFile("soundtrack.mp3");
  tilt = new APMediaPlayer(this);
 tilt.setMediaFile("tilt.mp3");




  reset();


  /// alien

  alienx=50;
  alieny=50;
  alienxv=5;
  alienyv=1;  

  //ship animation

  for (int s=0; s<numFrames; s++) {
    String ships = "ship" + nf(s, 4) + ".png";
    ship[s] = loadImage(ships);
  }

  //explosion animation

  for (int b=0; b<numsFrames; b++) {
    String booms = "explosion" + nf(b, 4) + ".png";
    explosion[b] = loadImage(booms);
  }


  //dust animation

  for (int d=0; d<numssFrames; d++) {
    String dusts = "land" + nf(d, 4) + ".png";
    dust[d] = loadImage(dusts);
  }
}
public void onResume() {
  super.onResume();
  
}
public void onPause() {
  
  super.onPause();
}

public void onDestroy() {





  super.onDestroy(); //call onDestroy on super class


  if (sucess!=null) { //must be checked because or else crash when return from landscape mode

    sucess.release(); //release the player
  }
  if (boomth!=null) { //must be checked because or else crash when return from landscape mode

    boomth.release(); //release the player
  }
  if (thrust!=null) { //must be checked because or else crash when return from landscape mode

   thrust.release(); //release the player
  }
  if (electricity!=null) { //must be checked because or else crash when return from landscape mode

    electricity.release(); //release the player
  }
   if (click!=null) { //must be checked because or else crash when return from landscape mode

    click.release(); //release the player
  }
   if (intro!=null) { //must be checked because or else crash when return from landscape mode

   intro.release(); //release the player
  }
   if (soundtrack!=null) { //must be checked because or else crash when return from landscape mode

    soundtrack.release(); //release the player
  }
   if (tilt!=null) { //must be checked because or else crash when return from landscape mode

    tilt.release(); //release the player
  }
}




void reset() {

  moon = new int[width/10+1];
  for ( int i=0; i < moon.length; i++) {
    moon[i] = int(random(10));
  }
  landingX = int( random(6, moon.length-5))*10;
  pos = new PVector( 525, 30 );
  a = 0;
  landed=false;
  acc = 0;
  scoretimer = 750; 
  speed = new PVector(0, 0);
}

void draw() {

 //background(background);
  scoretimer --; 
  frame = (frame+1)%numFrames;
  framef = (framef+1)%numsFrames;
  frameff = (frameff+1)%numssFrames;
  move();



  drawMoon();
  drawLandingZone();

  image(panel, 0, 0);



  if ( state == WAITING ) {
    drawWaiting();
  }
  else if ( state == RUNNING ) {
    // image(baselights,landingX-200, height - 285);
    // boomth.seekTo(0);
   //  boomth.start();
     soundtrack.setLooping(false); 
     soundtrack.seekTo(0);     
     soundtrack.start();
    drawShip();
    update(); //updates frame
  }
  else if ( state == FINISHED ) {
    // boomth.seekTo(0);
   //  boomth.start();
   soundtrack.setLooping(true); 
     soundtrack.seekTo(0);   
    drawFinished();

    if (landed == true) {
      image(baselights, landingX-200, height - 275);
      image(base, landingX-200, height - 275); 


      drawShip();
    }
  }
}


void drawWaiting() {
  textAlign( CENTER );
  fill(0);
  //intro.setLooping(false);
  //intro.seekTo(0); 
  intro.start();
  
  image( Title, 0, 0);
   //intro.seekTo(0);
   
}

void drawFinished() {
  textAlign( CENTER );
  fill( 0 );
  if ( pos.x > landingX - 40 && pos.x < landingX + 40 && a == 0) {
    //image(baselights,landingX-200, height - 285);
    //text( "you landed the ship!", width/2, height/2);
    landed = true; 
    // sucess.seekTo(0);
     sucess.start();

    if (landed == true && scoretimer >500) {

      image(baselights, landingX-200, height - 275);
      // sucess.seekTo(0);
     sucess.start();
      image( winning5, 0, -50);
     
      scoretimer ++;
    } 

    if (landed == true && scoretimer >400 && scoretimer < 500) {

      image(baselights, landingX-200, height - 275);
       sucess.seekTo(0);
     sucess.start();
      image( winning4, 0, -50);
      
      scoretimer ++;
    } 

    if (landed == true && scoretimer >300 && scoretimer < 400) {

      image(baselights, landingX-200, height - 275);
      // sucess.seekTo(0);
     sucess.start();
      image( winning3, 0, -50);
      
      scoretimer ++;
    } 

    if (landed == true && scoretimer > 200 && scoretimer < 300) {

      image(baselights, landingX-200, height - 275);
      image( winning2, 0, -50);
      // sucess.seekTo(0);
     sucess.start();
      scoretimer ++;
    }

    if (landed == true && scoretimer >100 && scoretimer < 200) {

      image(baselights, landingX-200, height - 275);
      //  sucess.seekTo(0);
     sucess.start();
      image( winning1, 0, -50);
     
      scoretimer ++;
    }  

    if (landed == true && scoretimer <100) {

      image(baselights, landingX-200, height - 275);
       //sucess.seekTo(0);
     sucess.start();
      image( winning, 0, -50);
      
      scoretimer ++;
    }
  } 
  else {
    fill(255);
    // text( "you missed the platform!", width/2, height/2);
    //image( playagain, 110, CENTER+80);

boomth.seekTo(0);
boomth.start();

    guess = int (random(0, 3)); 


    if (guess == 0) { 
    
      image( tooltip, 0, 0);
     
      noLoop();
    }
    else if (guess == 1) {
     
      image( tooltip2, 0, 0); 
     
      noLoop();
    }

    else if (guess == 2) {
     
      image (tooltip3, 0, 0); 
    
      noLoop();
    }
    
     else if (guess == 3) {
    
       image (tooltip4, 0, 0); 
    
      noLoop();
    }
  }
  fill(255);
  //text( "Tap to restart", width/2, height/2 + 20 );
}

void update() {

  //defines angle and gravity acceleration per angle

    PVector f = new PVector( cos( a+PI/2 ) * -acc, 
  sin( a+PI/2 ) * -acc );
  if ( acc > 0 ) {
    acc *= 0.95;
  }


  ///gravity change with g class pvector
  PVector gDelta = new PVector( g.x / frameRate, g.y / frameRate);
  speed.add( gDelta );
  speed.add( f );  //force +- gravity
  pos.add( speed );


  ///sets ground gravity and defines edges

  if ( pos.x > landingX- 40  && pos.x < landingX+40  && pos.y >
    height - 120 - ship[frame].height/2 ) {
    pos.y = height - 120 - ship[frame].height/2;
    image(dust[frameff], pos.x-50, pos.y-50, dust[frameff].width, dust[frameff].height );
   
    image (signs, landingX -215, 640); 
   //  boomth.seekTo(0);
    // boomth.start();
    state = FINISHED;
  } 
  else if (pos.y > height - 110 - ship[frame].height/2 ) {
    pos.y = height - 110 - ship[frame].height/2;

   //  boomth.seekTo(0);
     boomth.start();

    image(explosion[framef], pos.x-50, pos.y-50, explosion[framef].width, explosion[framef].height );
    boomth.start();
    image (signs, landingX -215, 640); 

    state = FINISHED;
  }



  if (pos.x < 0)
  {
    pos.x = 0;
  }
  if (pos.x > 1024)
  { 
    pos.x = 1024;
  }
  if (pos.y < 0)
  {
    pos.y = 0;
  }
}

void drawMoon() {

  image(background,0,0);
  // image(stars, 0, 0);

  image (metoer, alienx, alieny); 
  //  stroke(0);
  // fill(255, 200, 0, 60);


  ////////////////////////////code for a rigid landscape////////////////////////
  // beginShape();
  //vertex(0, height);
  //for ( int i=0; i < moon.length-1; i++) {
  //  vertex( i * 10, height - 120 - moon[i] );
  // }
  // vertex(width, height);
  // endShape(CLOSE);
}


////////////// code for landing spot

void drawLandingZone() {
  fill(128, 200);
  // rect( landingX -30, height - 130, 60, 10);
  image(pad, landingX -30, height - 125);
  image (signs, landingX -210, int(random( 260, 270))); 
  image(base, landingX-200, height - 275);
}

////////////// code for ship piece

void drawShip() {
  pushMatrix();
  translate(pos.x, pos.y);   //used Pvector
  rotate(a);

  //flames
  noFill();
  for ( int i=4; i >= 0; i--) {
    stroke(255, i*50, 0);
    fill(255, i*50, 20);
    rect( -6, 10, min(1, acc*5) *i*7, min(1, acc*5)* i*7);
  }

  image(ship[frame], -ship[frame].width/2, -ship[frame].height/2, ship[frame].width, ship[frame].height );
  //image( ship, -ship.width/2, -ship.height/2, ship.width, ship.height );
  popMatrix();
}

void keyPressed() {

  if ( keyCode == LEFT ) {
    a -= 0.3;
      tilt.seekTo(0);
          tilt.start();
  }
  if ( keyCode == RIGHT ) {
    a += 0.3;
      tilt.seekTo(0);
          tilt.start();
  }
  if ( keyCode == UP ) {
    acc += 0.06;
    acc = max( acc, 1/frameRate);
     thrust.seekTo(0);
          thrust.start();
  }

  if (acc >= 1.6) {
    acc -= 0.2;
  }
  if (acc <= 0) {
    acc =0;
  }
}



void move()
{
  alienx+=alienxv;
  if (alienx>width-30) alienxv=-alienxv;
  if (alienx<0) alienxv=-alienxv;



  alieny+=alienyv;
  if (alieny>height- 460) alienyv=-alienyv;
  if (alieny<0) alienyv=-alienyv;


  if (alienx == pos.x) {
    alienyv=-alienyv;
    a +=4.2;
    electricity.seekTo(0);
         electricity.start();
  }


  if (alieny == pos.y) {
    alienyv=-alienyv;
    a -=4.2;
    electricity.setLooping(false);
    electricity.seekTo(0);
         electricity.start();
  }
}



void mousePressed() {
  loop();
  if ( state == WAITING ) {
    state = RUNNING;
  } 
  else if ( state == RUNNING ) {
    if ( mouseY >= 300 ) {
      acc += 0.06;
      acc = max( acc, 1/frameRate);
      thrust.seekTo(0);
          thrust.start();
    }
    else if ( mouseX > width- 100 && mouseY < 100 ) {
      a -= 0.2;
      tilt.seekTo(0);
          tilt.start();
    }
    else if ( mouseX < 100 && mouseY < 100 ) {
      a += 0.2;
      tilt.seekTo(0);
          tilt.start();
    }
  } 
  else if ( state == FINISHED ) {
    reset();
     click.seekTo(0);
     click.start();
    state = RUNNING;
  }
}


