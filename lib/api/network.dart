import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:healthensuite/api/networkUtilities.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelfivePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelsixPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelthreePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/loginobject.dart';
import 'package:healthensuite/api/networkmodels/loginPodo.dart';
import 'package:healthensuite/api/networkmodels/medicationsPODO.dart';
import 'package:healthensuite/api/networkmodels/mysleepclock.dart';
import 'package:healthensuite/api/networkmodels/otherMedicationsPODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/api/networkmodels/psychoeducationPODO.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';
import 'package:healthensuite/api/networkmodels/sleepwindowsPODO.dart';
import 'package:healthensuite/api/networkmodels/statusEntityPODO.dart';
import 'package:healthensuite/api/networkmodels/textexchangePODO.dart';
import 'package:healthensuite/api/statemanagement/actions.dart';
import 'package:healthensuite/api/statemanagement/app_state.dart';
import 'package:healthensuite/api/statemanagement/behaviourlogic.dart';
import 'package:healthensuite/api/statemanagement/diskstorage.dart';
import 'package:http/http.dart' as http;

import 'networkmodels/mysleepreport.dart';
import 'package:redux/redux.dart';

class ApiAccess {

 // Future<PatientProfilePodo>? login({String? username, String? password}) async {
  Future<LoginObject> login({String? username, String? password}) async {
    final response = await http.post(
      Uri.parse(loginURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String?>{"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      LoginPodo loginPodo = LoginPodo.fromJson(jsonDecode(response.body));
      print("Person ID : ${loginPodo.personID}");
      print("Token : ${loginPodo.token} ");
      String? token = loginPodo.token ?? "";
      print("Token 2 :  $token");
      Localstorage().saveString(key_login_token, token);
      Localstorage().saveBoolean(key_Login_Status, true);

      Status? status = loginPodo.status;
      if (status != null) {
        Localstorage().saveInteger(key_Next_Page, status.nextPage!);
        Localstorage().saveBoolean(
            key_Level_One, status.readInterventionGroupleveloneArticle!);
        Localstorage().saveBoolean(
            key_Level_Two, status.readInterventionGroupleveltwoArticle!);
        Localstorage().saveBoolean(
            key_Level_Three, status.readInterventionGrouplevelthreeArticle!);
        Localstorage().saveBoolean(
            key_Level_Four, status.readInterventionGrouplevelfourArticle!);
        Localstorage().saveBoolean(
            key_Level_Five, status.readInterventionGrouplevelfiveArticle!);
        Localstorage().saveBoolean(
            key_Level_Six, status.readInterventionGrouplevelsixArticle!);
      }
      PatientProfilePodo profile = await getPatientProfile(loginPodo.token);
      if (profile.firstName != null) {
        uploadDeviceIdentifier(token);

        return LoginObject(loginPodo: loginPodo, patientProfilePodo: profile);
      } else {
        throw Exception("Could not pull Profile ${response.statusCode}");
      }
    } else {
      throw Exception("Couldn't login, possible wrong passoword");
    }
  }


  void clearLocalData(){
      Localstorage().saveString(key_login_token, "");
      Localstorage().saveBoolean(key_Login_Status, false);
      Localstorage().saveInteger(key_Next_Page, -1);
      Localstorage().saveBoolean(key_Level_One, false);
      Localstorage().saveBoolean(key_Level_Two,false);
      Localstorage().saveBoolean(key_Level_Three, false);
      Localstorage().saveBoolean(key_Level_Four, false);
      Localstorage().saveBoolean(key_Level_Five, false);
      Localstorage().saveBoolean(key_Level_Six, false);
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
        print("The response is :  ${response.statusCode}");
        print("The TOKEN is :  ${response.statusCode}");
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

  Future<PatientProfilePodo>? refreshData() async {
    bool? loginStatus = await Localstorage().getBoolean(key_Login_Status);
    print('Login Status ${loginStatus}');
    if (loginStatus == null) {
      PatientProfilePodo emptyProfiel = PatientProfilePodo();
      return emptyProfiel;
    } else {
      PatientProfilePodo profile = await getPatientProfile(null) ;
      StatusEntity? status = profile.statusEntity;
      if (status != null) {
        Localstorage().saveInteger(key_Next_Page, status.nextPage!);
        Localstorage().saveBoolean(
            key_Level_One, status.readInterventionGroupleveloneArticle!);
        Localstorage().saveBoolean(
            key_Level_Two, status.readInterventionGroupleveltwoArticle!);
        Localstorage().saveBoolean(
            key_Level_Three, status.readInterventionGrouplevelthreeArticle!);
        Localstorage().saveBoolean(
            key_Level_Four, status.readInterventionGrouplevelfourArticle!);
        Localstorage().saveBoolean(
            key_Level_Five, status.readInterventionGrouplevelfiveArticle!);
        Localstorage().saveBoolean(
            key_Level_Six, status.readInterventionGrouplevelsixArticle!);
      }

      if (profile.firstName != null) {
        return profile;
      } else {
        throw Exception("Profile not available at the moment");
      }
    }
  }

  Future<PatientProfilePodo> getPatientProfile(String? code) async {
    print("Got to this point to pull Profile");
    String? token;
    bool? isLoggedin;
      if(code == null){
        Future<bool?> status = Localstorage().getBoolean(key_Login_Status);
        Future<String?> tk = Localstorage().getString(key_login_token);
        await status.then((value) => {isLoggedin = value});
        if(isLoggedin != null && isLoggedin == true){
          await tk.then((value) => {token = value!});
        }else{
          throw Exception("Couldn't pull patient profile");
        }
      }else{
        token = code;
      }
      print("The token is $token");
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

  Future<SleepDiariesPODO> saveSleepDiaries({required SleepDiariesPODO sleepDiary}) async {

    // print("IN NETWORK CLASS");
    //
    // print("ID: ${sleepDiary.id}, \n BetTime: ${sleepDiary.bedTime}, \nTryToSleepTime: ${sleepDiary.tryTosleepTime}, "
    //     "\nTakeYouToSleep: ${sleepDiary.durationBeforesleepoff}, \nTimesWakeUpCount: ${sleepDiary.wakeUptimeCount}, "
    //     "\nWakeUpDurationTime: ${sleepDiary.totalWakeUpduration}, \nFinalWakeupTime: ${sleepDiary.finalWakeupTime}, "
    //     "\nTimeLeftbed: ${sleepDiary.timeLeftbed}, \nSlpQuality: ${sleepDiary.sleepQuality}, "
    //     "\nCurrent Medication: ${sleepDiary.getmedications()},  "
    //     "\nOther Medicationa : ${sleepDiary.getOthermeds()},"
    //     "\nOtherThings: ${sleepDiary.otherThings}");


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
           "medications": sleepDiary.getmedications(),
          "othermedications": sleepDiary.getOthermeds(),
          "date_Created": sleepDiary.dateCreated
        }),
      );

      if (result.statusCode == 201) {
        SleepDiariesPODO sleepDiary = SleepDiariesPODO.fromJson(
            jsonDecode(result.body));
        print("${sleepDiary.toString()}");
        return sleepDiary;
      } else {
        throw Exception("Couldn't save patient profile , status code ${result.statusCode} ");
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

  Future<PsychoeducationDTO> getIncompletePsychoeducation() async {
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});

    try {
      final response = await http.get(Uri.parse(get_Incomplete_psychoeducation_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        // body: jsonEncode(<String, dynamic>{
        //   "startDate": startDate,
        //   "endDate": endDate
        // }),
      );
      if (response.statusCode == 200) {
        PsychoeducationDTO psychoEdu = PsychoeducationDTO.fromJson(jsonDecode(response.body));
        return psychoEdu;
      } else {
        throw Exception("Could not pull the PsychoEducation, status code ${response.statusCode} ");
      }
    } catch (e) {
      throw Exception("PsychoEducation error, status code ${e.toString()}");
    }
  }

  Future<PsychoeducationDTO> submitPsychoEducation({required PsychoeducationDTO psychoeducationDTO}) async {
      String? token;
      Future<String?> tk = Localstorage().getString(key_login_token);
      await tk.then((value) => {token = value!});

      print("PsycoEducation outPut");
      print("${psychoeducationDTO.id}");
      print("${psychoeducationDTO.ithinkitsdifficult}");
      print("${psychoeducationDTO.idontknow}");
      print("${psychoeducationDTO.ifeelconfident}");
      print("${psychoeducationDTO.wakeupfrequentlyatnight}");
      print("${psychoeducationDTO.wakeuptooearly}");
      print("${psychoeducationDTO.sleepqualitypoor}");
      print("${psychoeducationDTO.morethan30MinstoSleep}");

      final response = await http.post(
        Uri.parse(psychoeducation_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
            <String, dynamic>{
              "id": psychoeducationDTO.id,
              "morethan30MinstoSleep": psychoeducationDTO.morethan30MinstoSleep,
              "wakeupfrequentlyatnight": psychoeducationDTO
                  .wakeupfrequentlyatnight,
              "wakeuptooearly": psychoeducationDTO.wakeuptooearly,
              "sleepqualitypoor": psychoeducationDTO.sleepqualitypoor,
              "ifeelconfident": psychoeducationDTO.ifeelconfident,
              "ithinkitsdifficult": psychoeducationDTO.ithinkitsdifficult,
              "idontknow": psychoeducationDTO.idontknow,
              "completed": psychoeducationDTO.completed
            }),
      );

      if (response.statusCode == 201) {
        print("The psycho-education is submitted suffessfully");
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
        print("Saveed Level two Variables  . . . ");
        LeveltwoVariables variables = LeveltwoVariables.fromJson(jsonDecode(response.body));
        print("${variables.averagenumberofbedhours}");
        print("${variables.averagebedtiime}");
        print("${variables.averagerisetime}");
        print("${variables.averagesleepefficiency}");
        print("${variables.averagenumberofsleephours}");
        print("${variables.averagetimeinbed}");
        print("${variables.averagetotalsleeptime}");
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
            // "revisedbedtime": levelTwo.newBedtime,
            // "revisedrisetime": levelTwo.newRisetime,
            "revisedbedtime": levelTwo.averagebedtiime,
            "revisedrisetime": levelTwo.averagerisetime,
            "completed" : levelTwo.completed
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

    print(" The other note is ::::: ${level3.additionalNote}");

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

  void savePage({required int currentPage, required int interventionLevel}) async {
    bool isSavable = false;
    Future<bool> checkEligibility = isEligibletoSave(interventionLevel: interventionLevel, currentPage: currentPage);
    await checkEligibility.then((value) => {
      isSavable = value,
      print("the eligibility status is T: $isSavable")
    });
    if(isSavable == true) {
      print("the eligibility status is T1: $isSavable");
      String? token;
      Future<String?> tk = Localstorage().getString(key_login_token);
      await tk.then((value) => {token = value!});
      final response = await http.get(
          Uri.parse("$Save_Page_url/$currentPage"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );

      if (response.statusCode == 201) {
        print("Page Session saved ${response.body.toString()}");
      } else {
        throw Exception("Page session couldn't saved ${response.statusCode}");
      }
    }
  }

  Future<bool> isEligibletoSave({required int interventionLevel, required int currentPage}) async{
    bool? isLevelCompleted;
    switch(interventionLevel){
      case 1:
        isLevelCompleted = await Localstorage().getBoolean(key_Level_One);
        break;
      case 2:
        isLevelCompleted = await Localstorage().getBoolean(key_Level_Two);
        break;
      case 3:
        isLevelCompleted = await Localstorage().getBoolean(key_Level_Three);
        break;
      case 4:
        isLevelCompleted = await Localstorage().getBoolean(key_Level_Four);
        break;
      case 5:
        isLevelCompleted = await Localstorage().getBoolean(key_Level_Five);
        break;
      case 6:
        isLevelCompleted = await Localstorage().getBoolean(key_Level_Six);
        break;
      case 7:
        return true; // The level 7 is used for PsychoEducation (it should always be true)
    }

    if(isLevelCompleted!){
      return false;
    } else{
      int? lastPage = await Localstorage().getInteger(key_Next_Page);
      if(currentPage < lastPage!){
        return false;
      }return true;
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


  void saveDeviceIdentifier({String? code}) async {
    Localstorage().saveString(key_Device_Identifier, code!);
  }

  Future<bool> uploadDeviceIdentifier(String token) async {
    String? identifier;
    Future<String?> tk = Localstorage().getString(key_Device_Identifier);
    await tk.then((value) => {identifier = value});

    final response = await http.post(
      Uri.parse(submitDeviceIdentifier_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(
          <String, String?>{"code": identifier}),
    );

    if (response.statusCode == 201) {
      print("Successfully saved");
      return true;
    }else{
      return false;
    }
  }
}

