import 'dart:math';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.deepOrange,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  bool rightEnabled = false;
  bool leftEnabled = false;
  var random = Random();

  getDiceValue(oldNumber) {
    int newNumber = random.nextInt(6) + 1;
    while (oldNumber == newNumber) {
      newNumber = random.nextInt(6) + 1;
    }
    return newNumber;
  }

  void handleRightDiceUpdate() {
    setState(() {
      rightEnabled = true;
    });

    new Timer(Duration(milliseconds: 400), () {
      setState(() {
        rightEnabled = false;
        rightDiceNumber = this.getDiceValue(rightDiceNumber);
      });
    });
  }

  void handleLeftDiceUpdate() {
    if (leftEnabled == true) {
      return;
    }
    setState(() {
      leftEnabled = true;
    });

    new Timer(Duration(milliseconds: 400), () {
      setState(() {
        leftEnabled = false;
        leftDiceNumber = this.getDiceValue(leftDiceNumber);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ShakeAnimatedWidget(
              duration: Duration(milliseconds: 200),
              enabled: leftEnabled,
              curve: Curves.easeOut,
              shakeAngle: Rotation.deg(z: leftEnabled ? 30 : 0),
              child: FlatButton(
                onPressed: this.handleLeftDiceUpdate,
                child: Image.asset("images/dice$leftDiceNumber.png"),
              ),
            ),
          ),
          Expanded(
            child: ShakeAnimatedWidget(
              duration: Duration(milliseconds: 200),
              shakeAngle: Rotation.deg(z: rightEnabled ? 30 : 0),
              enabled: rightEnabled,
              child: FlatButton(
                onPressed: this.handleRightDiceUpdate,
                child: Image.asset("images/dice$rightDiceNumber.png"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
