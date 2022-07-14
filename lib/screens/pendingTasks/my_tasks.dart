
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/utilities/drawer_navigation.dart';
import 'package:healthensuite/screens/pendingTasks/task_card.dart';
import 'package:healthensuite/utilities/text_data.dart';
import 'package:healthensuite/utilities/constants.dart';

class MyTasks extends StatefulWidget {
  // Future<PatientProfilePodo>? futureProfile;
  bool timedout;
  // HomeScreen({required this.futureProfile, this.timedout: false });
  MyTasks({this.timedout: false });

  @override
  _MyTasksScreenState createState() => _MyTasksScreenState();
}

class _MyTasksScreenState extends State<MyTasks> {

  static final String title = 'My Task List';
  final sidePad = EdgeInsets.symmetric(horizontal: 18);

  Future<PatientProfilePodo>? patientprofile;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    double pad = 18;
    return Scaffold(
      drawer: NavigationDrawerWidget(indexNum: 6,),
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: StoreConnector<AppState, PatientProfilePodo>(
        converter: (store) => store.state.patientProfilePodo,
        builder: (context, PatientProfilePodo profile ) => Container(
          child:  Container(
            width: size.width,
            height: size.height * 2,
            child: Column(
              children: [
                SizedBox(height: pad,),
                SizedBox(
                  height: 220,
                  child: buildListView(),
                ),

                Visibility(
                  child: SizedBox( //
                    height: 110,
                    child: TaskCard(
                      cardIndex: 1,
                      isCompleted: false,
                      onTapCallBack: (){},
                    ),
                  ),
                  visible: true,
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  //Builder Widget Below
  Widget buildListView() => ListView.builder(
    // itemCount: context.watch<HomeViewModel>().mainTodos?.length,
    itemCount: sleepDiaries.length,
    itemBuilder: (context, index) => TaskCard(
      cardIndex: index,
      data: sleepDiaries,
      onTapCallBack: (){},
    ),
  );

}

List<dynamic> sleepDiaries = [
  {
    "date_Created": "2022-04-25T17:43:23",
    "id": 143,
    "bedTime": "17:05"
  },
  {
    "date_Created": "2022-04-24T17:43:23",
    "id": 145,
    "bedTime": null
  },
];

