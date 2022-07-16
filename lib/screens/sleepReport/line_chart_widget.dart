import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:healthensuite/api/networkmodels/mysleepreport.dart';
import 'package:intl/intl.dart';
import '../../utilities/constants.dart';
import 'dart:math';

class _MyData {
  final DateTime date;
  final double value;

  _MyData({
    required this.date,
    required this.value,
  });
}

class _MyTimeData {
  final DateTime date;
   final int value;

  _MyTimeData({
    required this.date,
    required this.value,
  });

}

class Graph extends StatelessWidget {
  // final List<dynamic> allBedTimeObject;
  // final List<dynamic> allAwakeningsObject;
  // final List<dynamic> allTimeInBedObject;
  // final List<dynamic> allSleepHoursObject;
  final List<AllbedTime> allBedTimeObject;
  final List<DateValueObject> allAwakeningsObject;
  final List<DateValueObject> allTimeInBedObject;
  final List<DateValueObject> allSleepHoursObject;

  Graph({required this.allBedTimeObject, required this.allAwakeningsObject,
        required this.allTimeInBedObject, required this.allSleepHoursObject});

  late List<_MyData> _awakeningsData = _generateNumberData(allAwakeningsObject);
  late List<_MyData> _sleepHoursData = _generateNumberData(allSleepHoursObject);
  late List<_MyData> _timeInBedData = _generateNumberData(allTimeInBedObject);
  late List<_MyTimeData> _bedTimeData = _generateTimeData(allBedTimeObject);
  late ThemeData themeData;


