
import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:healthensuite/api/networkUtilities.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelfivePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelsixPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelthreePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/loginPodo.dart';
import 'package:healthensuite/api/networkmodels/mysleepclock.dart';
import 'package:healthensuite/api/networkmodels/otherMedicationsPODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/psychoeducationPODO.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';
import 'package:healthensuite/api/networkmodels/sleepwindowsPODO.dart';
import 'package:healthensuite/api/networkmodels/textexchangePODO.dart';
import 'package:healthensuite/api/statemanagement/behaviourlogic.dart';
import 'package:healthensuite/api/statemanagement/diskstorage.dart';
import 'package:http/http.dart' as http;

import 'networkmodels/mysleepreport.dart';

class ApiAccess {

 // Future<LoginPodo> login({String? username, String? password}) async {
  Future<PatientProfilePodo>? login({String? username, String? password}) async {
      final response = await http.post(
        Uri.parse(loginURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String?>{"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        LoginPodo cc = LoginPodo.fromJson(jsonDecode(response.body));
        print("Person ID : ${cc.personID}");
        print("Token : ${cc.token} ");
        String? token = cc.token??"";
        print("Token 2 :  $token");
        Localstorage().saveString(key_login_token, token);

        PatientProfilePodo profile = await getPatientProfile(cc.token)?? PatientProfilePodo();
        if(profile.firstName != null){
          return profile;
        }else{
          throw Exception("Could not pull Profile");
        }
      } else {
        throw Exception("Couldn't login, possible wrong passoword");
      }
  }


  Future<bool> confirmUser({String? username}) async {
    final response = await http.post(
      Uri.parse(confirmUsername_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String?>{"code": username}),
    );

    if (response.statusCode == 302) {
      TextexchangePODO textexchange = TextexchangePODO.fromJson(jsonDecode(response.body));
      print(" The payload Code ${textexchange.code}");
      print(" The payload Code1 ${textexchange.code1}");
      Localstorage().saveString(key_login_token, textexchange.code??"");
      Localstorage().saveString(key_temp_int, textexchange.code1??"nothing");
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changePasswordverifyCode({String? code}) async {
    String token = await Localstorage().getString(key_login_token)??"";
    String tempCode = await Localstorage().getString(key_temp_int)??"";
    print(" Local Payload token ${token}");
    print(" Local Payload tempcode ${tempCode}");
    print(" Inputed Code ${code}");
    if(tempCode != code) {
       return false;
      }else{
      final response = await http.post(
        Uri.parse(loginwithCode_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
            <String, String?>{"code": token}),
      );

      if (response.statusCode == 200) {
        TextexchangePODO textexchange = TextexchangePODO.fromJson(
            jsonDecode(response.body));
        print("The response is :  ${textexchange.code}");
        Localstorage().saveString(key_login_token, token);
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> changePassword({String? newPassword}) async {
    String token = await Localstorage().getString(key_login_token)??"";
    final response = await http.post(
      Uri.parse(changepassword_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, String?>{"code": newPassword}),
    );

    if (response.statusCode == 200) {
      print("Password changed successfully :  ${jsonDecode(response.body)}");
      // String token = jsonDecode(response.body);
      return true;
    } else {
      return false;
    }
  }


  Future<PatientProfilePodo>? getPatientProfile(String? code) async {
      String? token;
      if(code == null){
        Future<String?> tk = Localstorage().getString(key_login_token);
        await tk.then((value) => {token = value!});
      }else{
        token = code;
      }
      final response = await http.get(
          Uri.parse(patientprofile_url), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        print("Got to this point 1");
        PatientProfilePodo profile = PatientProfilePodo.fromJson(
            jsonDecode(response.body));
        print("Got to this point 2");
        Localstorage().saveBasicDetails(profile);
        return profile;
      } else {
        print("Patient profile error ${response.statusCode} ");
        throw Exception("Couldn't pull patient profile ${response.statusCode}");
      }
  }

  Future<SleepDiariesPODO> saveSleepDiaries(
      {required SleepDiariesPODO sleepDiary}) async {
      // A TEST GROUND
      List<OtherMedicationsEntity>? testMeds = sleepDiary.getOthermeds();
      if (testMeds != null) {
        print("Network_test med is not null");
        if (testMeds.isNotEmpty) {
          print("Network_test med is not Empty");
          testMeds.forEach((element) {
            print("Network_Test Med Name : ${element.medicationName} ");
            print("Network_Test Med Amount : ${element.amount} ");
          });
        } else {
          print("Network_test med is Empty");
        }
      } else {
        print("Network_test med is null");
      }
      // END OF TEST GROUND

      String? token;
      Future<String?> tk = Localstorage().getString(key_login_token);
      await tk.then((value) => {token = value!});
      final result = await http.post(Uri.parse(save_sleepdiary_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "id": sleepDiary.id,
          "bedTime": sleepDiary.bedTime,
          "tryTosleepTime": sleepDiary.tryTosleepTime,
          "durationBeforesleepoff": sleepDiary.durationBeforesleepoff,
          "wakeUptimeCount": sleepDiary.wakeUptimeCount,
          "totalWakeUpduration": sleepDiary.totalWakeUpduration,
          "finalWakeupTime": sleepDiary.finalWakeupTime,
          "timeLeftbed": sleepDiary.timeLeftbed,
          "sleepQuality": sleepDiary.sleepQuality,
          "otherThings": sleepDiary.otherThings,
          // "medications": [],
          "othermedications": sleepDiary.getOthermeds(),
          // "othermedications": [{
          //   "medicationName": sleepDiary.getOthermeds()!.elementAt(0).medicationName,
          //   "amount": sleepDiary.getOthermeds()!.elementAt(0).amount
          // }],
          "date_Created": sleepDiary.dateCreated
        }),
      );

      if (result.statusCode == 201) {
        SleepDiariesPODO sleepDiary = SleepDiariesPODO.fromJson(
            jsonDecode(result.body));
        print("${sleepDiary.toString()}");
        return sleepDiary;
      } else {
        throw Exception("Couldn't pull patient profile , status code ${result
            .statusCode} ");
      }

  }


  Future<SleepClockDTO> getMysleepClock() async {
      var date = DateTime.now();
      var sDate = Workflow().getPastdate(date: date, numberOfdaysBack: 7);
      var eDate = Workflow().getPastdate(date: date, numberOfdaysBack: 0);
      String startDate = Workflow().convertDatetime2date(sDate.toString());
      String endDate = Workflow().convertDatetime2date(eDate.toString());

      String? token;
      Future<String?> tk = Localstorage().getString(key_login_token);
      await tk.then((value) => {token = value!});

      try {
        final response = await http.post(Uri.parse(my_sleepclock_url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, dynamic>{
            "startDate": startDate,
            "endDate": endDate
          }),
        );
        if (response.statusCode == 200) {
          SleepClockDTO sleepClock = SleepClockDTO.fromJson(
              jsonDecode(response.body));
          print("BED TIME : ${sleepClock.averagetimeinbed}");
          print("TIME IN BED : ${sleepClock.averagetimeinbed}");
          return sleepClock;
        } else {
          throw Exception("Couldn't pull my sleep Clock , status code ${response.statusCode} ");
        }
      } catch (e) {
        print("The error is  ${e.toString()}");
        throw Exception(
            "Couldn't pull my sleep Clock , status code ${e.toString()} ");
      }
  }


  Future<SleepReportDTO>  getMysleepReport(String? startDate, String? endDate )  async {
      if (startDate == null && endDate == null) {
        var date = DateTime.now();
        var sDate = Workflow().getPastdate(date: date, numberOfdaysBack: 21);
        var eDate = Workflow().getPastdate(date: date, numberOfdaysBack: 0);
        startDate = Workflow().convertDatetime2date(sDate.toString());
        endDate = Workflow().convertDatetime2date(eDate.toString());
      }

      String? token;
      Future<String?> tk = Localstorage().getString(key_login_token);
      await tk.then((value) => {token = value!});

      try {
        final response = await http.post(Uri.parse(my_sleepreport_url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, dynamic>{
            "startDate": startDate,
            "endDate": endDate
          }),
        );
        if (response.statusCode == 200) {
          SleepReportDTO sleepReport = SleepReportDTO.fromJson(
              jsonDecode(response.body));
          return sleepReport;
        } else {
          throw Exception(
              "Couldn't pull my sleep Report , status code ${response
                  .statusCode} ");
        }
      } catch (e) {
        print("The error is  ${e.toString()}");
        throw Exception(
            "Couldn't pull my sleep Report , status code ${e.toString()} ");
      }
    }

  Future<bool> feedback({String? feedback}) async {
    try {
      String? token;
      Future<String?> tk = Localstorage().getString(key_login_token);
      await tk.then((value) => {token = value!});

      final response = await http.post(
        Uri.parse(my_feedback_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
            <String, String?>{"code": feedback}),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Couldn't submit feedback");
      }
    }catch(e){
      print("feed back error ${e.toString()}");
      return false;
    }
  }

  Future<bool> voluntaryWithdrawal({String? withdrawalNote}) async {

    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    final response = await http.post(
      Uri.parse(voluntry_withdrawal_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, String?>{"code": withdrawalNote}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Couldn't submit Withdrawal");
    }
  }

  Future<PsychoeducationDTO> submitPsychoEducation({required PsychoeducationDTO psychoeducationDTO}) async {
      String? token;
      Future<String?> tk = Localstorage().getString(key_login_token);
      await tk.then((value) => {token = value!});

      final response = await http.post(
        Uri.parse(psychoeducation_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
            <String, dynamic>{
              "morethan30MinstoSleep": psychoeducationDTO.morethan30MinstoSleep,
              "wakeupfrequentlyatnight": psychoeducationDTO
                  .wakeupfrequentlyatnight,
              "wakeuptooearly": psychoeducationDTO.wakeuptooearly,
              "sleepqualitypoor": psychoeducationDTO.sleepqualitypoor,
              "ifeelconfident": psychoeducationDTO.ifeelconfident,
              "ithinkitsdifficult": psychoeducationDTO.ithinkitsdifficult,
              "idontknow": psychoeducationDTO.idontknow
            }),
      );

      if (response.statusCode == 201) {
        return PsychoeducationDTO.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            "Couldn't submit psycho education ${response.statusCode}");
      }
  }

  void submitsleepwindow({required Sleepwindows sleepwindow}) async {
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    final response = await http.post(
      Uri.parse(sleepwindow_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "bedtime": sleepwindow.bedtime,
            "risetime": sleepwindow.risetime,
            "revisedbedtime": sleepwindow.revisedbedtime,
            "revisedrisetime": sleepwindow.revisedrisetime
          }),
    );

    if (response.statusCode == 201) {
      print("Sleep window saved successfully");
    } else {
      throw Exception(
          "Couldn't submit sleep window ${response.statusCode}");
    }
  }


  Future<InterventionlevelOne> submitLevelone({required InterventionlevelOne levelone}) async {
    print(" item 1 is ${levelone.sleepalone}");
    print(" item 2 is ${levelone.supportPersonrelationshipt}");
    print(" item 3 is ${levelone.supportPersonemail}");
    print(" item 4 is ${levelone.supportPersonname}");
    print(" item 5 is ${levelone.howIsitgoingSofar}"); // FIX this
    print(" item 6 is ${levelone.whichBestdescribesYoursituation}");
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    final response = await http.post(
      Uri.parse(levelone_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "whichBestdescribesYoursituation": levelone.whichBestdescribesYoursituation,
            "howIsitgoingSofar": levelone.howIsitgoingSofar,
            "sleepalone": levelone.sleepalone,
            "supportPersonname": levelone.supportPersonname,
            "supportPersonemail": levelone.supportPersonemail,
            "supportPersonrelationshipt": levelone.supportPersonrelationshipt
          }),
    );

    if (response.statusCode == 201) {
      return InterventionlevelOne.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          "Couldn't submit level one ${response.statusCode}");
    }
  }


  Future<LeveltwoVariables> getLeveltwoVariables() async {
    var date = DateTime.now();
    var sDate = Workflow().getPastdate(date: date, numberOfdaysBack: 21);
    var eDate = Workflow().getPastdate(date: date, numberOfdaysBack: 0);
    String startDate = Workflow().convertDatetime2date(sDate.toString());
    String endDate = Workflow().convertDatetime2date(eDate.toString());

    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    try {
      final response = await http.post(Uri.parse(get_leveltwo_variables_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "startDate": startDate,
          "endDate": endDate
        }),
      );
      if (response.statusCode == 201) {
        LeveltwoVariables variables = LeveltwoVariables.fromJson(jsonDecode(response.body));

        return variables;
      } else {
        throw Exception("Couldn't pull my level 2 variables , status code ${response.statusCode} ");
      }
    } catch (e) {
      print("The error is  ${e.toString()}");
      throw Exception("Couldn't pull level 2 variables, status code ${e.toString()}");
    }
  }


  void submitLeveTwo({required LeveltwoVariables levelTwo}) async {
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    final response = await http.post(
      Uri.parse(leveltwo_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "revisedbedtime": levelTwo.newBedtime,
            "revisedrisetime": levelTwo.newRisetime
          }),
    );

    if (response.statusCode == 201) {
      print("Level two saved successfully");
    } else {
      throw Exception(
          "Couldn't submit level two ${response.statusCode}");
    }
  }

  void submitLevethree({required LevelthreeVariables level3}) async {
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    final response = await http.post(
      Uri.parse(levelthree_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "bedforsleepingonly" : level3.bedforsleepingonly,
            "sleep20minutes": level3.sleep20minutes,
            "dontTakenaps": level3.dontTakenaps,
            "excersiseNotbeforeBed": level3.excersiseNotbeforeBed,
            "eatRiht" : level3.eatRiht,
            "avoidStimulant": level3.avoidStimulant,
            "avoidAlcohol" : level3.avoidAlcohol,
            "createComfortablespace" : level3.createComfortablespace,
            "limitScreentimeBeforebed" : level3.limitScreentimeBeforebed,
            "createUnwindrouting" : level3.createUnwindrouting,
            "additionalNote" : level3.additionalNote
          }),
    );

    if (response.statusCode == 201) {
      print("Level three saved successfully");
    } else {
      throw Exception(
          "Couldn't submit level three ${response.statusCode}");
    }
  }


