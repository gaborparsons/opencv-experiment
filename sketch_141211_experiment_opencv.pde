import processing.video.*;
Capture video;
int numPixels;
int[] backgroundPixels;

float d;
int closestX, closestY = 0;
int colorTrack = 1;

void setup() {
  size(640, 560, P3D); 

  video = new Capture(this, width, height-80);
  video.start();

  loadPixels();
  smooth();
}

void draw() {
  background(0);

  if (video.available()) {
    video.read();
    video.loadPixels();
    // Before we begin searching, the "high number" for closest color is set to a high number that is easy for the first pixel to beat.
    float highNumber = 5000; 
   
    for(int x = 0; x < video.width; x++){
      for(int y = 0; y < video.height; y++){
  
        int loc = x + y*video.width;
        //Check current color
        color currentColor = video.pixels[loc];
        float r = red(currentColor);
        float g = blue(currentColor);
        float b = green(currentColor);
       
        if(colorTrack == 1){d = dist(r, g, b, 255, 0, 0);}
        if(colorTrack == 2){d = dist(r, g, b, 0, 255, 0);}
        if(colorTrack == 3){d = dist(r, g, b, 0, 255, 0);}
  
        if (d < highNumber) {
          highNumber = d;
          closestX = x;
          closestY = y;
        }
   
        float z = (closestX / float(2500)) * max(r, g, b);
         
        pushMatrix();
        translate(x-3, y-6, z*10);
        fill(currentColor, 200);
        noStroke();
        rect(0, 0, 3, 6);
        popMatrix();
      }   
    }
    fill(255,0,0);
    rect(20, height - 60, 40, 40); 
    fill(0,255,0);
    rect(80, height - 60, 40, 40); 
    fill(0,0,255);
    rect(140, height - 60, 40, 40); 
  } 
  println(closestX);

}

void mouseClicked(){
   if(mouseX > 20 && mouseX < 60 && mouseY > height-60 && mouseY < height-20){
      colorTrack = 1; 
   }
   if(mouseX > 80 && mouseX < 120 && mouseY > height-60 && mouseY < height-20){
      colorTrack = 2; 
   }
   if(mouseX > 140 && mouseX < 180 && mouseY > height-60 && mouseY < height-20){
      colorTrack = 3; 
   }
}
