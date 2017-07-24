import processing.video.*;

Capture cam;
PImage img;

float getColorDistance(color c1, color c2)
  {
    float redDiff = red(c2) - red(c1);
    float grnDiff = green(c2) - green(c1);
    float bluDiff = blue(c2) - blue(c1);

    return sq(redDiff) + sq(grnDiff) + sq(bluDiff);
  }

color[] Palette = { 
  #1abc9c, // turquoise
  #2ecc71, // emerald
  #3498db, // peter river
  #9b59b6, // amethyst
  #34495e, // wet asphalt
  #16a085, // green sea
  #27ae60, // nephritis
  #2980b9, // belize hole
  #8e44ad, // wisteria
  #2c3e50, // midnight blue
  #f1c40f, // sun flower
  #e67e22, // carrot
  #e74c3c, // alizarin
  #ecf0f1, // clouds
  #95a5a6, // concret
  #f39c12, // orange
  #d35400, // pumpkin
  #c0392b, // pomegranate
  #bdc3c7, // silver
  #7f8c8d, // absestos
  #a8e6cf, // greenish
  #dcedc1, // apple green
  #ffd3b6, // light orange
  #ffaaa5, // orange red
  #ff8b94, // red
};
  
color getPaletteColor(color originalColor)
{
  float  smallestDiff  = 0;
  color  selectedColor = -1;
  
  for (int i = 0; i < Palette.length; ++i) 
  {
     color c = Palette[i];
     float diff = getColorDistance(c, originalColor);
     if (selectedColor == -1 || diff < smallestDiff) {
       smallestDiff   = diff;
       selectedColor  = c;
     }
  }
  
  return selectedColor;
}

void setup()
{
  size(1024, 1024, P2D);
  img = createImage(width, height, RGB);
  cam = new Capture(this);
  cam.start();
}


void draw()
{
  if (cam.available() == true){
    img.copy(cam, cam.width / 2 - width / 2, cam.height / 2 - height / 2, width, height, 0, 0, width, height);
    img.updatePixels();
    cam.read();
  }
  
  loadPixels();
  cam.loadPixels();
  img.loadPixels();
  
  for (int y = 0; y < img.height; ++y) {
    for (int x = 0; x < img.width; ++x) {
      int odds = (int)random(20000);
      
      if (odds < 5) {
        color pixelColor = img.pixels[y * img.width + x];
        
        int maxSize = 20;
        if (frameCount < 20){
          maxSize = 260;
        } else if (frameCount < 40) {
          maxSize = 180;
        } else if (frameCount < 70) {
          maxSize = 100;
        } else if (frameCount < 100) {
          maxSize = 50;
        }  else if (frameCount < 130) {  
          maxSize = 40;
        } else if (frameCount < 200) {
          maxSize = 30;
        }
  
        
        //if (frameCount < 60) {
        //  stroke(255);
        //} else {
        //  noStroke();
        //}
        
        noStroke();
        fill(getPaletteColor(pixelColor));
        triangle(
          x + random(-maxSize, maxSize), 
          y + random(-maxSize, maxSize), 
          x + random(-maxSize, maxSize), 
          y + random(-maxSize, maxSize), 
          x + random(-maxSize, maxSize), 
          y + random(-maxSize, maxSize));
      }
    }
  }
}

void mousePressed() 
{
  frameCount = 0;
}