  @override
  Widget build(BuildContext context) {
    double pad = 100;
    double smallPad = 15;
    final Size size = MediaQuery.of(context).size;
    final sidePad = EdgeInsets.symmetric(horizontal: 20);
    themeData = Theme.of(context);
    return Container(
        width: size.width,
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(15),
        height: size.height * 2,
        // height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Center(child: Text("All Bed Time", style: themeData.textTheme.headline4,),),
            Text("All Bed Time:", style: themeData.textTheme.headline4,),
            SizedBox(height: smallPad,),
            Expanded(child: _graphTime(themeData, _bedTimeData),),

            // Center(child: Text("All Awakenings", style: themeData.textTheme.headline4,),),
            Text("All Awakenings:", style: themeData.textTheme.headline4,),
            SizedBox(height: smallPad,),
            Expanded(child: _graph(themeData, _awakeningsData, allAwakeningsObject),),

            // Center(child: Text("Total Time In Bed (TTIB)", style: themeData.textTheme.headline4,),),
            Text("Total Time In Bed (TTIB):", style: themeData.textTheme.headline4,),
            SizedBox(height: smallPad,),
            Expanded(child: _graph(themeData, _timeInBedData, allTimeInBedObject),),

            // Center(child: Text("Total Sleep Time (TST)", style: themeData.textTheme.headline4,),),
            Text("Total Sleep Time (TST):", style: themeData.textTheme.headline4,),
            SizedBox(height: smallPad,),
            Expanded(child: _graph(themeData, _sleepHoursData, allAwakeningsObject),),

          ],

        )
    );
  }

  // Widget _scrollGraph() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Container(
  //       padding: EdgeInsets.only(bottom: 15),
  //       width: MediaQuery.of(context).size.height * 2,
  //       child: _graph(),
  //     ),
  //   );
  // }

  Widget _graph(ThemeData themeData, List<_MyData> _data, List<DateValueObject> dataObject) {
    final spots = _data
        .asMap()
        .entries
        .map((element) => FlSpot(
      element.key.toDouble(),
      element.value.value.toDouble(),
    ))
        .toList();

    DateFormat dateFormat = DateFormat("MM-dd");
  //  double maxValue = dataObject.map<double>((e) => e['value']).reduce(max);
    double maxValue = dataObject.map<double>((e) => e.value).reduce(max);
    print("THE MAXIMUM VALUE IS : ${maxValue}");

    return LineChart(
      LineChartData(
        minY: 0,
        maxY: maxValue,
        lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: appItemColorWhite,
            )
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            colors: [appItemColorBlue],
          ),
        ],
        titlesData: FlTitlesData(
          rightTitles: SideTitles(showTitles: false),
          topTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            reservedSize: 60,
            margin: 12,
            getTextStyles: (context, xValue) {
              return themeData.textTheme.subtitle1;
            },
            rotateAngle: 30,
            showTitles: true,
            getTitles: (xValue) {
              final date = _data[xValue.toInt()].date;
              return DateFormat.MMMd().format(date);
              // return dateFormat.format(date);
            },
          ),
          leftTitles: SideTitles(
            reservedSize: 50,
            getTextStyles: (context, xValue) {
              return themeData.textTheme.subtitle1;
            },
            getTitles: (xValue) {
              return xValue.toInt().toString();
            },
            // rotateAngle: 30,
            showTitles: true,
          ),
        ),
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }

  // Widget _graph(ThemeData themeData, List<_MyData> _data, List<dynamic> dataObject) {
  //   final spots = _data
  //       .asMap()
  //       .entries
  //       .map((element) => FlSpot(
  //     element.key.toDouble(),
  //     element.value.value,
  //   ))
  //       .toList();
  //
  //   DateFormat dateFormat = DateFormat("MM-dd");
  //   double maxValue = dataObject.map<double>((e) => e['value']).reduce(max);
  //
  //   return LineChart(
  //     LineChartData(
  //       minY: 0,
  //       maxY: maxValue,
  //       lineTouchData: LineTouchData(
  //           touchTooltipData: LineTouchTooltipData(
  //             tooltipBgColor: appItemColorWhite,
  //           )
  //       ),
  //       lineBarsData: [
  //         LineChartBarData(
  //           spots: spots,
  //           colors: [appItemColorBlue],
  //         ),
  //       ],
  //       titlesData: FlTitlesData(
  //         rightTitles: SideTitles(showTitles: false),
  //         topTitles: SideTitles(showTitles: false),
  //         bottomTitles: SideTitles(
  //           reservedSize: 60,
  //           margin: 12,
  //           getTextStyles: (context, xValue) {
  //             return themeData.textTheme.subtitle1;
  //           },
  //           rotateAngle: 30,
  //           showTitles: true,
  //           getTitles: (xValue) {
  //             final date = _data[xValue.toInt()].date;
  //             return DateFormat.MMMd().format(date);
  //             // return dateFormat.format(date);
  //           },
  //         ),
  //         leftTitles: SideTitles(
  //           reservedSize: 50,
  //           getTextStyles: (context, xValue) {
  //             return themeData.textTheme.subtitle1;
  //           },
  //           getTitles: (xValue) {
  //             return xValue.toInt().toString();
  //           },
  //           // rotateAngle: 30,
  //           showTitles: true,
  //         ),
  //       ),
  //     ),
  //     swapAnimationDuration: Duration(milliseconds: 150), // Optional
  //     swapAnimationCurve: Curves.linear, // Optional
  //   );
  // }


  Widget _graphTime(ThemeData themeData, List<_MyTimeData> _data) {

    final spots = _data
        .asMap()
        .entries
        .map((element) => FlSpot(
      element.key.toDouble(),
      element.value.value.toDouble(),
    ))
        .toList();

    DateFormat dateFormat = DateFormat("MM-dd");
    DateFormat timeFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
    DateFormat hourFormat = DateFormat("h a");

    return LineChart(
      LineChartData(
        minY: timeFormat.parse("0001-01-01 00:00:00").microsecondsSinceEpoch.toDouble(),
        maxY: timeFormat.parse("0001-01-01 23:59:59").microsecondsSinceEpoch.toDouble(),
        // showingTooltipIndicators: _data,
        lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (value) {
                return value
                    .map((e) => LineTooltipItem(
                  // "Time: \n"
                  //     "${hourFormat.format(DateTime.fromMicrosecondsSinceEpoch(e.y.toInt()))}"
                  hourFormat.format(DateTime.fromMicrosecondsSinceEpoch(e.y.toInt()))
                  ,
                  const TextStyle(
                      color: ITEM_COLOR_BLUE, fontWeight: FontWeight.bold),))
                    .toList();
              },
              tooltipBgColor: appItemColorWhite,
            )
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            colors: [appItemColorBlue],
          ),
        ],
        titlesData: FlTitlesData(
          // topTitles: AxisTitles(
          //   sideTitles: SideTitles(showTitles: false),
          // ),
          // leftTitles: AxisTitles(
          //   sideTitles: SideTitles(
          //     showTitles: true,
          //     getTitlesWidget: leftTitleWidgets,
          //     interval: 1,
          //     reservedSize: 36,
          //   ),
          // ),
          topTitles: SideTitles(showTitles: false),
          rightTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            reservedSize: 60,
            margin: 12,
            getTextStyles: (context, xValue) {
              return themeData.textTheme.subtitle1;
            },
            rotateAngle: 30,
            showTitles: true,
            getTitles: (xValue) {
              final date = _data[xValue.toInt()].date;
              return DateFormat.MMMd().format(date);
            },
          ),
          leftTitles: SideTitles(
            reservedSize: 50,
            getTextStyles: (context, xValue) {
              return themeData.textTheme.subtitle1;
            },
            // rotateAngle: 30,
            showTitles: true,
            getTitles: (xValue) {
              final date = DateTime.fromMicrosecondsSinceEpoch(xValue.toInt());
              return hourFormat.format(date);
            },
          ),
        ),
      ),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }



  List<_MyData> _generateNumberData(List<DateValueObject> data) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    return List.generate(
      data.length,
          (index) => _MyData(
        date: dateFormat.parse(data[index].date),
        value: data[index].value,
      ),
    );
  }

