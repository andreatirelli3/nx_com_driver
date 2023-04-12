import 'dart:ffi';

import 'package:libserialport/libserialport.dart';

class NXComDriver {
  /// Serial port name
  String _port;

  /// Baud rate
  int _baudRate;

  /// Timeout in milliseconds
  int _timeout;

  /// Serial port object
  late SerialPort _serialPort;

  /// Serial port reader object
  late SerialPortReader _serialPortReader;

  /// Constructor for NXComDriver.
  /// It takes:
  /// - port: serial port name
  /// - baudRate: baud rate
  /// - timeout: timeout in milliseconds
  NXComDriver(
      {required String port, required int baudRate, required int timeout})
      : _port = port,
        _baudRate = baudRate,
        _timeout = timeout,
        _serialPort = SerialPort(port);
}
