import processing.serial.*;
Serial myPort;
//String data = "";
String inBuffer = null;

//String Humidity="";
//String Temperature="";
//String Pressure="";
	
//float[] Humidity_array = new float[900];
//int[] Temperature_array = new int[900];
//int[] Pressure_array = new int[900];


void setup()  {
  size(200, 200);
 
  myPort = new Serial(this, "/dev/tty.usbserial-A401888M", 115200);
  //myPort.bufferUntil ('\n');
  //delay(500); //Let remote system boot
  //Tell it we want data!
  //port.write("data\r\n");
  
}

void serialEvent(Serial myPort){
  //val = myPort.read();
  inBuffer = myPort.readStringUntil('\n');
  //inBuffer = data.substring(0, data.length() - 1);
  //println(inBuffer);
  //Grab the Actual values from this data string
  
  
}

void draw()  {
  int[] dat; // array of numbers read in on one line from serial port
  delay(500);
  if (inBuffer != null) {  // wait for new data on the serial port

    //print(inBuffer);  // show the line of serial input
    dat = int(split(inBuffer, ','));  // parse comma-separated number string into numbers
    String[] values = splitTokens(inBuffer, ", ");
    println(values[0]);
    println(values[1]);
    println(values[2]);
    
  }
  delay(200);
}




