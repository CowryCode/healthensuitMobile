import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkUtilities.dart';
import 'package:healthensuite/api/networkmodels/mysleepclock.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/statemanagement/behaviourlogic.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/models/icon_button.dart';
import 'package:healthensuite/screens/sleepClock/sleep_window.dart';


class SleepClock extends StatefulWidget {

  final Function? onMenuTap;
  static final String title = 'Sleep Clock';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final Future<PatientProfilePodo>? patientProfile;
  bool timedout;

  SleepClock({Key? key, this.onMenuTap, required this.patientProfile, this.timedout: false}) : super(key: key);
 // const SleepClock({Key? key, this.onMenuTap, required this.patientProfile, this.timedout: false}) : super(key: key);

  @override
  _SleepClockState createState() => _SleepClockState();
}

class _SleepClockState extends State<SleepClock> {

  Future<SleepClockDTO>? futureMysleepClock;

  @override
  void initState() {
    super.initState();
    futureMysleepClock = ApiAccess().getMysleepClock();
  }

  @override
  Widget build(BuildContext context) {
    Future<PatientProfilePodo>? profile = widget.patientProfile;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;
    double innerPad = 10;

    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 2,patientprofile: profile,),
      appBar: AppBar(
        title: Text(SleepClock.title),
        centerTitle: true,
      ),
      body:  FutureBuilder<SleepClockDTO>(
        future: futureMysleepClock,
        builder: (BuildContext context, AsyncSnapshot<SleepClockDTO> snapshot){
          if(snapshot.hasData){
            widget.timedout = false;
            SleepClockDTO sleepclock = snapshot.data!;
            return getContent(themeData: themeData, size: size, pad: pad, sleepclock: sleepclock);
          }else{
            if(widget.timedout == true){
              Timer.periodic(Duration(seconds: timeout_duration), (timer){
                print("Timer PRE CHECK ran . . . . . . ${timer.tick}");
                if(widget.timedout == true){
                  if(timer.tick == 1){
                    // setState(() {
                    widget.timedout = false;
                    print("The state chnaged to  ${widget.timedout}");
                    // });
                    timer.cancel();
                    print("Timer cancled ");
                    showAlertDialog(
                        context: context, title: "",
                        message: "To see the Sleep clock and change its settings, you will have to complete at least 5 sleep diaries within the last week.",
                        patientprofile: profile
                    );
                  }
                }else{
                  timer.cancel();
                }
              });
            }


            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );
          }
        },
      ),
      
    );
  }

  Padding tableTitle(ThemeData themeData, {required String text}) {
    return Padding(
            padding: SleepClock.sidePad,
            child: Text(text, style: themeData.textTheme.headline4,),
          );
  }

  Padding sleepWindowDataTable({required ThemeData themeData, required SleepClockDTO sleepclock}) {
    return Padding(
            padding: SleepClock.sidePad,
            child: DataTable(
              columns: tableHeaderWidget(themeData),
              rows: [
                rowWidget(themeData, desc: "Your Bed Time", value: "${sleepclock.averagebedtiime}"),
                rowWidget(themeData, desc: "Your RiseTime", value: "${sleepclock.averagerisetime}"),
              ],
            )
          );
  }

  Padding sleepAverageDataTable({required ThemeData themeData, required SleepClockDTO sleepClockDTO}) {
    return Padding(
            padding: SleepClock.sidePad,
            child: DataTable(
              columns: tableHeaderWidget(themeData),
              rows: [
                rowWidget(themeData, desc: "Average Time in Bed per Night", value: "${sleepClockDTO.averagetimeinbed}"),
                rowWidget(themeData, desc: "Average Total Sleep Time per Night", value: "${sleepClockDTO.averagenumberofsleephours}"),
                rowWidget(themeData, desc: "Average Sleep Efficiency", value: "${sleepClockDTO.averagesleepefficiency}%"),
              ],
            )
          );
  }

  List<DataColumn> tableHeaderWidget(ThemeData themeData) {
    return [
              DataColumn(
                label: Text("DESCRIPTION", style: themeData.textTheme.headline5,),
                numeric: false
              ),
              DataColumn(
                label: Text("VALUE", style: themeData.textTheme.headline5,),
                numeric: false
              )
            ];
  }

  DataRow rowWidget(ThemeData themeData, {required String desc, required String value}) {
    return DataRow(
            cells: [
              DataCell(
                Text(desc, style: themeData.textTheme.headline6,),
              ),
              DataCell(
                Text(value, style: themeData.textTheme.headline6,),
              ),
            ]
          );
  }

   createAlertDialog({required BuildContext context, required SleepClockDTO sleepClockDTO}){
     final ThemeData themeData = Theme.of(context);
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text("Sleep Efficiency Message", style: themeData.textTheme.headline5,),
          content: Text("${sleepClockDTO.message}",
        //  content: Text("Your sleep efficiency is between 90%-94%. This is a great result! At this point, you can extend your sleep window by 15 minutes. We recommend moving your bed time 15 minutes earlier.",
          style: themeData.textTheme.bodyText2,),
          actions: [
            MaterialButton(
              child: Text("OK", style: TextStyle(color: appItemColorBlue, fontWeight: FontWeight.w700),),
              onPressed: (){
                Navigator.of(context).pop();
              }
            ),
          ],
        );
      });
  }

  displaySleepWindowDialog(BuildContext context, SleepClockDTO sleepclock){
    Navigator.push(
      context, new MaterialPageRoute(builder: (context) => SleepWindow(sleepClockDTO: sleepclock,))
    );
  }

  Container getContent({required ThemeData themeData,required Size size,required double pad, required SleepClockDTO sleepclock}){
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: pad,),
          Padding(
            padding: SleepClock.sidePad,
            child: Text("It’s time to adjust your sleep clock. Let’s review your sleep patterns from the past week.",
              style: themeData.textTheme.headline5,
            ),
          ),
          SizedBox(height: pad,),
          tableTitle(themeData, text: "Sleep Window:"),
          sleepWindowDataTable(themeData: themeData, sleepclock: sleepclock),
          SizedBox(height: pad,),
          tableTitle(themeData, text: "Sleep Time & Efficiency"),
          sleepAverageDataTable(themeData: themeData, sleepClockDTO: sleepclock),
          SizedBox(height: pad,),
          Center(
              child: Column(
                children: [
                  IconUserButton(buttonText: "View Recommendation Info", buttonEvent: () {createAlertDialog(context: context, sleepClockDTO: sleepclock);}, buttonIcon: Icons.info,),
                  IconUserButton(buttonText: "Set Next Week Sleep Window", buttonEvent: () {
                    displaySleepWindowDialog(context, sleepclock);
                    }, buttonIcon: Icons.alarm)
                ],
              )
          ),

        ],
      ),
    );
  }

  showAlertDialog({required BuildContext context, required String title, required String message, required Future<PatientProfilePodo>? patientprofile}) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(futureProfile: patientprofile, timedout: false)));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("My title"),
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}