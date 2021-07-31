import 'dart:convert';
import 'package:healthensuite/api/networkmodels/mysleepclock.dart';
import 'package:healthensuite/api/statemanagement/behaviourlogic.dart';
import 'package:healthensuite/api/statemanagement/diskstorage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'networkUtilities.dart';
import 'networkmodels/loginPodo.dart';
import 'networkmodels/otherMedicationsPODO.dart';
import 'networkmodels/sleepDiaryPODO.dart';
import 'networkmodels/patientProfilePodo.dart';

class ApiAccess {
  Future<LoginPodo> login({String? username, String? password}) async {
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
      String? token = cc.token ?? "";
      print("Token 2 :  $token");
      Localstorage().saveString(key_login_token, token);
      return cc;
    } else {
      throw Exception("Couldn't login, possible wrong passoword");
    }
  }

  String? getLoginToken() {
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    tk.then((value) => {token = value!});
    return token;
  }

  Future<PatientProfilePodo>? getPatientProfile() async {
    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});
    final response =
        await http.get(Uri.parse(patientprofile_url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      PatientProfilePodo profile =  PatientProfilePodo.fromJson(jsonDecode(response.body));
      Localstorage().saveBasicDetails(profile);
      return profile;
    } else {
      throw Exception("Couldn't pull patient profile");
    }
  }

  Future<SleepDiariesPODO> saveSleepDiaries(
      {required SleepDiariesPODO sleepDiary}) async {

    // A TEST GROUND
    List<OtherMedicationsEntity>? testMeds = sleepDiary.getOthermeds();
    if(testMeds != null){
      print("Network_test med is not null");
      if(testMeds.isNotEmpty){
        print("Network_test med is not Empty");
        testMeds.forEach((element) {
          print("Network_Test Med Name : ${element.medicationName} ");
          print("Network_Test Med Amount : ${element.amount} ");
        });
      }else{
        print("Network_test med is Empty");
      }
    }else{
      print("Network_test med is null");
    }
    // END OF TEST GROUND

    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});
    final response = await http.post(Uri.parse(save_sleepdiary_url),
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
          "othermedications" : sleepDiary.getOthermeds(),
          // "othermedications": [{
          //   "medicationName": sleepDiary.getOthermeds()!.elementAt(0).medicationName,
          //   "amount": sleepDiary.getOthermeds()!.elementAt(0).amount
          // }],
          "date_Created": sleepDiary.dateCreated
        }),
        );

    if (response.statusCode == 201) {
      SleepDiariesPODO sleepDiary = SleepDiariesPODO.fromJson(jsonDecode(response.body));
      print("${sleepDiary.toString()}");
      return sleepDiary;
    } else {
      throw Exception("Couldn't pull patient profile , status code ${response.statusCode} " );
    }
  }

  Future<MysleepClock> getMysleepClock() async {
    var date = DateTime.now();

    var sDate = Workflow().getPastdate(date: date, numberOfdaysBack: 21);
    var eDate =   Workflow().getPastdate(date: date, numberOfdaysBack: 0);


    String startDate = Workflow().convertDatetime2date(sDate.toString());
    String endDate =   Workflow().convertDatetime2date(eDate.toString());

    String? token;
    Future<String?> tk = Localstorage().getString(key_login_token);
    await tk.then((value) => {token = value!});
    print("Start date is ${startDate}");
    print("End date is ${endDate}");
    print("The token is : ${token}");

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

    if (response.statusCode == 201) {
      MysleepClock sleepClock = MysleepClock.fromJson(jsonDecode(response.body));
      print("${sleepClock.toString()}");
      return sleepClock;
    } else {
      throw Exception("Couldn't pull my sleep Clock , status code ${response.statusCode} " );
    }
  }

}
