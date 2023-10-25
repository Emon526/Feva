import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:feva/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider/callprovider.dart';
import 'homescreen.dart';

class FaceVerificatuonScreen extends StatelessWidget {
  const FaceVerificatuonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return WillPopScope(
      onWillPop: () async {
        return await Utils(context)
            .onWillPop(); // Allow popping the current route
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<CallProvider>(
          builder: (BuildContext context, CallProvider value, Widget? child) =>
              Builder(
            builder: (context) {
              if (value.image != null) {
                return Center(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.file(
                        value.image!,
                        width: double.maxFinite,
                        fit: BoxFit.fitWidth,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => value.image = null,
                            child: const Text(
                              'Capture Again',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            ),
                            child: const Text(
                              'Confirm Image',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              }
              return SmartFaceCamera(
                  autoCapture: true,
                  defaultCameraLens: CameraLens.front,
                  onCapture: (File? image) {
                    value.image = image;
                  },
                  onFaceDetected: (Face? face) {
                    //Do something
                  },
                  indicatorShape: IndicatorShape.circle,
                  messageBuilder: (context, face) {
                    if (face == null) {
                      return _message('Place your face in the camera');
                    }
                    if (!face.wellPositioned) {
                      return _message('Center your face in the square');
                    }
                    return const SizedBox.shrink();
                  });
            },
          ),
        ),
      ),
    );
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
      );
}
