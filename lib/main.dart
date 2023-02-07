import 'package:flutter/material.dart';
import 'package:flutter_app/forecast/app_bar.dart';
import 'package:flutter_app/forecast/background/background_with_rings.dart';
import 'package:flutter_app/forecast/week_drawer.dart';
import 'package:flutter_app/generic_widgets/sliding_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>  with SingleTickerProviderStateMixin {

  late OpenableController openableController;
  String selectedDay = "Monday, August 26";

  @override
  void initState() {
    super.initState();

    openableController = new OpenableController(
      vsync: this,
      openDuration: const Duration(milliseconds: 250),
    )
      ..addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          new BackgroundWithRings(),

          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: ForecastAppBar(
              onDrawerArrowTap: openableController.open,
              selectedDay: selectedDay,
            ),
          ),

          SlidingDrawer(
            openableController: openableController,
            drawer: WeekDrawer(
              onDaySelected: (String title) {
                setState(() {
                  selectedDay = title.replaceAll("\n", ", ");
                });
                openableController.close();
              },
            ),
          ),
        ],
      ),
    );
  }

}