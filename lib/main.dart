import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'consts/consts.dart';

import 'provider/callprovider.dart';
import 'provider/homescreenprovider.dart';
import 'screens/callhostscreen.dart';
import 'screens/faceverficationscreen.dart';
import 'screens/homescreen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // status bar color
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark));
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await FaceCamera.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomeScreenProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => CallProvider(),
          ),
        ],
        builder: (context, child) {
          removesplash();
          return const MaterialApp(
              themeMode: ThemeMode.system,
              debugShowCheckedModeBanner: false,
              title: Consts.appName,
              home: FaceVerificatuonScreen());
        });
  }
}

void removesplash() async {
  return await Future.delayed(const Duration(seconds: 3), () {
    FlutterNativeSplash.remove();
  });
}
