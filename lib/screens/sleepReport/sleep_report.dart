import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkUtilities.dart';
import 'package:healthensuite/api/networkmodels/mysleepreport.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/statemanagement/behaviourlogic.dart';
import 'package:healthensuite/screens/home/home_screen.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:healthensuite/models/icon_button.dart';
import 'line_chart_widget.dart';
//import 'package:healthensuite/utilities/constants.dart';


class SleepReport extends StatefulWidget {

  final Function? onMenuTap;
  static final String title = 'Sleep Report';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
 // final Future<PatientProfilePodo>? patientProfile;

  Future<SleepReportDTO>? sleepreport;

  bool showreport = false;

   // SleepReport({Key? key, this.onMenuTap, required this.patientProfile,  this.sleepreport}) : super(key: key);
  SleepReport({Key? key, this.onMenuTap, this.sleepreport}) : super(key: key);

  @override
  _SleepReportState createState() => _SleepReportState();
}

class _SleepReportState extends State<SleepReport> {

    DateTimeRange? dateRgText;
    DateTime firstDate = DateTime(2021);
    DateTime lastDate = DateTime(2030);

   // Future<SleepReportDTO>? sleepreport;

    String? dateRange;

  get reportStatus => widget.showreport;

    @override
    void initState() {
      super.initState();
      widget.sleepreport = ApiAccess().getMysleepReport(null, null);
    }