  void submitLevelfour({required bool levelfour}) async {
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    final response = await http.post(
      Uri.parse(levelfour_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "successful" : levelfour,
          }),
    );

    if (response.statusCode == 201) {
      print("Level four saved successfully ${response.body.toString()}");
    } else {
      throw Exception("Couldn't submit level four ${response.statusCode}");
    }
  }




  void submitLevelfive({required Levelfive levelfive}) async {
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    final response = await http.post(
      Uri.parse(levelfive_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "hoursofsleepeachnight" : levelfive.hoursofsleepeachnight,
            "fullofenergyeachday" : levelfive.fullofenergyeachday,
            "fallasleepfast" : levelfive.fallasleepfast,
            "didnotsleepwelllastnight" : levelfive.didnotsleepwelllastnight,
            "cancelsocialmedia" : levelfive.cancelsocialmedia,
          }),
    );

    if (response.statusCode == 201) {
      print("Level five saved successfully ${response.body.toString()}");
    } else {
      throw Exception("Couldn't submit level five ${response.statusCode}");
    }
  }

  void submitLevelsix({required LevelSix levelsix}) async {
    print("the fears is : ${levelsix.fears}");
    print("the strategy is : ${levelsix.strategy}");
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    final response = await http.post(
      Uri.parse(levelSix_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "fears" : levelsix.fears,
            "strategy" : levelsix.strategy
          }),
    );

    if (response.statusCode == 201) {
      print("Level Six saved successfully ${response.body.toString()}");
    } else {
      throw Exception("Couldn't submit level Six ${response.statusCode}");
    }
  }


  void sharesleepReport({required SleepReportDTO sleeport}) async {
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    final response = await http.post(
      Uri.parse(sharesleep_report_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, dynamic>{
            "firstName" : sleeport.firstName,
            "lastName" : sleeport.lastName,
            "age" : sleeport.age,
            "gender" : sleeport.gender,
            "averageBedtime" : sleeport.averageBedtime,
            "sleeplatency" : sleeport.sleeplatency,
            "averagenumberofawakenings" : sleeport.averagenumberofawakenings,
            "waso" : sleeport.waso,
            "tib" : sleeport.tib,
            "tst" : sleeport.tst,
            "se" : sleeport.se,
            "averageSleepHours" : sleeport.averageSleepHours,
            "startDate" : sleeport.startDate,
            "endDate" : sleeport.endDate
          }),
    );

    if (response.statusCode == 200) {
      print("Sleep report shared successfully with provider");
    } else {
      throw Exception("Couldn't share sleep report ${response.statusCode}");
    }
  }

}

