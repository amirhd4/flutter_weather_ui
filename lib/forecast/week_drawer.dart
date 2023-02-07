import 'package:flutter/material.dart';

class WeekDrawer extends StatelessWidget {
  final week = [
    "Tuesday\nAugust 27",
    "Wednesday\nAugust 28",
    "Thursday\nAugust 29",
    "Friday\nAugust 30",
    "Saturday\nAugust 31",
    "Sunday\nAugust 1",
    "Monday\nAugust 2"
  ];

  final Function(String title) onDaySelected;

  WeekDrawer({
    required this.onDaySelected,
  });

  List<Widget> _buildDayButtons() {
    return week.map((String title) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            onDaySelected(title);
          },
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125.0,
      height: double.infinity,
      color: const Color(0xAA234060),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 40.0,
            ),
          ),
        ]..addAll(_buildDayButtons()),
      ),
    );
  }
}
