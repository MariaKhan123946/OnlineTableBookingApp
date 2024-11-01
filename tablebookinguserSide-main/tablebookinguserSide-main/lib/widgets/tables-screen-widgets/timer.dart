import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerPage extends StatefulWidget {
  final Color containerColor;
  final double containersize;
  final BoxShape containershape;

  CountdownTimerPage(
      {required this.containerColor,
      required this.containersize,
      required this.containershape});
  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  int _timerCount = 3600;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_timerCount < 1) {
            timer.cancel();
            _timerCount = 3600;
          } else {
            _timerCount--;
          }
        });
      },
    );
  }

  void _toggleTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    } else {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _toggleTimer,
          child: Container(
            width: widget.containersize,
            height: widget.containersize,
            decoration: BoxDecoration(
                color: widget.containerColor, shape: widget.containershape),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${(_timerCount ~/ 3600).toString().padLeft(
                        2,
                      )}:${((_timerCount % 3600) ~/ 60).toString().padLeft(
                        2,
                      )}:${(_timerCount % 60).toString().padLeft(
                        2,
                      )}',
                  style: const TextStyle(fontSize: 8, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
