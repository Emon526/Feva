import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/consts.dart';
import '../provider/callprovider.dart';

import '../utils/utils.dart';
import '../widgets/dialuserwidget.dart';

class CallHostScreen extends StatelessWidget {
  const CallHostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CallProvider>(
      builder: (BuildContext context, CallProvider value, Widget? child) =>
          Scaffold(
        key: value.scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                DialUserPic(image: context.read<CallProvider>().image!),
                SizedBox(
                  height: Utils(context).getScreenSize.height * 0.1,
                ),
                // Text(
                //   value.hiringclicked
                //       ? "Looking For ${value.skill} from ${value.country}"
                //       : "Looking For ${value.skill} Project for ${value.country}",
                //   style: const TextStyle(
                //     color: Consts.secondaryColor,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                Text(
                  value.isRemoteJoined
                      ? "Connected"
                      : value.isfatchedtoken
                          ? "Searching"
                          : "Connecting",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    value.isRemoteJoined
                        ? RoundedButton(
                            iconSrc: value.enableSpeakerphone
                                ? Icons.volume_up_outlined
                                : Icons.volume_off_outlined,
                            press: () => value.isJoined
                                ? value.switchSpeakerphone()
                                : null,
                            color: Consts.secondaryColor,
                            iconColor: Colors.white,
                          )
                        : const SizedBox(),
                    RoundedButton(
                      iconSrc: Icons.call_end_outlined,
                      press: () async {
                        await value
                            .leaveChannel()
                            .then((value) => Navigator.pop(context));
                      },
                      color: Colors.red,
                      iconColor: Colors.white,
                    ),
                    value.isRemoteJoined
                        ? RoundedButton(
                            iconSrc: value.openMicrophone
                                ? Icons.mic_rounded
                                : Icons.mic_off_rounded,
                            press: () => value.isJoined
                                ? value.switchMicrophone()
                                : null,
                            color: Consts.secondaryColor,
                            iconColor: Colors.white,
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    this.size = 64,
    required this.iconSrc,
    this.color = Consts.primaryColor,
    this.iconColor = Colors.black,
    required this.press,
  });

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
    super.key,
    required this.iconSrc,
    required this.text,
    required this.press,
  });

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