List<_MyTimeData> _generateTimeData(List<AllbedTime> data) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  DateFormat timeFormat = DateFormat("yyyy-MM-dd hh:mm:ss");

  return List.generate(
    data.length,
        (index) => _MyTimeData(
      date: dateFormat.parse(data[index].date!),
      value: timeFormat.parse("0001-01-01 "+data[index].time!).microsecondsSinceEpoch,
    ),
  );
}

}



// class _Graph extends State<Graph> {
//   late List<_MyData> _awakeningsData;
//   late List<_MyData> _sleepHoursData;
//   late List<_MyData> _timeInBedData;
//   late List<_MyTimeData> _bedTimeData;
//   late ThemeData themeData;
//
//   @override
//   void initState() {
//     _awakeningsData = _generateNumberData(widget.allAwakeningsObject);
//     _sleepHoursData = _generateNumberData(widget.allSleepHoursObject);
//     _timeInBedData = _generateNumberData(widget.allTimeInBedObject);
//     _bedTimeData = _generateTimeData(widget.allBedTimeObject);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double pad = 18;
//     themeData = Theme.of(context);
//     return Column(
//               children: [
//                 _graphTime(themeData, _bedTimeData),
//                 SizedBox(height: pad,),
//                 _graph(themeData, _awakeningsData, widget.allAwakeningsObject),
//                 SizedBox(height: pad,),
//                 _graph(themeData, _timeInBedData, widget.allTimeInBedObject),
//                 SizedBox(height: pad,),
//                 _graph(themeData, _sleepHoursData, widget.allAwakeningsObject),
//               ],
//
//     );
//   }
//
//   // Widget _scrollGraph() {
//   //   return SingleChildScrollView(
//   //     scrollDirection: Axis.horizontal,
//   //     child: Container(
//   //       padding: EdgeInsets.only(bottom: 15),
//   //       width: MediaQuery.of(context).size.height * 2,
//   //       child: _graph(),
//   //     ),
//   //   );
//   // }
//
//   Widget _graph(ThemeData themeData, List<_MyData> _data, List<dynamic> dataObject) {
//     final spots = _data
//         .asMap()
//         .entries
//         .map((element) => FlSpot(
//       element.key.toDouble(),
//       element.value.value,
//     ))
//         .toList();
//
//     DateFormat dateFormat = DateFormat("MM-dd");
//     double maxValue = dataObject.map<double>((e) => e['value']).reduce(max);
//
//     return LineChart(
//       LineChartData(
//         minY: 0,
//         maxY: maxValue,
//         lineTouchData: LineTouchData(
//           touchTooltipData: LineTouchTooltipData(
//             tooltipBgColor: appItemColorWhite,
//           )
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: spots,
//             colors: [appItemColorBlue],
//           ),
//         ],
//         titlesData: FlTitlesData(
//           rightTitles: SideTitles(showTitles: false),
//           topTitles: SideTitles(showTitles: false),
//           bottomTitles: SideTitles(
//             reservedSize: 6,
//             getTextStyles: (context, xValue) {
//               return themeData.textTheme.subtitle1;
//             },
//             rotateAngle: 30,
//             showTitles: true,
//             getTitles: (xValue) {
//               final date = _data[xValue.toInt()].date;
//               return DateFormat.MMMd().format(date);
//               // return dateFormat.format(date);
//             },
//           ),
//           leftTitles: SideTitles(
//             reservedSize: 30,
//             margin: 12,
//             getTextStyles: (context, xValue) {
//               return themeData.textTheme.subtitle1;
//             },
//             getTitles: (xValue) {
//               return xValue.toInt().toString();
//             },
//             // rotateAngle: 30,
//             showTitles: true,
//           ),
//         ),
//       ),
//       swapAnimationDuration: Duration(milliseconds: 150), // Optional
//       swapAnimationCurve: Curves.linear, // Optional
//     );
//   }
//
//
//   Widget _graphTime(ThemeData themeData, List<_MyTimeData> _data) {
//
//     final spots = _data
//         .asMap()
//         .entries
//         .map((element) => FlSpot(
//       element.key.toDouble(),
//       element.value.value.toDouble(),
//     ))
//         .toList();
//
//     DateFormat dateFormat = DateFormat("MM-dd");
//     DateFormat timeFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
//     DateFormat hourFormat = DateFormat("h a");
//
//     return LineChart(
//       LineChartData(
//         minY: timeFormat.parse("0001-01-01 00:00:00").microsecondsSinceEpoch.toDouble(),
//         maxY: timeFormat.parse("0001-01-01 23:59:59").microsecondsSinceEpoch.toDouble(),
//         // showingTooltipIndicators: _data,
//         lineTouchData: LineTouchData(
//           touchTooltipData: LineTouchTooltipData(
//             getTooltipItems: (value) {
//               return value
//                   .map((e) => LineTooltipItem(
//                   // "Time: \n"
//                   //     "${hourFormat.format(DateTime.fromMicrosecondsSinceEpoch(e.y.toInt()))}"
//                   hourFormat.format(DateTime.fromMicrosecondsSinceEpoch(e.y.toInt()))
//                   ,
//                 const TextStyle(
//                     color: ITEM_COLOR_BLUE, fontWeight: FontWeight.bold),))
//                   .toList();
//             },
//             tooltipBgColor: appItemColorWhite,
//           )
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: spots,
//             colors: [appItemColorBlue],
//           ),
//         ],
//         titlesData: FlTitlesData(
//           // topTitles: AxisTitles(
//           //   sideTitles: SideTitles(showTitles: false),
//           // ),
//           // leftTitles: AxisTitles(
//           //   sideTitles: SideTitles(
//           //     showTitles: true,
//           //     getTitlesWidget: leftTitleWidgets,
//           //     interval: 1,
//           //     reservedSize: 36,
//           //   ),
//           // ),
//           topTitles: SideTitles(showTitles: false),
//           rightTitles: SideTitles(showTitles: false),
//           bottomTitles: SideTitles(
//             reservedSize: 50,
//             margin: 12,
//             getTextStyles: (context, xValue) {
//               return themeData.textTheme.subtitle1;
//             },
//             rotateAngle: 30,
//             showTitles: true,
//             getTitles: (xValue) {
//               final date = _data[xValue.toInt()].date;
//               return DateFormat.MMMd().format(date);
//             },
//           ),
//           leftTitles: SideTitles(
//             reservedSize: 50,
//             margin: 12,
//             getTextStyles: (context, xValue) {
//               return themeData.textTheme.subtitle1;
//             },
//             // rotateAngle: 30,
//             showTitles: true,
//             getTitles: (xValue) {
//               final date = DateTime.fromMicrosecondsSinceEpoch(xValue.toInt());
//               return hourFormat.format(date);
//             },
//           ),
//         ),
//       ),
//       swapAnimationDuration: Duration(milliseconds: 150), // Optional
//       swapAnimationCurve: Curves.linear, // Optional
//     );
//   }
//
//
//   List<_MyTimeData> _generateTimeData(List<dynamic> data) {
//     DateFormat dateFormat = DateFormat("yyyy-MM-dd");
//     DateFormat timeFormat = DateFormat("yyyy-MM-dd hh:mm:ss");
//
//     return List.generate(
//       data.length,
//           (index) => _MyTimeData(
//         date: dateFormat.parse(data[index]['date']),
//         value: timeFormat.parse("0001-01-01 "+data[index]['value']).microsecondsSinceEpoch,
//       ),
//     );
//   }
//
//   List<_MyData> _generateNumberData(List<dynamic> data) {
//     DateFormat dateFormat = DateFormat("yyyy-MM-dd");
//
//     return List.generate(
//       data.length,
//           (index) => _MyData(
//         date: dateFormat.parse(data[index]['date']),
//         value: data[index]['value'],
//       ),
//     );
//   }
//
//   // Widget bottomTitleWidgets(double value, TitleMeta meta) {
//   //   final date = _timeData[value.toInt()].date;
//   //   String text = DateFormat.MMMd().format(date);
//   //   // return dateFormat.format(date);
//   //   return SideTitleWidget(
//   //     axisSide: meta.axisSide,
//   //     space: 4,
//   //     child: Text(text, style: themeData.textTheme.labelMedium),
//   //   );
//   // }
//   //
//   // Widget leftTitleWidgets(double value, TitleMeta meta) {
//   //   DateFormat hourFormat = DateFormat("h a");
//   //   final date = DateTime.fromMicrosecondsSinceEpoch(value.toInt());
//   //
//   //   return SideTitleWidget(
//   //     axisSide: meta.axisSide,
//   //     child: Text(
//   //       hourFormat.format(date),
//   //       // '\$ ${value + 0.5}',
//   //       style: themeData.textTheme.labelMedium,
//   //     ),
//   //   );
//   // }
//
// }

