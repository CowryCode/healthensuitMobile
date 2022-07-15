
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';
import 'package:healthensuite/api/networkmodels/statusEntityPODO.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/screens/sleepDiary/sleep_diary.dart';
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
                // SizedBox(
                //   height: 220,
                //   child: buildListView(),
                // ),
                SizedBox(
                  height: 220,
                  child: getSleepDiariesCards(sleepdiaries: profile.sleepDiaries),
                ),
                // Visibility(
                //   child: SizedBox( //
                //     height: 110,
                //     child: TaskCard(
                //       cardIndex: 1,
                //       isCompleted: false,
                //       onTapCallBack: (){},
                //     ),
                //   ),
                //   visible: true,
                // ),
                ((){
                  print("GROUP ID IS :${profile.groupID}");
                  print("PATIENT ID :${profile.id}");
                  print("STAATUS ENTITY ID : ${profile.statusEntity!.id}");
                  print("IS Baseline Completed : ${profile.statusEntity!.baselineAssessmenPassed!}");
                  print("My Condition : ${profile.groupID == 0 && profile.statusEntity!.baselineAssessmenPassed!? true : false}");
                  return SizedBox();
                }()),
                Visibility(
                  child: SizedBox( //
                    height: 110,
                    child: TaskCard(
                      cardIndex: 1,
                      taskName: getTaskName(level: profile.statusEntity!.interventionLevel),
                      isCompleted: isLevelCompleted(patientProfilePodo: profile),
                      onTapCallBack: (){},
                    ),
                  ),
                  //visible: true,
                  visible: profile.groupID == 0 && profile.statusEntity!.baselineAssessmenPassed! == true ? true : false,
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

   //Builder Widget Below
  // Widget buildListView() => ListView.builder(
  //   itemCount: sleepDiaries.length,
  //   itemBuilder: (context, index) => TaskCard(
  //     cardIndex: index,
  //     data: sleepDiaries,
  //     onTapCallBack: (){},
  //   ),
  // );

  Widget getSleepDiariesCards({List<SleepDiariesPODO>? sleepdiaries}){
    if(sleepdiaries == null ){
      return SizedBox();
    }else{
      return ListView.builder(
        itemCount: sleepdiaries.length,
        itemBuilder: (context, index) => TaskCard(
          cardIndex: index,
          data: sleepdiaries,
          onTapCallBack: (){
            Navigator.push(context, new MaterialPageRoute(builder: (context) =>
                SleepDiary(sleepDiariesPODO:sleepdiaries.elementAt(index))));
          },
        ),
      );
    }
  }

  String getTaskName({required int? level}){
    if(level == null){
      return "";
    }else if(level < 0 ){
      return " ";
    }else{
      switch(level){
        case 1:
          return "Introduction to Health enSuite Insomnia";
        case 2:
          return "Introduction to Sleep Restriction";
        case 3:
          return "Sleep Hygiene";
        case 4:
          return "Relaxation techniques";
        case 5:
          return "Changing Thoughts";
        case 6:
          return "Maintaining Your Progress";
        default:
          return "";
      }
    }
  }

  bool isLevelCompleted({required PatientProfilePodo patientProfilePodo}){
    int level =  patientProfilePodo.statusEntity!.interventionLevel?? -1;
    StatusEntity statusEntity = patientProfilePodo.statusEntity ?? StatusEntity();
    if(level < 0 ){
      return false;
    }else{
      switch(level){
        case 1:
          return statusEntity.readInterventionGroupleveloneArticle == true ? true : false;
        case 2:
          return statusEntity.readInterventionGroupleveltwoArticle == true ? true : false;
        case 3:
          return statusEntity.readInterventionGrouplevelthreeArticle == true ? true : false;
        case 4:
          return statusEntity.readInterventionGrouplevelfourArticle == true ? true : false;
        case 5:
          return statusEntity.readInterventionGrouplevelfiveArticle == true ? true : false;
        case 6:
          return statusEntity.readInterventionGrouplevelsixArticle == true ? true : false;
        default:
          return false;
      }
    }
  }

}



// List<dynamic> sleepDiaries = [
//   {
//     "date_Created": "2022-04-25T17:43:23",
//     "id": 143,
//     "bedTime": "17:05"
//   },
//   {
//     "date_Created": "2022-04-24T17:43:23",
//     "id": 145,
//     "bedTime": null
//   },
// ];

