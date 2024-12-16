import 'package:flutter/material.dart';

showOffScreen({
  required Widget dialog,
  required bool isPortrait,
  required BuildContext context,
}) {
  if (isPortrait) {
    showDialog(
      context: context,
      // backgroundColor: Colors.transparent,
      // scrollControlDisabledMaxHeightRatio: 11 / 16,
      // elevation: 0,
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
      builder: (context) {
        return Material(
          color: Colors.transparent,
          child: dialog,
        );
      },
    );
  }
}
