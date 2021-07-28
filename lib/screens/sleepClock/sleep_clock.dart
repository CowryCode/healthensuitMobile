import 'package:flutter/material.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'package:healthensuite/utilities/constants.dart';
import 'package:healthensuite/models/icon_button.dart';
import 'package:healthensuite/screens/sleepClock/sleep_window.dart';


class SleepClock extends StatefulWidget {

  final Function? onMenuTap;
  static final String title = 'Sleep Clock';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);

  const SleepClock({Key? key, this.onMenuTap}) : super(key: key);

  @override
  _SleepClockState createState() => _SleepClockState();
}

class _SleepClockState extends State<SleepClock> {
  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double pad = 18;
    double innerPad = 10;

    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 2,),
      appBar: AppBar(
        title: Text(SleepClock.title),
        centerTitle: true,
      ),
      body: Container(
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
            sleepWindowDataTable(themeData),
            SizedBox(height: pad,),
            tableTitle(themeData, text: "Sleep Time & Efficiency"),
            sleepAverageDataTable(themeData),
            SizedBox(height: pad,),
            Center(
                child: Column(
                  children: [
                    IconUserButton(buttonText: "View Recommendation Info", buttonEvent: () {createAlertDialog(context);}, buttonIcon: Icons.info,),
                    IconUserButton(buttonText: "Set Next Week Sleep Window", buttonEvent: () {displaySleepWindowDialog(context);}, buttonIcon: Icons.alarm)
                  ],
                )
            ),

          ],
        ),
      ),
      
    );
  }

  Padding tableTitle(ThemeData themeData, {required String text}) {
    return Padding(
            padding: SleepClock.sidePad,
            child: Text(text, style: themeData.textTheme.headline4,),
          );
  }

  Padding sleepWindowDataTable(ThemeData themeData) {
    return Padding(
            padding: SleepClock.sidePad,
            child: DataTable(
              columns: tableHeaderWidget(themeData),
              rows: [
                rowWidget(themeData, desc: "Your Bed Time", value: "21:00"),
                rowWidget(themeData, desc: "Your RiseTime", value: "05:40"),
              ],
            )
          );
  }

  Padding sleepAverageDataTable(ThemeData themeData) {
    return Padding(
            padding: SleepClock.sidePad,
            child: DataTable(
              columns: tableHeaderWidget(themeData),
              rows: [
                rowWidget(themeData, desc: "Average Time in Bed per Night", value: "21:00"),
                rowWidget(themeData, desc: "Average Total Sleep Time per Night", value: "15:40"),
                rowWidget(themeData, desc: "Average Sleep Efficiency", value: "92%"),
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

   createAlertDialog(BuildContext context){
     final ThemeData themeData = Theme.of(context);
    return showDialog(
      context: context, 
      builder: (context){
        return AlertDialog(
          title: Text("Sleep Efficiency Message", style: themeData.textTheme.headline5,),
          content: Text("Your sleep efficiency is between 90%-94%. This is a great result! At this point, you can extend your sleep window by 15 minutes. We recommend moving your bed time 15 minutes earlier.", 
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

  displaySleepWindowDialog(BuildContext context){
    Navigator.push(
      context, new MaterialPageRoute(builder: (context) => SleepWindow())
    );
  }
}