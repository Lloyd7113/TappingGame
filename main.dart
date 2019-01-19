import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(MyApp());

const oneSec = const Duration(seconds:1);
Timer gameTimer;
String clockText = '';
int time = 60;

int points = 0;
int greenRarity = 1;
int blockState = 0;

String fileLocation = 'assets/green.png';
BuildContext bc1;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Tapping Game',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title = 'The Tapping Game';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                'assets/tappinggamelogo.png',
            ),

            RaisedButton(
                child: new Text(
                  'Begin',
                  style: TextStyle(
                    fontFamily: 'Courier',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                color: Colors.amber,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DifficultySelector())
                  );
                },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class DifficultySelector extends StatefulWidget {
  final String title = 'The Tapping Game';

  @override
  DiffState createState() => DiffState();
}

class DiffState extends State<DifficultySelector> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: new Text(
                'Easy',
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              color: Colors.green,
              onPressed: () {
                bc1 = context;
                play(1);
              },
            ),
            RaisedButton(
              child: new Text(
                'Difficult',
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              color: Colors.red,
              onPressed: () {
                bc1 = context;
                play(2);
              },
            ),
            RaisedButton(
              child: new Text(
                'EXTREME',
                style: TextStyle(
                  fontFamily: 'Impact',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              color: Colors.black,
              onPressed: () {
                bc1 = context;
                play(3);
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Game extends StatefulWidget {
  final String title = 'The Tapping Game';

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    gameTimer = new Timer.periodic(oneSec, (Timer t) => tick);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              fileLocation,
              height: 200,
              width: 200,
            ),

            Text(
              '\n',
            ),

            RaisedButton(
                child: new Text('Attack'),
                onPressed: () {
                  if (blockState == 1){
                    setState(() {
                      points += 1;
                    });
                  }else{
                    setState(() {
                      points -= 1;
                    });
                  }
                  setState(() {
                    newBlock();
                  });
                },
            ),

            RaisedButton(
              child: new Text('Skip'),
              onPressed: () {
                if (blockState == 1){
                  setState(() {
                    points -= 1;
                  });
                }
                setState(() {
                  newBlock();
                });
              },
            ),

            Text(
              'Points: ' + points.toString(),
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),

            Text(
              'Time Reamaining: ' + time.toString(),
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Courier',
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void tick(){
    setState(() {
      time -= 1;
    });
  }
}

void play(int d){
  if (d == 1){
    greenRarity = 10;
  } else if (d == 2){
    greenRarity = 5;
  } else if (d == 3){
    greenRarity = 1;
  }

  Navigator.push(
      bc1,
      MaterialPageRoute(builder: (bc1) => Game())
  );
}

void newBlock(){
  var rng = new Random();
  int l = rng.nextInt(21);
  if (l <= greenRarity){
    fileLocation = 'assets/green.png';
    blockState = 1;
  }else{
    fileLocation = 'assets/red.png';
    blockState = 2;
  }
}
