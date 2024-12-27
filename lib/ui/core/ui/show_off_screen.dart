import 'package:flutter/material.dart';

void showOffScreen({
  required Widget dialog,
  required bool isPortrait,
  required BuildContext context,
}) {
  if (isPortrait) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: dialog,
          ),
        );
      },
    );
  } else {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      scrollControlDisabledMaxHeightRatio: 11 / 16,
      elevation: 0,
      isDismissible: false,
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: dialog,
        );
      },
    );
  }
}
