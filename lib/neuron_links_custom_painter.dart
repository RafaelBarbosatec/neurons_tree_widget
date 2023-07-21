import 'package:flutter/material.dart';

class NeuronLinksCustomPainter extends CustomPainter {
  Paint linepaint = Paint()..color = Colors.black;
  final List<List<bool>> data;
  final Color? lineColor;
  final double diameter;
  final double linkStrokeWidth;
  final double linkStrokeWidthEnabled;
  final Axis orientation;
  int maxCount = 0;
  double radius = 0;
  NeuronLinksCustomPainter({
    required this.data,
    required this.diameter,
    this.lineColor,
    this.linkStrokeWidth = 1,
    this.linkStrokeWidthEnabled = 1.5,
    this.orientation = Axis.horizontal,
  }) {
    radius = diameter / 2;
    maxCount = data.fold(0, (previousValue, element) {
      return previousValue < element.length ? element.length : previousValue;
    });
  }

  @override
  void paint(Canvas canvas, Size size) {
    List<List<NeuronLink>> pointsLayer = [];

    if (orientation == Axis.vertical) {
      pointsLayer = _createPointsInVertical(size);
    } else {
      pointsLayer = _createPointsInHorizontal(size);
    }

    for (int i = 0; i < pointsLayer.length; i++) {
      if (i < pointsLayer.length - 1) {
        for (var p1 in pointsLayer[i]) {
          for (var p2 in pointsLayer[i + 1]) {
            Color color = p1.enabled && p2.enabled
                ? lineColor ?? Colors.red
                : Colors.black.withOpacity(0.2);
            double stroke = p1.enabled && p2.enabled
                ? linkStrokeWidthEnabled
                : linkStrokeWidth;
            canvas.drawLine(
              p1.offset,
              p2.offset,
              linepaint
                ..color = color
                ..strokeWidth = stroke,
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant NeuronLinksCustomPainter oldDelegate) {
    return data != oldDelegate.data;
  }

  List<List<NeuronLink>> _createPointsInVertical(Size size) {
    List<List<NeuronLink>> pointsLayer = [];
    double height = radius;
    double spaceH = ((size.height - diameter) / (data.length - 1));
    double spaceMaxW = size.width / maxCount;
    for (var layer in data) {
      double spaceW = size.width / layer.length;
      if (layer.length < maxCount) {
        spaceW = size.width / maxCount;
      }

      double wight = radius + (size.width - (layer.length * spaceMaxW)) / 2;

      List<NeuronLink> layerL = [];
      for (int i = 1; i <= layer.length; i++) {
        layerL.add(NeuronLink(Offset(wight, height), layer[i - 1]));
        wight += spaceW;
      }
      pointsLayer.add(layerL);
      height += spaceH;
    }
    return pointsLayer;
  }

  List<List<NeuronLink>> _createPointsInHorizontal(Size size) {
    List<List<NeuronLink>> pointsLayer = [];
    double wight = radius;
    double spaceW = ((size.width - diameter) / (data.length - 1));

    double spaceMaxH = size.height / maxCount;
    for (var layer in data) {
      double spaceH = size.height / layer.length;
      if (layer.length < maxCount) {
        spaceH = size.height / maxCount;
      }

      double height = radius + (size.height - (layer.length * spaceMaxH)) / 2;

      List<NeuronLink> layerL = [];
      for (int i = 1; i <= layer.length; i++) {
        layerL.add(NeuronLink(Offset(wight, height), layer[i - 1]));
        height += spaceH;
      }
      pointsLayer.add(layerL);
      wight += spaceW;
    }
    return pointsLayer;
  }
}

class NeuronLink {
  Offset offset;
  bool enabled;
  NeuronLink(
    this.offset,
    this.enabled,
  );
}
