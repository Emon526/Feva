import 'package:flutter/material.dart';

import '../consts/consts.dart';

class CustomSnackbar {
  static show({
    required context,
    required String message,
    required Color snackbarColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: snackbarColor,
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.defaultBorderRadius),
        ),
        // width:
        //     MediaQuery.of(context).size.width * 0.9, // adjust width as needed
        // margin: EdgeInsets.symmetric(
        //   horizontal: MediaQuery.of(context).size.width *
        //       0.1, // adjust horizontal margin as needed
        //   vertical: 16,
        // ),
      ),
    );
  }
}
