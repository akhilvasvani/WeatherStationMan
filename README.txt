WeatherStationMan 

The project was originally developed by zmashiah under the name "Wireless outdoor Arduino weather station with PC logging and Graphs"
More info is available at http://www.instructables.com/id/Wireless-outdoor-Arduino-weather-station-with-PC-l/?ALLSTEPS 

This is Open Source Hardware and Software Licensed via a Creative Commons Attribution Share-Alike License
http://creativecommons.org/licenses/by-nc-sa/3.0/us/

I programmed this Weather Station using a Mac and I have updated it for Arduino 1.04.   

Check out my github page for more information: http://akhilvasvani.github.com/WeatherStationMan/

Arduino Code:
This is the code that is loaded on to Seeeduino Stalker v2.3. It gathers data via the DHT22 sensor and BMP085 sensor, and sends it wirelessly over XBee to the computer. 

Graphing and Collection:
This is the script for performing automatic data acquisition from the DHT22 and BMP085 sensors.

Libraries:
The above folder contains the drivers (not already installed on Arduino) needed for this project. 

Boards:
The above folder contains the driver (not already installed on Arduino) needed for this project.

ToubleShooting:
"RXTX version mismatch on a Macbook pro -- nothing seems to solve this problem"
More info is available at https://forum.processing.org/topic/rxtx-version-mismatch-on-a-macbook-pro-nothing-seems-to-solve-this-problem

"What is wrong? parsing serial data with split()"
More info is available at https://forum.processing.org/topic/what-is-wrong-parsing-serial-data-with-split

Credits:
In the Arduino 'Code' file, I referenced a couple of example codes: 
BMP085 example code was written by Jimbo 
More info is available at http://www.sparkfun.com/tutorials/253 

DHT22 example code was written by Rob Tillaart
More info is available at http://playground.arduino.cc/Main/DHTLib

DHT22 library code was written by Rob Tillaart
More info is available at http://playground.arduino.cc/Main/DHTLib

In the Processing 'Graph and Collection' file, I referenced a few example codes:
MSP430-Wireless-Weather-Station code was written by Jeremy E. Blum & Matt Newberg
More info is available at http://jeremyblum.com/2011/05/14/msp430-wireless-weather-station/

HelioWatcher code was written Jeremy E. Blum
More info is available at https://github.com/sciguy14/HelioWatcher
