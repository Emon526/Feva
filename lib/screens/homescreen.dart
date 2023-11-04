import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider/callprovider.dart';
import '../utils/utils.dart';
import '../widgets/customsnackbar.dart';
import '../widgets/cutombutton.dart';
import 'faceverficationscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;
    return Consumer<CallProvider>(
        builder: (BuildContext context, CallProvider value, Widget? child) {
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      return WillPopScope(
        onWillPop: () async {
          return await Utils(context)
              .onWillPop(); // Allow popping the current route
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset('assets/icon.png'),
                  CustomButton(
                    ontap: () {
                      value.hiringclicked = true;
                      value.lookingjobsclicked = false;
                    },
                    buttontext: 'i\'m hiring',
                    buttoncolor: value.hiringclicked ? null : Colors.white,
                    iconData: Icons.abc,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  CustomButton(
                    ontap: () {
                      value.lookingjobsclicked = true;
                      value.hiringclicked = false;
                    },
                    buttontext: 'Looking for jobs',
                    buttoncolor: value.lookingjobsclicked ? null : Colors.white,
                    iconData: Icons.access_alarm_outlined,
                  ),
                  const Spacer(),
                  CustomButton(
                    ontap: () {
                      if (value.hiringclicked) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FaceVerificatuonScreen(),
                          ),
                        );
                      } else if (value.lookingjobsclicked) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const FaceVerificatuonScreen(),
                          ),
                        );
                      } else {
                        CustomSnackbar.show(
                            context: context,
                            message: 'Please Choose an Option',
                            snackbarColor: Colors.red);
                      }
                    },
                    buttontext: 'Continue →',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
