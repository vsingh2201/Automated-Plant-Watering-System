% Code to test the DIP switch
% DIP switch 1 : Pin D7
% DIP switch 3: Pin D6
% Code for Major Project
clear all
list = {'I2C','Adafruit/DHT22'};
a = arduino('COM3','Uno','Libraries',list)
addrs = scanI2CBus(a);
% 0x72 is the I2C address of the Serial LCD
% Create the lcd object
lcd = device(a,'I2CAddress','0x72');
message1 = "EECS1011            ";
message2 = "Major Project       ";
message3 = "By Vikramjeet Singh";
ClearDisplay = '|-'; % Command to clear the LCD display
CommandCharacter = '|';
write(lcd,ClearDisplay);
write(lcd,message1);
pause(0.5);
write(lcd,message2);
pause(0.5);
write(lcd,message3);
pause(5);
write(lcd,ClearDisplay);
% Create a main menu
tempMessage = "1.Show Temperature";
humidityMessage = "  3.Display Humidity";
bothMessage1 = "  8.Display both Values";
%bothMessage2 = " Temperature and Humidity";
write(lcd, tempMessage);
pause(2);
write(lcd, humidityMessage);
pause(2);
write(lcd, bothMessage1);
pause(5);
write(lcd, ClearDisplay);
% Create the object for DHT11
sensor = addon(a,'Adafruit/DHT22','D3');
stop = false;
while ~stop
    % Added code for DIP switch
switch1 = readDigitalPin(a,'D7') % Temperature
switch3 = readDigitalPin(a,'D8') % Humidity
switch5 = readDigitalPin(a,'D9') % Both values
temperature = readTemperature(sensor);% Read temperature from sensor
humidity = readHumidity(sensor);% Read humidity from sensor
fprintf('Temperature:%.2f C\n', temperature);% Print temperature on terminal
fprintf('Humidity: %.2f %% \n', humidity);% Print humidity on terminal
% Convert temperature to string
displayTemp = num2str(temperature);
% Convert humidity to string
displayHumidity = num2str(humidity);
% Display Temperature on LCD
write(lcd, ClearDisplay);
if (switch1 == 0)
    write(lcd, ClearDisplay);
    write(lcd,strcat("Temperature: ",displayTemp,' C'));
    pause(5);
end
if (switch3 == 0)
    write(lcd, ClearDisplay);
    write(lcd,strcat(' Humidity:  ',displayHumidity, '%'));
    pause(5);
end
if (switch5 == 0)
    write(lcd, ClearDisplay);
    write(lcd,strcat("Temperature: ",displayTemp,' C'));
    pause(2);
    write(lcd,strcat('   Humidity:  ',displayHumidity, '%'));
    pause(4);
else
    write(lcd,ClearDisplay);
    write(lcd, tempMessage);
    pause(1);
    write(lcd, humidityMessage);
    pause(1);
    write(lcd, bothMessage1);
    pause(1);
end
stop = readDigitalPin(a,'D6');
end






