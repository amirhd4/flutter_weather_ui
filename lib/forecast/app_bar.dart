import 'package:flutter/material.dart';
import 'package:flutter_app/generic_widgets/spinner_text.dart';

class ForecastAppBar extends StatelessWidget {

  final Function onDrawerArrowTap;
  final String selectedDay;

  ForecastAppBar({
    required this.onDrawerArrowTap,
    required this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SpinnerText(
            text: selectedDay,
          ),
          Text(
            "Sacramento",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
            size: 35.0,
          ),
          onPressed: onDrawerArrowTap(),
        ),
      ],
    );
  }
}