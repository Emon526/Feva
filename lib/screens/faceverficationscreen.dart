import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/consts.dart';
import '../provider/callprovider.dart';
import '../utils/utils.dart';
import 'hiringformscreen.dart';
import 'lookingforjobsscreen.dart';

class FaceVerificatuonScreen extends StatelessWidget {
  const FaceVerificatuonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<CallProvider>(
        builder: (BuildContext context, CallProvider value, Widget? child) =>
            Builder(
          builder: (context) {
            if (value.image != null) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.141), // Mirror horizontally
                    child: Image.file(
                      value.image!,
                      // width: Utils(context).getScreenSize.width,
                      height: Utils(context).getScreenSize.height,
                      width: double.maxFinite,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Consts.primaryColor)),
                        onPressed: () => value.image = null,
                        child: const Text(
                          'Capture Again',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        ),
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Consts.primaryColor)),
                        onPressed: () {
                          if (value.hiringclicked) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HiringFormScreen(),
                              ),
                            );
                          }
                          if (value.lookingjobsclicked) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LookingForJobsScreen(),
                              ),
                            );
                          }
                        },
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
              );
            }

            return SmartFaceCamera(
                // autoCapture: true,
                imageResolution: ImageResolution.high,
                defaultFlashMode: CameraFlashMode.off,
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
                    return _message('Center your face in the Circle');
                  }
                  return const SizedBox.shrink();
                });
          },
        ),
      ),
    );
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            )),
      );
}
