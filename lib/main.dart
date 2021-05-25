import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter timer in HH:MM:SS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter timer in HH:MM:SS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late Timer timer;

  int hours = 1; //amount of hours
  int minutes = 30; //amount of minutes
  int seconds = 30; //amount of seconds

  var currentHours;
  var currentMinutes;
  var currentSeconds;
  
  var totalSeconds;
  
  @override void initState() {
    timer = Timer(Duration(seconds: 1), () {}); //initiate Timer
    totalSeconds = (hours*3600)+(minutes*60)+seconds; //set total timer time in seconds
    currentHours = hours; //set default hours on init
    currentMinutes = minutes;  //set default minutes on init
    currentSeconds = seconds;  //set default seconds on init
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: totalSeconds < (hours*3600)+(minutes*60)+seconds ? Colors.red : Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentHours.toString().padLeft(2,'0') +
                ":" +
                currentMinutes.toString().padLeft(2,'0')
                + ":" +
                currentSeconds.toString().padLeft(2,'0'),
              style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
            ),
           Padding(
             padding: const EdgeInsets.only(
                 top: 48.0),
             child: Container(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                            onPressed: startTimer,
                            tooltip: 'Start timer',
                            child: Icon(Icons.play_arrow),
                          ),
                          FloatingActionButton(
                            onPressed: pauseTimer,
                            tooltip: 'Pause timer',
                            child: Icon(Icons.pause),
                          ),
                          FloatingActionButton(
                            onPressed: resetTimer,
                            tooltip: 'Restart timer',
                            child: Icon(Icons.restart_alt_outlined),
                          ),
                        ],
                      ),
                    ),
           ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    print(totalSeconds);
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds = totalSeconds - 1;
          currentHours = totalSeconds~/3600;
          currentMinutes = (totalSeconds-(currentHours*3600))~/60;
          currentSeconds = totalSeconds - ((currentHours*3600)+(currentMinutes*60));
        } else {
          timer.cancel();
          //submit();
        }
      });
    });
  }

  void pauseTimer (){
    setState(() {
      timer.cancel();
    });
  }

  void resetTimer (){
    setState(() {
      totalSeconds = (hours*3600)+(minutes*60)+seconds;
      currentHours = hours;
      currentMinutes = minutes;
      currentSeconds = seconds;
      timer.cancel();
    });
  }
}
