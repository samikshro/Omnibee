import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  double timeWindow;
  Function setTimeWindow;

  CustomSlider(this.timeWindow, this.setTimeWindow);

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0,
      max: 60,
      value: timeWindow,
      onChanged: (value) {
        timeWindow = value;
        setTimeWindow(timeWindow);
      },
    );
  }
}
