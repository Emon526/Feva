import 'package:flutter/material.dart';

import '../consts/consts.dart';
import '../utils/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.ontap,
    required this.buttontext,
    this.buttoncolor,
    this.iconData,
  });
  final Function()? ontap;
  final String buttontext;
  final Color? buttoncolor;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buttoncolor != null
          ? BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(Consts.defaultBorderRadius))
          : null,
      child: Material(
        color: buttoncolor ?? Consts.primaryColor,
        borderRadius: BorderRadius.circular(Consts.defaultBorderRadius),
        child: InkWell(
          onTap: ontap,
          borderRadius: BorderRadius.circular(Consts.defaultBorderRadius),
          child: Center(
            heightFactor: iconData != null ? 2 : 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                iconData != null
                    ? Icon(
                        iconData,
                        color:
                            buttoncolor != null ? Colors.black : Colors.white,
                      )
                    : const SizedBox(),
                SizedBox(width: Utils(context).getScreenSize.height * 0.01),
                Text(
                  buttontext,
                  style: TextStyle(
                    color: buttoncolor != null ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
