/* @pjs preload="image1.png"; */
/* @pjs preload="image2.png"; */
/* @pjs preload="image3.png"; */
/* @pjs preload="image4.png"; */
/* @pjs preload="image5.png"; */
/* @pjs preload="image6.png"; */

// ---------
// Colors
// ---------
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

// --------
// Loop
// --------

PImage img;
int imageIndex = 0;

String[] ImageList = { 
  "image1.png", 
  "image2.png", 
  "image3.png", 
  "image4.png", 
  "image5.png", 
  "image6.png"
};

void setup()
{
  size(1024, 1024, P2D);
  background(255);
  pickImage();
}

void pickImage()
{
  img = loadImage(ImageList[imageIndex++ % ImageList.length]);
  img.resize(width, 0);
}

void draw()
{
  for (int iy = 0; iy < img.height; ++iy) {
    for (int ix = 0; ix < img.width; ++ix) {
      int odds = (int)random(20000);
      
      if (odds < 5) {
        color pixelColor = img.pixels[iy * img.width + ix];
        
        int maxSize = 10;
        if (frameCount < 100) {
          maxSize = 50;
        }  else if (frameCount < 130) {  
          maxSize = 40;
        } else if (frameCount < 200) {
          maxSize = 30;
        } else if (frameCount < 300) {
          maxSize = 20;
        } else if (frameCount < 400) {
          maxSize = 15;
        } else if (frameCount < 500) {
          maxSize = 10;
        }
  
        int x = ix + width/2 - img.width/2;
        int y = iy + height/2 - img.height/2;

        noStroke();
        //fill(getPaletteColor(pixelColor));
        fill(pixelColor);
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
  background(255);
  pickImage();
  frameCount = 0;
}