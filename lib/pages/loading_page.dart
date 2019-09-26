import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class LoadingPage extends StatelessWidget {
  final Color backgroundColor;

  LoadingPage({Key key, @required this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/icons/ic_launcher_foreground.png"),
            Loading(
              indicator: BallPulseIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
