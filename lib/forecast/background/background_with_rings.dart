import 'package:flutter/cupertino.dart';

class BackgroundWithRings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[

        Image.asset(
          "assets/back_rain.jpg",
          fit: BoxFit.cover,
        ),

        ClipOval(
          clipper: CircleClipper(
            radius:  140.0,
            offset: const Offset(40.0, 0.0),
          ),
          child: Image.asset(
            "assets/back_rain.jpg",
            fit: BoxFit.cover,
          ),
        ),

        CustomPaint(
          painter: WhiteCircleCutoutPainter(
            centerOffset: const Offset(40.0, 0.0),
            circles: [
              Circle(radius: 140.0, alpha: 0x10),
              Circle(radius: 140.0 + 15, alpha: 0x28),
              Circle(radius: 140.0 + 30, alpha: 0x38),
              Circle(radius: 140.0 + 75, alpha: 0x50),
            ],
          ),
          child: Container(),
        ),
      ],
    );
  }
}

class CircleClipper extends CustomClipper<Rect>{

  final double radius;
  final Offset offset;

  CircleClipper({
    required this.radius,
    this.offset = const Offset(0.0, 0.0),
  });

  @override
  Rect getClip(Size size) {
    return new Rect.fromCircle(
      center: Offset(0.0, size.height / 2) + offset,
      radius: radius,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }

}

class WhiteCircleCutoutPainter extends CustomPainter {

  final Color overlayColor = const Color(0xFFAABBAA);

  final List<Circle> circles;
  final Offset centerOffset;
  final Paint whitePaint;
  final Paint borderPaint;

  WhiteCircleCutoutPainter({
    this.circles = const [],
    this.centerOffset = const Offset(0.0, 0.0),
  })
      : whitePaint = new Paint(),
        borderPaint = new Paint() {
    borderPaint
      ..color = const Color(0x10FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 1; i < circles.length; i++) {
      _maskCircle(canvas, size, circles[i - 1].radius);

      whitePaint.color = overlayColor.withAlpha(circles[i - 1].alpha);

      // Fill circle
      canvas.drawCircle(
          Offset(0.0, size.height / 2) + centerOffset,
          circles[i].radius,
          whitePaint
      );

      // Draw circle bevel
      canvas.drawCircle(
        Offset(0.0, size.height / 2) + centerOffset,
        circles[i - 1].radius,
        borderPaint,
      );
    }

    // Mask the area of the final circle
    _maskCircle(canvas, size, circles.last.radius);

    // Draw an overlay that files the rest of the screen.
    whitePaint.color = overlayColor.withAlpha(circles.last.alpha);
    canvas.drawRect(
      new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      whitePaint,
    );

    // Draw the bevel for the final circle.
    canvas.drawCircle(
      Offset(0.0, size.height / 2) + centerOffset,
      circles.last.radius,
      borderPaint,
    );
  }

  _maskCircle(Canvas canvas, Size size, double radius) {
    Path clippedCircle = new Path();
    clippedCircle.fillType = PathFillType.evenOdd;
    clippedCircle.addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height));

    clippedCircle.addOval(
      new Rect.fromCircle(
        center: new Offset(0.0, size.height / 2) + centerOffset,
        radius: radius,
      ),
    );
    canvas.clipPath(clippedCircle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}

class Circle {
  final double radius;
  final int alpha;

  Circle({
    required this.radius,
    this.alpha = 0xFF,
  });

}