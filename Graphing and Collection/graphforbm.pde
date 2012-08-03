import processing.serial.*;
Serial myPort;
String inBuffer = "";
float Battery_voltage = 0;
float Humidity = 0;
float Temperature = 0; 
float Pressure = 0;
int dataCount = 1; // Setting dataCount to 1 will tell the computer when to start reading the data 


PFont font;

boolean first_comm = true;

float[] dat = new float[625]; // Make an array of data coming over serial 
float[] Battery_voltage_array = new float[625]; //Make a seperate array for each Weather section
float[] Humidity_array = new float[625];// (i.e. Battery voltage, Humidity, Temperature, and Pressure, etc.)
int[] Temperature_array = new int[625];
int[] Pressure_array = new int[625];

String filePath = "/Users/akhil/Desktop/graphforbm/logs/log-" + year() + month() + day() + hour() + minute() + second() + ".csv"; 

void setup() {
  size(1024, 768);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 115200);
  delay(500); //Let remote system boot 
  
  myPort.bufferUntil ('\n'); //Then wait till we've received our first valid string of data
  smooth();
  font = loadFont("Times-Roman-22.vlw");
  textFont(font);
  frameRate(10);
  
  String[] csv_title = {"Year,Month,Day,Hour,Minute,Seconds,Battery Voltage,Humidity,Temperature,Pressure"}; //Write to a CSV File!
  appendToFile(filePath, csv_title); 
}

void serialEvent(Serial myPort) {
  int start = 0; //Where to start reading the data
  if (first_comm == true)
    {
      start = 4;
      first_comm = false;
    }
   inBuffer = myPort.readStringUntil('\n');
   inBuffer = inBuffer.substring(0, inBuffer.length()- 1); //Remove new line from the end
   dat = float(split(inBuffer, ',')); //Parse dat into a string of numbers 
   dataCount ++;
   if (dataCount > 4) //After first set of invalid data, display data as values
   { 
      Battery_voltage = ((dat[0]*5)/1024)-1;
      Humidity = dat[1]; 
      Temperature = (dat[2]/10);
      Pressure = (dat[3]/1000);
    }
    
  //Write to a CSV File!
  String[] csv_data ={year() + "," + month() + "," + day() + "," + hour() + "," + minute() + "," + second() + "," + Battery_voltage + "," + Humidity + "," + Temperature + "," + Pressure};
  appendToFile(filePath, csv_data);
  }

void draw() {
  background(200);
  fill(0);
  if (dataCount == 4) //Ignored first set of invalid data
    { 
      for (int i = 0; i<dat.length;i++)
        {
          dat[i] = 0; 
        }
    } 
  //Axes Labels
  textSize(14);
  text("0, 0, -30\u00B0, 88.1", 2, 755);
  text("0.455, 9, -23.25\u00B0, 90.2", 2, 700);
  text("0.757, 15, -18\u00B0, 91.6", 2, 660);
  text("1.364, 28, -9\u00B0, 94.4", 2, 580);
  text("1.97, 40, 0\u00B0, 97.2", 2, 500);
  text("2.576, 52, 9\u00B0, 100", 2, 420);
  text("3.182, 64, 18\u00B0, 102.8", 2, 340);
  text("3.789, 76, 27\u00B0, 105.6", 2, 260);
  text("4.091, 82, 31.5\u00B0, 107", 2, 220);
  text("5, 100, 45\u00B0, 111.2", 2, 100);
  text("Voltage, Humidity, Temperature, Pressure", 2, 65);
  

  //Time (Seconds)
  textSize(16);
  text("Time (s)", 800, 755);
  text("Now", 610, 755);
  text("-10", 510, 755);
  text("-20", 410, 755);
  text("-30", 310, 755);
  text("-40", 210, 755);

  //Graph Name
  textSize(19);
  text("Outdoor Weather", 300, 30);

  //Graph Legend
  textSize(20);
  text("Graph Legend:", 825, 70);
  fill(255, 112, 66);
  text("Voltage (V)", 840, 100);
  fill(109, 207, 71); 
  text("Humidity (%)" , 840, 130);
  fill(109, 41, 71); 
  text("Temperature (C)", 840, 160);
  fill(37, 87, 223); 
  text("Pressure (kPa)", 840, 190);

  //Data
  fill(115, 115, 115);
  textSize(25);
  fill(255, 112, 66);
  text("Voltage:" + " "  + Battery_voltage + "V", 750, 400);
  fill(109, 207, 71); 
  text("Humidity:" + " " + Humidity + "%", 750, 430);
  fill(109, 41, 71); 
  text("Temperature:" + " " + Temperature + "\u00B0C", 750, 460);
  fill(37, 87, 223); 
  text("Pressure:" + " " + Pressure + "kPa", 750, 490);

  //Grid Lines
  for (int i = 0 ;i<=width/18.75;i++)
    {
    strokeWeight(1);
    stroke(225);
    line((-frameCount%20)+i*20-450, 100, (-frameCount%20)+i*20-450, height);
    line(0, i*20+100, width-400, i*20+100);
    }
   
   //Voltage Line 
  //(0V to 5V)
  float var_scale_v = map(Battery_voltage, 0, 5, 768, 100); //Scale Battery_voltage values for the y-axis of the graph 
  noFill();
  stroke(255, 112, 66);
  strokeWeight(5);
  if (dataCount > 4) //After first set of invalid data, start graphing
    {
    beginShape(); 
    for (int i = 0; i<Battery_voltage_array.length;i++)
      {
        vertex(i, Battery_voltage_array[i]);  
      }
    endShape();
    for (int i = 1; i<Battery_voltage_array.length;i++)
      {
        Battery_voltage_array[i-1] = Battery_voltage_array[i]; //New array value will be the one after it  
      }
    Battery_voltage_array[Battery_voltage_array.length-1]= int(var_scale_v); //set last value to scaled value of Humidity
    
  //Humidity Line 
  //(0% to 100%)
  float var_scale_h = map(Humidity, 0, 100, 768, 100); //Scale Humidity values for the y-axis of the graph 
  noFill();
  stroke(109, 207, 71);
  strokeWeight(5);
  beginShape(); 
    for (int i = 0; i<Humidity_array.length;i++)
      {
        vertex(i, Humidity_array[i]);  
      }
    endShape();
    for (int i = 1; i<Humidity_array.length;i++)
      {
        Humidity_array[i-1] = Humidity_array[i]; //New array value will be the one after it  
      }
    Humidity_array[Humidity_array.length-1]= int(var_scale_h); //set last value to scaled value of Humidity  

  //Temperature Line
  //(-30 degrees to 45 degrees)
    float var_scale_t = map(Temperature, -30, 45, 768, 100); //Scale Temperature values for the y-axis of the graph
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
  //(89kPa to 111kPa)
  float var_scale_p = map(Pressure, 89.5, 110, 768, 100); //Scale Pressure values for the y-axis of the graph
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
     
  }
}

//http://forum.processing.org/topic/log-data-on-a-csv-file-is-it-possible
void appendToFile(String filePath, String[] dat)
{
  PrintWriter pw = null;
  try
  {
    pw = new PrintWriter(new BufferedWriter(new FileWriter(filePath, true))); // true means: "append"
    for (int i = 0; i < dat.length; i++)
    {
      pw.println(dat[i]);
    }
  }
  catch (IOException e)
  {
    // Report problem or handle it
    e.printStackTrace();
  }
  finally
  {
    if (pw != null)
    {
      pw.close();
    }
  }
}

