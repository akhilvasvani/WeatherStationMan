import processing.serial.*;
Serial myPort;
String inBuffer = "";
float Humidity = 0;
float Temperature = 0; 
float Pressure = 0;
int dataCount = 1; 
int loopCount = 0; 

boolean first_comm = true;

float[] dat = new float[625]; // make an array of data coming over serial 
float[] Humidity_array = new float[625]; 
int[] Temperature_array = new int[625];
int[] Pressure_array = new int[625];

PFont font; 

void setup() {
  size(1024, 768);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  delay(500); 
  myPort.bufferUntil ('\n');
  smooth();
  font = loadFont("Times-Roman-22.vlw");
  textFont(font);
  frameRate(10);
}

void serialEvent(Serial myPort) {
  int start = 0; //where to start reading the data
  if (first_comm == true)
    {
      start = 4;
      first_comm = false;
    }
   inBuffer = myPort.readStringUntil('\n');
   inBuffer = inBuffer.substring(0, inBuffer.length()- 1);
   dat = float(split(inBuffer, ',')); //parse dat into a string of numbers 
   dataCount ++;
   if (dataCount > 3) //after first set of invalid data, display data
   { 
      Humidity = (dat[0]*100); 
      Temperature = (dat[1]/10);
      Pressure = (dat[2]/1000);
    }
  }

void draw() {
  background(255);
  fill(0);
  if (dataCount == 3) //ignored first set of invalid data
    { 
      for (int i = 0; i<dat.length;i++)
        {
          dat[i] = 0;
        }
    } 
  //Axes Labels
  textSize(14);
  text("0,-30\u00B0, 88.1", 2, 755);
  text("9, -23.25\u00B0, 90.2", 2, 700);
  text("15, -18\u00B0, 91.6", 2, 660);
  text("28, -9\u00B0, 94.4", 2, 580);
  text("40, 0\u00B0, 97.2", 2, 500);
  text("52, 9\u00B0, 100", 2, 420);
  text("64, 18\u00B0, 102.8", 2, 340);
  text("76, 27\u00B0, 105.6", 2, 260);
  text("82, 31.5\u00B0, 107", 2, 220);
  text("100, 45\u00B0, 111.2", 2, 100);
  text("Humidity (%), Temperature (C), Pressure (kPa)", 2, 65);

  //Time (Seconds)
  textSize(16);
  text("Time (s)", 800, 755);
  text("Now", 610, 755);
  text("-10", 510, 755);
  text("-20", 410, 755);
  text("-30", 310, 755);
  text("-40", 210, 755);

  //Graph Name
  textSize(15);
  text("Outdoor Weather", 300, 30);

  //Graph Legend
  textSize(15);
  text("Graph Legend:", 825, 70);
  fill(109, 207, 71); 
  text("Humidity", 840, 100);
  fill(109, 41, 71); 
  text("Temperature", 830, 130);
  fill(37, 87, 223); 
  text("Pressure", 840, 160);

  //Data
  fill(115, 115, 115);
  textSize(14);
  text("Humidity:" + " " + Humidity + "%", 800, 400);
  text("Temperature:" + " " + Temperature + "\u00B0C", 800, 430);
  text("Pressure:" + " " + Pressure + " kPa", 800, 460);

  //Grid Lines
  for (int i = 0 ;i<=width/18.75;i++)
    {
    strokeWeight(1);
    stroke(225);
    line((-frameCount%20)+i*20-450, 100, (-frameCount%20)+i*20-450, height);
    line(0, i*20+100, width-400, i*20+100);
    }
    
  //Humidity Line 
  float var_scale_h = map(Humidity, 0, 100, 768, 100); //scale Humidity values for the y-axis of graph 
  noFill();
  stroke(109, 207, 71);
  strokeWeight(5);
  if (dataCount > 3) 
    {
    beginShape(); 
    for (int i = 0; i<Humidity_array.length;i++)
      {
        vertex(i, Humidity_array[i]);
      }
    endShape();
    for (int i = 1; i<Humidity_array.length;i++)
      {
        Humidity_array[i-1] = Humidity_array[i];
      }
    Humidity_array[Humidity_array.length-1]= int(var_scale_h); 

  //Temperature Line
    float var_scale_t = map(Temperature, -30, 45, 768, 100);
    noFill();
    stroke(109, 41, 71);
    strokeWeight(5);
    beginShape();
    for (int i = 0; i<Temperature_array.length;i++)
      {
        vertex(i, Temperature_array[i]);
      }
    endShape();
    for (int i = 1; i<Temperature_array.length;i++)
      {
        Temperature_array[i-1] = Temperature_array[i];
      }
    Temperature_array[Temperature_array.length-1]= int(var_scale_t);

  //Pressure Line
  float var_scale_p = map(Pressure, 89.5, 110, 768, 100);
  noFill();
  stroke(37, 87, 223);
  strokeWeight(5);
  beginShape();
  for (int i = 0; i<Pressure_array.length;i++)
    {
      vertex(i, Pressure_array[i]);
    }
    endShape();
    for (int i = 1; i<Pressure_array.length;i++)
    {
      Pressure_array[i-1] = Pressure_array[i];
    }
    Pressure_array[Pressure_array.length-1]=int(var_scale_p);
    loopCount ++;
  }
}

