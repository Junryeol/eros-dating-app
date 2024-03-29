import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;

class SpiderChart extends StatelessWidget {
  final List<List<double>> data;
  final double maxValue;
  final List<Color> colors;
  final List<String> labels;
  final decimalPrecision;
  final Size size;
  final double fallbackHeight;
  final double fallbackWidth;

  SpiderChart({
    Key key,
    @required this.data,
    @required this.colors,
    @required this.maxValue,
    this.labels,
    this.size = Size.infinite,
    this.decimalPrecision = 0,
    this.fallbackHeight = 200,
    this.fallbackWidth = 200,
  })  : assert(data[0].length == colors.length,
  'Length of data and color lists must be equal'),
        assert(labels != null ? data[0].length == labels.length : true,
        'Length of data and labels lists must be equal'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: fallbackWidth,
      maxHeight: fallbackHeight,
      child: CustomPaint(
        size: size,
        painter: SpiderChartPainter(data, maxValue, colors, labels, decimalPrecision),
      ),
    );
  }
}

class SpiderChartPainter extends CustomPainter {
  final List<List<double>> data;
  final double maxNumber;
  final List<Color> colors;
  final List<String> labels;
  final decimalPrecision;

  final Paint spokes = Paint()..color = Colors.grey;

  final Paint fill1 = Paint()
    ..color = Color.fromARGB(179, 152, 131, 225)
    ..style = PaintingStyle.fill;

  final Paint fill2 = Paint()
    ..color = Color.fromARGB(179, 255, 175, 207)
    ..style = PaintingStyle.fill;

  final Paint stroke = Paint()
    ..color = Color.fromARGB(255, 50, 50, 50)
    ..style = PaintingStyle.stroke;

  SpiderChartPainter(this.data, this.maxNumber, this.colors, this.labels, this.decimalPrecision);

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = size.center(Offset.zero);

    double angle = (2 * pi) / data[0].length;

    var outerPoints = <Offset>[];

    for (var i = 0; i < data[0].length; i++) {
      var x = center.dy * cos(angle * i - pi / 2);
      var y = center.dy * sin(angle * i - pi / 2);

      outerPoints.add(Offset(x, y) + center);
    }

    if (this.labels != null) {
      paintLabels(canvas, center, outerPoints, this.labels, size);
    }

    paintGraphOutline(canvas, center, outerPoints);

    for (var j = 0; j < data.length; j++) {
      var dataPoints = <Offset>[];

      for (var i = 0; i < data[0].length; i++) {
        var scaledRadius = (data[j][i] / maxNumber) * center.dy;
        var x = scaledRadius * cos(angle * i - pi / 2);
        var y = scaledRadius * sin(angle * i - pi / 2);

        dataPoints.add(Offset(x, y) + center);
      }

      if (j % 2 == 0)
        paintDataLines(canvas, dataPoints, fill1);
      else
        paintDataLines(canvas, dataPoints, fill2);
      // paintDataPoints(canvas, dataPoints);
      // paintText(canvas, center, dataPoints, data);
    }
  }

  void paintDataLines(Canvas canvas, List<Offset> points, Paint fill) {
    Path path = Path()..addPolygon(points, true);

    canvas.drawPath(
      path,
      fill,
    );

    // canvas.drawPath(path, stroke);
  }

  void paintDataPoints(Canvas canvas, List<Offset> points) {
    for (var i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 4.0, Paint()..color = colors[i]);
    }
  }

  void paintText(
      Canvas canvas, Offset center, List<Offset> points, List<double> data) {
    var textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (var i = 0; i < points.length; i++) {
      String s = data[i].toStringAsFixed(decimalPrecision);
      textPainter.text =
          TextSpan(text: s, style: TextStyle(color: Colors.black));
      textPainter.layout();
      if (points[i].dx < center.dx) {
        textPainter.paint(
            canvas, points[i].translate(-(textPainter.size.width + 5.0), 0));
      } else if (points[i].dx > center.dx) {
        textPainter.paint(canvas, points[i].translate(5.0, 0));
      } else if (points[i].dy < center.dy) {
        textPainter.paint(
            canvas, points[i].translate(-(textPainter.size.width / 2), -20));
      } else {
        textPainter.paint(
            canvas, points[i].translate(-(textPainter.size.width / 2), 4));
      }
    }
  }

  void paintGraphOutline(Canvas canvas, Offset center, List<Offset> points) {
    points.add(points[0]);

    for (var mash = 2.0; mash <= 5; mash++) {
      for (var i = 0; i < points.length; i++) {
        points[i] = (points[i] - center) * (mash / 5) + center;
        canvas.drawLine(center, points[i], spokes);
      }

      canvas.drawPoints(PointMode.polygon, points, spokes);

      for (var i = 0; i < points.length; i++) {
        points[i] = (points[i] - center) / (mash / 5) + center;
      }
    }
    canvas.drawCircle(center, 2, spokes);
  }

  void paintLabels(
      Canvas canvas, Offset center, List<Offset> points, List<String> labels, Size size) {
    var textPainter = TextPainter(textDirection: TextDirection.ltr);
    var textStyle =
    TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold, fontSize: size.width/40 + 7);

    for (var i = 0; i < points.length; i++) {
      textPainter.text = TextSpan(text: labels[i], style: textStyle);
      textPainter.layout();
      var dx = points[i].dx, dy = points[i].dy;
      var cx = center.dx, cy = center.dy;
      var tx = 0.0, ty = 0.0;
      if (dx < cx) {
        tx -= (textPainter.size.width + 5.0);
        ty -= textPainter.size.height / 2;
      } else if (dx > cx) {
        tx += 5.0;
        ty -= textPainter.size.height / 2;
      } else {
        tx -= textPainter.size.width / 2;
        ty = dy < cy ? -(textPainter.size.height + 5.0) : 5.0;
      }
      textPainter.paint(canvas, points[i].translate(tx, ty));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