    @override
  Widget build(BuildContext context) {
     // Future<PatientProfilePodo>? profile = widget.patientProfile;
      final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final _formKey = GlobalKey<FormBuilderState>();
    double pad = 18;
    double innerPad = 10;

    bool reportStatus  = widget.showreport;
//TODO: PUT A TIMEOUT ON THE LOADING OF THE REPORT
    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 3,),
      appBar: AppBar(
        title: Text(SleepReport.title),
        centerTitle: true,
      ),
      body:   FutureBuilder<SleepReportDTO>(
        future: widget.sleepreport,
        builder: (BuildContext context, AsyncSnapshot<SleepReportDTO> snapshot){
         Timer tim = Timer.periodic(Duration(seconds: timeout_duration), (timer){
            if (timer.tick == 1){
              if(snapshot.connectionState == ConnectionState.done){
                if(snapshot.hasData){
                  timer.cancel();
                }else {
                  timer.cancel();
                  showAlertDialog(context: context,
                      title: "No Report",
                      message: "You either don't have any report available now or your internet is slow: confirm that you have submitted sleep diary in the past 7 days");
                }
              }
            }
          });
          if(snapshot.hasData){
            tim.cancel();
            SleepReportDTO sleepReportDTO = snapshot.data!;
            return getContent(themeData, size, pad, _formKey,sleepReportDTO );
          }else{
            return Container(
              child: Center(child: CircularProgressIndicator(),),
            );
          }
        },
      ),
      );
  }

  Container getContent(ThemeData themeData, Size size, double pad, var _formKey, SleepReportDTO sleepReport ){
      return Container(
        width: size.width,
        height: size.height,
        child: ListView(
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: pad,),
            dateRangeFormBuilder(_formKey, themeData),
            SizedBox(height: pad,),
            Center(
                child: IconUserButton(buttonText: "Generate Report", buttonEvent: () {
                  generateReport();
                }, buttonIcon: Icons.book_online_rounded,)
            ),
            SizedBox(height: pad,),
            ((){
              print("Show report is : ${widget.showreport} and status is ${reportStatus}");
              if(reportStatus){
                print("Show report is : ${widget.showreport} and status is ${reportStatus}");
                return getReporttable(themeData, sleepReport, pad);
              }else{
                return  SizedBox(height: 0.0,);
              }
            }()),
          ],
        ),
      );
  }

  Widget getReporttable(ThemeData themeData, SleepReportDTO sleepReport, double pad){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: SleepReport.sidePad,
            child: Text("Report Detail:", style: themeData.textTheme.headline4,),
          ),
          sleepReportDataTable(themeData, sleepReport),
          SizedBox(height: pad,),
          //TODO Please can you sort each object by date before passing them?
          Graph(allBedTimeObject: sleepReport.allbedTime,
              allAwakeningsObject: sleepReport.allAwakenings,
              allTimeInBedObject: sleepReport.allTimeinBed,
              allSleepHoursObject: sleepReport.allSleepHours
          ),
          // Graph(allBedTimeObject: allBedTime,
          //     allAwakeningsObject: allAwakenings,
          //     allTimeInBedObject: allAwakenings,
          //     allSleepHoursObject: allAwakenings
          // ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //TODO I commented out the Extract Report button
              // IconUserButton(buttonText: "Extract Report", buttonEvent: () {}, buttonIcon: Icons.print,),
              IconUserButton(buttonText: "Share Report", buttonEvent: () {
                shareSleepReport(sleepReportDTO: sleepReport);
              }, buttonIcon: Icons.share)
            ],
          ),
          SizedBox(height: pad,),

        ],
      ),
    );
  }

  void shareSleepReport({required SleepReportDTO sleepReportDTO}){
    ApiAccess().sharesleepReport(sleeport: sleepReportDTO);
  }

  //Builder Widget Below

  Padding sleepReportDataTable(ThemeData themeData, SleepReportDTO sleepreportDTO) {
      String avgBedtime = sleepreportDTO.averageBedtime?? "00:00";
      double rawlatency =  sleepreportDTO.sleeplatency?? 0.0;
      double latency =  Workflow().changeDecimalplaces(value: rawlatency, decimalplaces: 2);
      double avgAwakening = sleepreportDTO.averagenumberofawakenings ?? 0.0;
      double rawWASO = sleepreportDTO.waso?? 0.0;
      double WASO = Workflow().changeDecimalplaces(value: rawWASO, decimalplaces: 2);
      double rawtib = sleepreportDTO.tib?? 0.0;
      double tib = Workflow().changeDecimalplaces(value: rawtib, decimalplaces: 2);
      double rawtst = sleepreportDTO.tst?? 0.0;
      double tst = Workflow().changeDecimalplaces(value: rawtst, decimalplaces: 2);
      double rawsleepefficiency = sleepreportDTO.se?? 0.0;
      double sleepefficiency = Workflow().changeDecimalplaces(value: rawsleepefficiency, decimalplaces: 2);

    return Padding(
            padding: SleepReport.sidePad,
            child: DataTable(
              columns: tableHeaderWidget(themeData),
              rows: [
                rowWidget(themeData, desc: "Average Bed Time", value: "${avgBedtime}"),
                rowWidget(themeData, desc: "Average Time to Fall Asleep", value: "${latency}%"),
                rowWidget(themeData, desc: "Average Number of Awakenings", value: "${avgAwakening}%"),
                rowWidget(themeData, desc: "Average Duration of Awakenings (WASO)", value: "${WASO}"),
                rowWidget(themeData, desc: "Average Time In Bed (TIB)", value: "${tib}"),
                rowWidget(themeData, desc: "Average Total Sleep Time (TST)", value: "${tst}"),
                rowWidget(themeData, desc: "Sleep Efficiency", value: "${sleepefficiency}%"),
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



  FormBuilder dateRangeFormBuilder(GlobalKey<FormBuilderState> _formKey, ThemeData themeData) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: SleepReport.sidePad,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pick Date Range below to generate sleep report based on your Sleep Diaries",
              style: themeData.textTheme.headline5,
            ),
            FormBuilderDateRangePicker(
              name: "dateRange", 
              firstDate: firstDate, 
              lastDate: lastDate,
              format: DateFormat("yyyy-MM-dd"),
              initialValue: dateRgText,
             // onChanged: getFormValue(_formKey),
              decoration: InputDecoration(
                hintText: "Click here to pick your date range",
                hintStyle: themeData.textTheme.bodyText2,
              ),
            )
          ],
        ),
      ),
      onChanged: () => getFormValue(_formKey),
    );
  }



  getFormValue(GlobalKey<FormBuilderState> key){
        if(key.currentState!.saveAndValidate()){
          dateRgText = key.currentState!.fields["dateRange"]!.value;
          dateRange = dateRgText.toString();
          //key.currentState.fields["dateRange"].didChange(dateRgText);
          print("Date Range value: $dateRgText");
         // generateReport();
        }
  }

  generateReport(){
      if(dateRange != null){
       var dateArray=   dateRange!.split(" ");
       String start = dateArray[0];
       String end = dateArray[3];
       print("Start date is : ${start}");
       print("End date is : ${end}");
       setState(() {
         widget.sleepreport = ApiAccess().getMysleepReport(start, end);
         widget.showreport = true;
         // setState in Dropdown
       });
      }
  }



    showAlertDialog({required BuildContext context, required String title, required String message,}) {

      // set up the button
      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => HomeScreen(timedout: true, showdisclaimer: false, )));
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

