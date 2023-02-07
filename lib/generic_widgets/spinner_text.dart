import 'package:flutter/material.dart';

class SpinnerText extends StatefulWidget {
  final String text;

  SpinnerText({
    this.text = "",
  });

  @override
  _SpinnerTextState createState() => _SpinnerTextState();
}

class _SpinnerTextState extends State<SpinnerText>
    with SingleTickerProviderStateMixin {
  String topText = "";
  String bottomText = "";
  late AnimationController _spinAnimationController;
  late Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    bottomText = widget.text;

    _spinAnimation = new AnimationController(
      duration: const Duration(milliseconds: 750),
      vsync: this,
    )
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            bottomText = topText;
            topText = "";
            _spinAnimationController.value = 0.0;
          });
        }
      });

    _spinAnimation = new CurvedAnimation(
      parent: _spinAnimationController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _spinAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SpinnerText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.text != oldWidget.text) {
      // Need to spin new value.
      topText = widget.text;
      //TODO: run animation
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FractionalTranslation(
          translation: Offset(0.0, _spinAnimation.value - 1.0),
          child: Text(
            topText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
        FractionalTranslation(
          translation: Offset(0.0, _spinAnimation.value),
          child: Text(
            bottomText,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
