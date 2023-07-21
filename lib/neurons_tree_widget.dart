library neurons_tree_widget;

import 'package:flutter/material.dart';
import 'package:neurons_tree_widget/neuron_links_custom_painter.dart';

class NeuronsTreeWidget extends StatelessWidget {
  final double neuronDiameter;
  final List<List<bool>> data;
  final double layersSpacing;
  final double neuronSpacing;
  final double? borderWidth;
  final Color? linkColor;
  final Color? activedNeuronColor;
  final double linkStrokeWidth;
  final double linkStrokeWidthEnabled;
  final Axis orientation;
  const NeuronsTreeWidget({
    super.key,
    required this.data,
    this.layersSpacing = 50,
    this.neuronSpacing = 20,
    this.linkColor,
    this.borderWidth,
    this.activedNeuronColor,
    this.neuronDiameter = 50,
    this.linkStrokeWidth = 1,
    this.linkStrokeWidthEnabled = 1.5,
    this.orientation = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          painter: NeuronLinksCustomPainter(
            data: data,
            diameter: neuronDiameter,
            lineColor: linkColor,
            linkStrokeWidth: linkStrokeWidth,
            linkStrokeWidthEnabled: linkStrokeWidthEnabled,
            orientation: orientation,
          ),
          child: orientation == Axis.vertical
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: data
                      .map(
                        (e) => _buildLayerRow(
                            e, data.indexOf(e) == data.length - 1),
                      )
                      .toList(),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: data
                      .map(
                        (e) => _buildLayerColumn(
                            e, data.indexOf(e) == data.length - 1),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }

  Widget _buildLayerColumn(List<bool> data, bool isLast) {
    return Padding(
      padding: EdgeInsets.only(right: isLast ? 0 : layersSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: data.map<Widget>((e) {
          return _buildNeuron(
            e,
            EdgeInsets.only(bottom: neuronSpacing),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLayerRow(List<bool> data, bool isLast) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : layersSpacing),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: data.map<Widget>((e) {
          return _buildNeuron(e, EdgeInsets.only(right: neuronSpacing));
        }).toList(),
      ),
    );
  }

  Widget _buildNeuron(bool e, EdgeInsets edgeInsets) {
    return Container(
      width: neuronDiameter,
      height: neuronDiameter,
      margin: edgeInsets,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(neuronDiameter / 2),
        border: Border.all(
          width: borderWidth ?? neuronDiameter * 0.08,
          color: Colors.black.withOpacity(e ? 1.0 : 0.5),
        ),
        color: Colors.white,
      ),
      child: Container(
        margin: EdgeInsets.all(borderWidth ?? neuronDiameter * 0.08),
        decoration: BoxDecoration(
          color: e ? activedNeuronColor ?? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(neuronDiameter / 2),
        ),
      ),
    );
  }
}
