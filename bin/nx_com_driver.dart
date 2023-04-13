import 'dart:convert';
import 'dart:io';

import 'package:nx_com_driver/nx_com_driver.dart' as nx_com_driver;

/// Read JSON file
Future<Map<String, dynamic>> readJsonFile(String path) async =>
    jsonDecode(await File(path).readAsString());

void main(List<String> arguments) async {
  print(arguments[0]);
  var path = "cfg.json";
  // Read configuration file
  Map<String, dynamic> cfg = await readJsonFile(path);

  // Print serial port configuration
  print('Serial port: \t\t${cfg['port']}');
  print('Baud rate: \t\t${cfg['baudrate']}');
  print('Timeout: \t\t${cfg['timeout']}');

  /**
  // Initialize serial port
  nx_com_driver.NXComDriver driver = nx_com_driver.NXComDriver(
    port: cfg['port'],
    baudRate: cfg['baudrate'],
    timeout: cfg['timeout'],
  );

  // Configure serial port
  driver.config();

  // Print serial port configuration
  driver.info();
  */
}
