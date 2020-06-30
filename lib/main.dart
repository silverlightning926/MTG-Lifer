import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTG Lifer',
      theme: ThemeData.dark(),
      home: MainPage(),
    );
  }
}

double primaryButtonSize = 40;
double secondaryButtonSize = 30;

double barButtonSize = 27;
double refreshPercentageAddition = 45;

List<Color> bgColors = [
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.yellow,
  Color(0xFFC8C8C8),
  Color(0xFF353535),
];

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _player1Counter = 20;
  int _player2Counter = 20;

  int _p1ColorIndex = 0;
  int _p2ColorIndex = 1;

  updatePlayer1(int newValue) {
    setState(() {
      _player1Counter = newValue;
    });
  }

  updatePlayer2(int newValue) {
    setState(() {
      _player2Counter = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          LifeCounter(
            flipped: false,
            color: bgColors[_p2ColorIndex],
            life: _player2Counter,
            updateValue: updatePlayer2,
          ),
          Container(
            height: 70,
            color: Color(0xFF252525),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _player2Counter = 20;
                    });
                  },
                  iconSize: barButtonSize,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_upward),
                  onPressed: () {
                    setState(() {
                      if (_p2ColorIndex + 1 < bgColors.length) {
                        _p2ColorIndex++;
                      } else {
                        _p2ColorIndex = 0;
                      }
                    });
                  },
                  iconSize: barButtonSize,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: Container(
                    width: 5,
                    decoration: BoxDecoration(
                      color: Color(0xFF404040),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.autorenew),
                  onPressed: () {
                    setState(() {
                      _player1Counter = 20;
                      _player2Counter = 20;
                    });
                  },
                  iconSize: barButtonSize +
                      ((barButtonSize * refreshPercentageAddition) / 100),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 13),
                  child: Container(
                    width: 5,
                    decoration: BoxDecoration(
                      color: Color(0xFF404040),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_downward),
                  onPressed: () {
                    setState(() {
                      if (_p1ColorIndex + 1 < bgColors.length) {
                        _p1ColorIndex++;
                      } else {
                        _p1ColorIndex = 0;
                      }
                    });
                  },
                  iconSize: barButtonSize,
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {
                      _player1Counter = 20;
                    });
                  },
                  iconSize: barButtonSize,
                ),
              ],
            ),
          ),
          LifeCounter(
            flipped: true,
            color: bgColors[_p1ColorIndex],
            life: _player1Counter,
            updateValue: updatePlayer1,
          ),
        ],
      ),
    );
  }
}

class LifeCounter extends StatelessWidget {
  final bool flipped;
  final Color color;
  final int life;
  final Function updateValue;

  const LifeCounter({
    Key key,
    this.flipped,
    this.color,
    this.life,
    this.updateValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Transform.rotate(
        angle: flipped != null ? flipped ? 0 : pi : 0,
        child: Container(
          color: color != null ? color : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    iconSize: secondaryButtonSize,
                    color: Colors.black,
                    onPressed: () {
                      updateValue(life - 5);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: primaryButtonSize,
                    color: Colors.black,
                    onPressed: () {
                      updateValue(life - 1);
                    },
                  ),
                  Text(
                    "$life",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 105,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    iconSize: primaryButtonSize,
                    color: Colors.black,
                    onPressed: () {
                      updateValue(life + 1);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    iconSize: secondaryButtonSize,
                    color: Colors.black,
                    onPressed: () {
                      updateValue(life + 5);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
