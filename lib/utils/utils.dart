import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../consts/consts.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  Size get getScreenSize => MediaQuery.of(context).size;

  onWillPop() async {
    return showCustomDialog(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure?',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Consts.primaryColor),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Do you want to exit the app?',
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'No',
                    style: TextStyle(color: Consts.primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future showCustomDialog({required Widget child}) async {
    return await showCupertinoModalPopup(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.defaultBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: Consts.primaryColor,
                    size: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkPermissions() async {
    // Check if the camera and microphone permissions are granted
    final cameraStatus = await Permission.camera.status;
    final microphoneStatus = await Permission.microphone.status;

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      return; // Both camera and microphone permissions are granted.
    } else {
      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }

      if (!microphoneStatus.isGranted) {
        await Permission.microphone.request();
      }

      final updatedCameraStatus = await Permission.camera.status;
      final updatedMicrophoneStatus = await Permission.microphone.status;

      if (updatedCameraStatus.isGranted && updatedMicrophoneStatus.isGranted) {
        return; // Permissions were granted after the request.
      } else {
        // Permissions were not granted; you may want to handle this case.
        // For example, show a message to the user or disable certain features.
        if (!cameraStatus.isGranted) {
          await Permission.camera.request();
        }

        if (!microphoneStatus.isGranted) {
          await Permission.microphone.request();
        }
      }
    }
  }
}
