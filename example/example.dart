import 'dart:io';

import 'package:nx_com_driver/nx_com_driver.dart' as nx_com_driver;

void main() async {
  // Define terminator character for the serial port
  String terminator = "<CR>";

  // Create a new instance of NXComDriver
  nx_com_driver.NXComDriver driver =
      nx_com_driver.NXComDriver(port: 'COM2', baudRate: 115200, timeout: 1000);

  // Configure the driver with the serial port settings. In this case use default
  if (driver.config() == -1) {
    print('Error configuring serial port');
    exit(0);
  }
  print("Serial port configured");

  // Open the serial port
  if (driver.open() == -1) {
    print('Error opening serial port');
    exit(0);
  }
  print("Serial port opened");

  // Write data to the serial port with the interpolation of the terminator character
  if (driver.write('Hello World!$terminator') == -1) {
    print('Error writing to serial port');
    exit(0);
  }
  print("Data written to serial port");

  // Initialize the reader
  if (driver.readerInit() != -1) {
    print("Reader initialized");

    // Read data from the serial port
    await driver.read().then((value) => print(value));
  } else {
    print('Error initializing reader');
    exit(0);
  }
}
