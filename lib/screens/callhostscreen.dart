import 'package:feva/provider/callprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/consts.dart';
import '../provider/homescreenprovider.dart';
import '../utils/utils.dart';
import '../widgets/dialuserwidget.dart';

class CallHostScreen extends StatelessWidget {
  const CallHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              DialUserPic(image: context.read<CallProvider>().image!.path),
              SizedBox(
                height: Utils(context).getScreenSize.height * 0.1,
              ),
              Text(
                context.read<HomeScreenProvider>().hiringclicked
                    ? "Looking For Freelancer"
                    : "Looking For Client",
                style: const TextStyle(
                  color: Consts.secondaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              // Wrap(
              //   alignment: WrapAlignment.spaceBetween,
              //   children: [
              //     DialButton(
              //       iconSrc: "assets/logo.png",
              //       text: "Audio",
              //       press: () {},
              //     ),
              //     DialButton(
              //       iconSrc: "assets/logo.png",
              //       text: "Microphone",
              //       press: () {},
              //     ),
              //     DialButton(
              //       iconSrc: "assets/logo.png",
              //       text: "Video",
              //       press: () {},
              //     ),
              //     DialButton(
              //       iconSrc: "assets/logo.png",
              //       text: "Message",
              //       press: () {},
              //     ),
              //     DialButton(
              //       iconSrc: "assets/logo.png",
              //       text: "Add contact",
              //       press: () {},
              //     ),
              //     DialButton(
              //       iconSrc: "assets/logo.png",
              //       text: "Voice mail",
              //       press: () {},
              //     ),
              //   ],
              // ),
              // VerticalSpacing(),
              RoundedButton(
                iconSrc: Icons.call_end_outlined,
                press: () {
                  Navigator.pop(context);
                },
                color: Colors.red,
                iconColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.size = 64,
    required this.iconSrc,
    this.color = Consts.primaryColor,
    this.iconColor = Colors.black,
    required this.press,
  }) : super(key: key);

  final double size;
  final IconData iconSrc;
  final Color color, iconColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    double buttonSize = size;

    return Material(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(buttonSize / 2),
      ),
      child: InkWell(
        onTap: press,
        borderRadius: BorderRadius.circular(buttonSize / 2),
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Center(
            child: Icon(iconSrc, color: iconColor),
          ),
        ),
      ),
    );
  }
}

class DialButton extends StatelessWidget {
  const DialButton({
    Key? key,
    required this.iconSrc,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String iconSrc, text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: TextButton(
        onPressed: press,
        child: Column(
          children: [
            Image.asset(
              iconSrc,
              color: Colors.white,
              height: 36,
            ),
            // VerticalSpacing(of: 5),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            )
          ],
        ),
      ),
    );
  }
}
