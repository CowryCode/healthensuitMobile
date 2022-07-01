import 'package:flutter/material.dart';
import 'package:healthensuite/utilities/constants.dart';

class OptionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final double width;
  final Function? buttonEvent;
// Test Comment
  const OptionButton({Key? key, required this.text, required this.icon, required this.width, this.buttonEvent}) : super(key: key);
//This is a second sample comment today.
  @override
  Widget build(BuildContext context) {
    final ButtonStyle textButtonStyle = TextButton.styleFrom(
      backgroundColor: appBackgroundColor,
      primary: Colors.white.withAlpha(55),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    );
    return Container(
      width: width,
      child: TextButton(
          style: textButtonStyle,
          // color: appBackgroundColor,
          // splashColor: Colors.white.withAlpha(55),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          onPressed: buttonEvent as void Function()?,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: appItemColorWhite,
              ),
              SizedBox(width: 10,),
              Text(
                text,
                style: TextStyle(color: appItemColorWhite),
              )
            ],
          )),
    );
  }
}