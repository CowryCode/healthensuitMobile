
import 'package:flutter/material.dart';
import 'package:healthensuite/api/networkmodels/medicationsPODO.dart';
import 'package:healthensuite/api/networkmodels/sleepDiaryPODO.dart';
import 'package:healthensuite/api/networkmodels/patientProfilePodo.dart';
import 'package:healthensuite/screens/sleepDiary/sleep_diary.dart';
import 'package:intl/intl.dart';

class Workflow{
  SleepDiariesPODO? getSleepDiary(List<SleepDiariesPODO>? sleepdiaries, {bool todaySleepDiary = false, bool yesterdaySleepDiary = false}){
    if(sleepdiaries == null ){
      return null;
    }else{
      final now = DateTime.now();
      final dummy = DateTime(now.year, now.month, now.day - 10);
      SleepDiariesPODO sleepDiariesPODO = SleepDiariesPODO();
      sleepdiaries.forEach((sleepdiary) {
        String datecreated = sleepdiary.dateCreated ?? dummy.toString();
        if (todaySleepDiary) {
          if (isToday(datecreated)) {
            sleepDiariesPODO = sleepdiary;
          }
        } else if (yesterdaySleepDiary) {
          if (isYesterday(datecreated)) {
            sleepDiariesPODO = sleepdiary;
          }
        }
      });
      return sleepDiariesPODO;
    }
  }

  bool isSleepDiaryavailable(SleepDiariesPODO sleepDiariesPODO){
    if(sleepDiariesPODO.dateCreated != null){
      return true;
    }else{
      return false;
    }
  }

  bool isToday(String dateTime){
    var date = DateTime.parse(dateTime);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate = DateTime(date.year, date.month, date.day);
    if(aDate == today){
      return true;
    }else return false;
  }

  bool isYesterday(String dateTime){
    final date = DateTime.parse(dateTime);
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(date.year, date.month, date.day);
    if(aDate == yesterday){
      return true;
    }else return false;
  }

  String convertDatetime2date(String datetime){
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime date = DateTime.parse(datetime);
    final String formatted_date = formatter.format(date);
    return formatted_date;
  }

  List<int>? convertMinutestoHRnMin({double? timeinMinutes}){
    print("Total Minutes : ${timeinMinutes}");
    if(timeinMinutes != null){
      int mins = (timeinMinutes % 60).round();
      int hour = ((timeinMinutes - mins) / 60).round();
      print("Hour Part : ${hour}");
      print("Minutes Part : ${mins}");
      return [hour, mins];
    }
  }


  String? converTimeTo24HoursFormat({required String dateTime}){
    try {
      if (dateTime != null) {
        List<String> str = dateTime.split(" ");
        if (str.length > 1) {
          String time = str[1];
          List<String> timesplit = time.split(".");
          return timesplit[0];
        }
      }
    }catch(e){
      // Do nothing
    }
  }

  TimeOfDay? convertStringtoTimeofDay(String?  time){
    if(time != null) {
      var tt = time.split(":");
      int hour = int.parse(tt[0]);
      int minute = int.parse(tt[1]);
      TimeOfDay tod = TimeOfDay(hour: hour, minute: minute);
      return tod;
    }
  }

  Medications? getMedications(List<Medications>? meds, {bool isfirstmedication = false, bool isSecondmedication = false}) {
    if(meds != null && meds.length > 0){
      if(isfirstmedication){
        return meds[0];
      }else if(isSecondmedication){
        if(meds.length > 1){
          return meds[1];
        }
      }
    }
  }

  DateTime getPastdate({required DateTime date, required int numberOfdaysBack}){
    final now = DateTime.now();
    final pastDate = DateTime(now.year, now.month, now.day - numberOfdaysBack);
    return pastDate;
  }

  String convertDatetoStringforAPI({required DateTime dateTime}){
    String sMonth ;
    String sDay ;
    if(dateTime.month < 10){
      sMonth = "0${dateTime.month}";
    }else{
      sMonth = "${dateTime.month}";
    }
    if(dateTime.day < 10){
      sDay = "0${dateTime.day}";
    }else{
      sDay = "${dateTime.day}";
    }
    String date = "${dateTime.year}-${sMonth}-${sDay}";
    return date;
  }

  double changeDecimalplaces({required double value, required int decimalplaces}){
    double newNum = double.parse((12.5668).toStringAsFixed(decimalplaces));
    return newNum;
  }

  // ALERT BUTTON

}