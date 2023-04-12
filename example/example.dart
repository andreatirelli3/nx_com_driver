import 'package:nx_com_driver/nx_com_driver.dart' as nx_com_driver;

void main() {
  nx_com_driver.NXComDriver driver = nx_com_driver.NXComDriver(
      port: '/dev/ttyUSB0', baudRate: 115200, timeout: 1000);
}
