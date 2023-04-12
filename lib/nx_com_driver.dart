import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:libserialport/libserialport.dart';

class NXComDriver {
  /// Serial port name
  final String _port;

  /// Baud rate
  final int _baudRate;

  /// Timeout in milliseconds
  final int _timeout;

  /// Serial port object
  final SerialPort _serialPort;

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

  /// Open serial port
  /// It returns:
  /// - 1: success
  /// - -1: error
  int open() {
    // Check if serial port is already open
    if (_serialPort.isOpen) {
      try {
        _serialPort.close();
      } catch (_) {}
    }

    if (!_serialPort.isOpen) {
      if (_serialPort.openReadWrite()) {
        return -1;
      }
    }

    // Return success
    return 1;
  }

  /// Configure serial port
  ///
  /// It takes:
  /// - stopBits: stop bits
  /// - dataBits: data bits
  /// - parity: parity
  ///
  /// It returns:
  /// - 1: success
  /// - -1: error
  int config({int stopBits = 1, int dataBits = 8, int parity = 0}) {
    try {
      // Obtain serial port configuration
      SerialPortConfig cfg = _serialPort.config;
      // Set serial port configuration, baud rate
      cfg.baudRate = _baudRate;
      // Set serial port configuration, stop bits
      cfg.stopBits = stopBits;
      // Set serial port configuration, data bits
      cfg.bits = dataBits;
      // Set serial port configuration, parity
      cfg.parity = parity;

      // Set serial port configuration
      _serialPort.config = cfg;

      // Return success
      return 1;
    } catch (e) {
      // Print error
      print(e);
      // Return error
      return -1;
    }
  }

  /// Write data to serial port
  ///
  /// It takes:
  /// - data: data to write
  ///
  /// It returns:
  /// - 1: success
  /// - -1: error
  int write(String data) {
    try {
      // Convert data to bytes
      var bitData = utf8.encoder.convert(data);

      // Write data to serial port
      _serialPort.write(bitData);

      // Return success
      return 1;
    } catch (e) {
      // Print error
      print(e);
      // Return error
      return -1;
    }
  }

  /// Initialize serial port reader
  ///
  /// It returns:
  /// - 1: success
  /// - -1: error
  int readerInit() {
    try {
      // Initialize serial port reader
      _serialPortReader = SerialPortReader(_serialPort);

      // Return success
      return 1;
    } catch (e) {
      // Print error
      print(e);
      // Return error
      return -1;
    }
  }

  /// Read data from serial port
  /// It returns:
  /// - data: data read
  /// - -1: error
  Future<String> read() async {
    // Serial port response
    String response = '';

    var completer = Completer<String>();

    // Read data from serial port
    try {
      _serialPortReader.stream.listen((data) async {
        response = utf8.decode(data);

        completer.complete(response);
        completer.future;
      });

      // Wait for the delay
      await Future.delayed(Duration(milliseconds: _timeout), () {
        // Close serial port
        _serialPort.close();
        // Return response
        return response;
      });

      // Return response
      return response;
    } catch (e) {
      // Print error
      print(e);
      // Return error
      return '-1';
    }
  }

  /// Info to display all the the parameters of the serial port
  void info() {
    // Obtain serial port configuration
    SerialPortConfig cfg = _serialPort.config;

    // Print serial port configuration
    print('Serial port: \t\t$_port');
    print('Baud rate: \t\t${cfg.baudRate}');
    print('Stop bits: \t\t${cfg.stopBits}');
    print('Data bits: \t\t${cfg.bits}');
    print('Parity: \t\t${cfg.parity}');
  }
}
