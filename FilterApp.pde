

boolean PicLoaded = false;
boolean Grayscale = false;
boolean Invert = false;
boolean Purple_Rain = false;
boolean Break = false;
int picWidth = 0;
int picHeight = 0;
PImage img;
PFont font;
/***********************************/

void setup() 
{
  size(800, 480);
  background(color(#0D5690));
  
  font = loadFont("MonaShark-60.vlw");
  textFont(font,100);
  textSize(16);
  textAlign(LEFT);
}

void draw()
{

  background(#0D5690);
  noStroke();
  int picStart = 0;
  int picEnd = 0;
  
  /* draw buttons */

  stroke(0);
  fill(#24AA6A);
  textSize(20);
  text("File Operations",665,35);
  line(650,0,650,480);
  noStroke();
  
  fill(#05FFFD);                    //establishes the color of the button while it is not activated
  rect(660, 50, 130, 40, 10);       //creates the shape for the button
  fill(#C833D1);                    //color for the name of the button
  text("Load Picture", 675, 77);    //name text and position within button

  fill(#05FFFD);
  rect(660, 100, 130, 40, 10);
  fill(#C833D1);
  text("Save Picture", 675, 127);

  stroke(255);
  line(650,150,800,150);
  noStroke();

  stroke(255);
  fill(#24AA6A);
  textSize(20);
  text("Filter Effects",670,185);
  line(650,0,650,480);
  noStroke();
  
  fill(#389EF0);
  quad(650,0,650,480,0,480,0,0);

  if (Grayscale)
    fill(#84F7A8);    //Effect on means a yellow lighted button
  else
    fill(#05FFFD);
  rect(660, 200, 130, 40, 10);
  fill(#C833D1);
  text("Grayscale", 682, 227);
  
  if (Invert)
    fill(#84F7A8);    //Effect on means a yellow lighted button
  else
    fill(#05FFFD);
  rect(660, 250, 130, 40, 10);
  fill(#C833D1);
  text("Invert", 700, 277);

  if (Purple_Rain)
    fill (#84F7A8);     //Effect on means a yellow lighted button 
  else
    fill(#05FFFD); 
  rect(660, 300, 130, 40, 10);
  fill(#C833D1);
  text("Purple Rain", 678, 327);

  if (Break)
    fill (#84F7A8);    //Effect on means a yellow lighted button
  else
    fill(#05FFFD);   
  rect(660, 350, 130, 40, 10);
  fill(#C833D1);
  text("Break", 700, 377);

  noStroke();
  textSize(16);

  //The following loads and displays an image file.
  //The image is resized to best fit in a 640x480 frame.
  if (PicLoaded)
  {     
    picWidth = img.width;
    picHeight = img.height;
    
    if (picWidth > 640)
    {
      picHeight = (int)(picHeight*(640.0/picWidth));
      picWidth = 640;
    }
    if (picHeight > 480)
    {
      picWidth = (int)(picWidth*(480.0/picHeight));
      picHeight = 480;
    }
    image(img, 0, 0, picWidth, picHeight);
    
    picStart = 0;
    picEnd = picStart+width*picHeight;

    loadPixels();
    
    /***** Effects Code *****/

    /* This sample grayscale code may serve as an example */
    if (Grayscale)
    {
      int i = picStart;
      while (i < picEnd) 
      {
        color c = pixels[i];
        float gray = (red(c)+green(c)+blue(c))/3.0;  //average the RGB colors
        pixels[i] = color(gray, gray, gray);
        i = i + 1;
        if (i % width >= picWidth)        // This will ignore anything on the line that 
          i = i + width - picWidth;       // after the image (such as buttons)
      }   
    }

    if (Invert)
    {
      int i = picStart;
      while (i < picEnd) 
      {
        
        color c = pixels[i];
        pixels[i] = color(255 - red(c), 255 - green(c), 255 - blue(c));
        
        i = i + 1;
        if (i % width >= picWidth)        // This will ignore anything on the line that 
            i = i + width - picWidth;       // after the image (such as buttons)
      }
    }

    if (Purple_Rain)
    {
     int i = picStart;
      while (i < picEnd) 
      {
        // Get the R, G, B values from the image
        float r = red(pixels[i]);
        float g = green(pixels[i]);
        float b = blue(pixels[i]);
    
        color newColor = color(2*b, g, 2*r);     //create a new color
        pixels[i] = newColor;                   //store the new color  
        
        i = i + 1;
        if (i % width >= picWidth)        // This will ignore anything on the line that 
            i = i + width - picWidth;       // after the image (such as buttons)
      }
    }
    
    int neg = (800 - picWidth);
    
    if (Break)
    {
      int i = picStart;
      int location = picStart;

      while (location < picEnd) 
      {
        // Get the R, G, B values from the image
        float r = red  (pixels[location]);
        float g = green (pixels[location]);
        float b = blue (pixels[location]);
    
        color newColor = color(r - 10, g * 2, b * 70);   //create a new color
        pixels[pixels.length - (neg + 1) - location] = newColor;     //store the new color 
        pixels[location] = newColor;
        location = location + 1;     //next pixel!
    
        if (location % width >= picWidth)        // This will ignore anything on the line that
          location =location+width-picWidth;    // after the image (such as buttons)              
     }
    }
    
    updatePixels(); 
    redraw();
  }
  
  fill(255);
  noStroke();
}

void mouseClicked() 
{
  redraw();
}

void mousePressed()
{
  //The following define the clickable bounding boxes for any buttons used.
  //Note that these boundaries should match those drawn in the draw() function.
  
  if (mouseX>660 && mouseX<790 && mouseY>50 && mouseY<90)
  {
    selectInput("Select a file to process:", "infileSelected");
  }
  
  if (mouseX>660 && mouseX<790 && mouseY>100 && mouseY<140)
  {
    selectOutput("Select a file to write to:", "outfileSelected");
  }
  
  if (mouseX>660 && mouseX<790 && mouseY>200 && mouseY<240 && PicLoaded)
  {
    Grayscale = !Grayscale;
  }   
  
  if (mouseX>660 && mouseX<790 && mouseY>250 && mouseY<290 && PicLoaded)
  {
    Invert = !Invert;
  } 

  if (mouseX>660 && mouseX<790 && mouseY>300 && mouseY<340 && PicLoaded)
  {
    Purple_Rain = !Purple_Rain;
  }  

  if (mouseX>660 && mouseX<790 && mouseY>350 && mouseY<390 && PicLoaded)
  {
    Break = !Break;
  } 

  redraw();
}

void infileSelected(File selection) 
{
  if (selection == null) 
  {
    println("IMAGE NOT LOADED: Window was closed or the user hit cancel.");
  } 
  else 
  {
    println("IMAGE LOADED: User selected " + selection.getAbsolutePath());
    img = loadImage(selection.getAbsolutePath());
    PicLoaded = true;
    Grayscale = false;
    Invert = false;
    Purple_Rain = false;
    Break = false;
    redraw();
  }
}

void outfileSelected(File selection) 
{
  if (selection == null) 
  {
    println("IMAGE NOT SAVED: Window was closed or the user hit cancel.");
  } 
  else 
  {
    println("IMAGE SAVED: User selected " + selection.getAbsolutePath() + ".png");
    noLoop();
    updatePixels();
    redraw();
    save(selection.getAbsolutePath()+".png");
    redraw();
    loop();
  }
}
