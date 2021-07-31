import 'package:flutter/material.dart';
import 'package:healthensuite/api/network.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:healthensuite/models/icon_button.dart';
//import 'package:healthensuite/utilities/constants.dart';


class SleepReport extends StatefulWidget {

  final Function? onMenuTap;
  static final String title = 'Sleep Report';
  static final sidePad = EdgeInsets.symmetric(horizontal: 18);
  final Future<PatientProfilePodo>? patientProfile;


  const SleepReport({Key? key, this.onMenuTap, required this.patientProfile}) : super(key: key);

  @override
  _SleepReportState createState() => _SleepReportState();
}

class _SleepReportState extends State<SleepReport> {

    DateTimeRange? dateRgText;
    DateTime firstDate = DateTime(2021);
    DateTime lastDate = DateTime(2030);

  // DateTimeRange setVal(dateRgText){
    
  //     setState( (){
  //       if (dateRgText == null){
  //         dateRgText = DateTimeRange(start: firstDate, end: lastDate);
  //       }
  //     });
  //     return dateRgText;
    
  // }



    @override
  Widget build(BuildContext context) {
      Future<PatientProfilePodo>? profile = widget.patientProfile;
      final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final _formKey = GlobalKey<FormBuilderState>();
    double pad = 18;
    double innerPad = 10;

    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 3,patientprofile: profile,),
      appBar: AppBar(
        title: Text(SleepReport.title),
        centerTitle: true,
      ),
      body: Container(
              width: size.width,
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: pad,),
                  dateRangeFormBuilder(_formKey, themeData),
                  SizedBox(height: pad,),
                  Center(
                    child: IconUserButton(buttonText: "Generate Report", buttonEvent: () {}, buttonIcon: Icons.book_online_rounded,)
                  ),
                  SizedBox(height: pad,),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: SleepReport.sidePad,
                          child: Text("Report Detail:", style: themeData.textTheme.headline4,),
                        ),
                        sleepReportDataTable(themeData),
                        SizedBox(height: pad,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconUserButton(buttonText: "Extract Report", buttonEvent: () {}, buttonIcon: Icons.print,),
                            IconUserButton(buttonText: "Share Report", buttonEvent: () {}, buttonIcon: Icons.share)
                          ],
                        ),
                        SizedBox(height: pad,),

                      ],
                    ),
                  ),
                ],
              ),
          ),
      );
  }

  //Builder Widget Below

  Padding sleepReportDataTable(ThemeData themeData) {
    return Padding(
            padding: SleepReport.sidePad,
            child: DataTable(
              columns: tableHeaderWidget(themeData),
              rows: [
                rowWidget(themeData, desc: "Average Bed Time", value: "21:00"),
                rowWidget(themeData, desc: "Sleep Latency", value: "95%"),
                rowWidget(themeData, desc: "Average Duration of Awakenings (WASO)", value: "05:29"),
                rowWidget(themeData, desc: "Time In Bed (TIB)", value: "20:40"),
                rowWidget(themeData, desc: "Total Sleep Time (TST)", value: "15:40"),
                rowWidget(themeData, desc: "Sleep Efficiency", value: "92%"),
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
              //onChanged: getFormValue(_formKey),
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
          //key.currentState.fields["dateRange"].didChange(dateRgText);
          print("Date Range value: $dateRgText");
        }
  }
  

  }

  // Table(
  //   // columnWidths: {
  //   //   0: FlexColumnWidth()
  //   // },
  //   children: [
  //     TableRow(
  //       children: [
  //         Text("Average Bed Time", style: themeData.textTheme.headline4,),
  //         Text("21:00", style: themeData.textTheme.headline5,),
  //       ],
  //       decoration: Decoration()
  //     ),
      
  //     TableRow(
  //       children: [
  //         Text("Sleep Latency", style: themeData.textTheme.headline5,),
  //         Text("95%", style: themeData.textTheme.headline5,),
  //       ],
  //     ),
  //   ],
  // ),
  