import 'package:flutter/material.dart';
import 'package:healthensuite/utilities/constants.dart';

class SimpleAlertWidget extends StatelessWidget{
  final String? msg;
  final String? headerTxt;

  SimpleAlertWidget({this.headerTxt, this.msg});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Text("");
  }
}