//TODO Upper code is A CLASS



// const _dashArray = [4, 2];
//
// class LineChartWidget extends StatelessWidget {
//   final List<NumberDataPoint> points;
//   final bool isPositiveChange;
//
//   const LineChartWidget(this.points, this.isPositiveChange, {Key? key})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final minY = points.map((point) => point.y).reduce(min);
//     final maxY = points.map((point) => point.y).reduce(max);
//
//     return AspectRatio(
//       aspectRatio: 2,
//       child: LineChart(
//         LineChartData(
//             lineTouchData: LineTouchData(
//                 enabled: true,
//                 touchCallback:
//                     (FlTouchEvent event, LineTouchResponse? touchResponse) {
//                   // TODO : Utilize touch event here to perform any operation
//                 },
//                 touchTooltipData: LineTouchTooltipData(
//                   tooltipBgColor: Colors.blue,
//                   tooltipRoundedRadius: 20.0,
//                   showOnTopOfTheChartBoxArea: true,
//                   fitInsideHorizontally: true,
//                   tooltipMargin: 0,
//                   getTooltipItems: (touchedSpots) {
//                     return touchedSpots.map(
//                           (LineBarSpot touchedSpot) {
//                         const textStyle = TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                         );
//                         return LineTooltipItem(
//                           points[touchedSpot.spotIndex].y.toInt().toString(),
//                           textStyle,
//                         );
//                       },
//                     ).toList();
//                   },
//                 ),
//                 getTouchedSpotIndicator:
//                     (LineChartBarData barData, List<int> indicators) {
//                   return indicators.map(
//                         (int index) {
//                       final line = FlLine(
//                           color: Colors.grey,
//                           strokeWidth: 1,
//                           dashArray: _dashArray);
//                       return TouchedSpotIndicatorData(
//                         line,
//                         FlDotData(show: false),
//                       );
//                     },
//                   ).toList();
//                 },
//                 getTouchLineEnd: (_, __) => double.infinity),
//             lineBarsData: [
//               LineChartBarData(
//                 spots: points.map((point) => FlSpot(point.x, point.y)).toList(),
//                 isCurved: false,
//                 color:appItemColorBlue,
//                 dotData: FlDotData(
//                   show: false,
//                 ),
//               ),
//             ],
//             minY: minY,
//             minX: 0,
//             maxY: maxY,
//             borderData: FlBorderData(
//                 border: const Border(bottom: BorderSide(), left: BorderSide())),
//             gridData: FlGridData(show: false),
//             titlesData: FlTitlesData(
//               bottomTitles: _bottomTitles,
//               leftTitles: SideTitles(showTitles: false),
//               topTitles: SideTitles(showTitles: false),
//               rightTitles: SideTitles(showTitles: false),
//             )),
//       ),
//     );
//   }
// }




// Widget bottomTitleWidgets(double value, TitleMeta meta) {
//   const style = TextStyle(
//     fontWeight: FontWeight.bold,
//     color: Colors.blueGrey,
//     fontFamily: 'Digital',
//     fontSize: 18,
//   );
//   String text;
//   switch (value.toInt()) {
//     case 0:
//       text = '00:00';
//       break;
//     case 1:
//       text = '04:00';
//       break;
//     case 2:
//       text = '08:00';
//       break;
//     default:
//       return Container();
//   }
//
//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     child: Text(text, style: style),
//   );
// }