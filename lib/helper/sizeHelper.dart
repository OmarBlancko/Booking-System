import 'package:flutter/widgets.dart';

class SizeHelper{
  late final BuildContext context;
  SizeHelper(this.context);
  double _calculatePercentage(double distance, double deviceDimensions) {
    double pc = distance / deviceDimensions;
    return  pc;
  }
  double getWidth(double x) {
    final deviceSize = MediaQuery.of(context).size;
    return _calculatePercentage(x, deviceSize.width) *
        deviceSize.width;
  }
  double getHeight(double x) {
    final deviceSize = MediaQuery.of(context).size;
    return _calculatePercentage(x, deviceSize.height) *
        deviceSize.height;
  }
}