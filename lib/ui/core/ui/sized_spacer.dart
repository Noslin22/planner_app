import 'package:flutter/material.dart';

class SizedSpacer extends StatelessWidget {
  const SizedSpacer({
    super.key,
    required this.direction,
    required this.space,
  });

  final Axis direction;
  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: direction == Axis.horizontal ? space : null,
      height: direction == Axis.horizontal ? null : space,
    );
  }
}
