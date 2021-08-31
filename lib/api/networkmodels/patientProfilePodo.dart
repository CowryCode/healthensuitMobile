import 'package:healthensuite/api/networkmodels/interventionLevelsEntityPODO.dart';
import 'package:healthensuite/api/networkmodels/regimenPODO.dart';
import 'package:healthensuite/api/networkmodels/sharedreportsPODO.dart';
import 'package:healthensuite/api/networkmodels/sleepwindowsPODO.dart';
import 'package:healthensuite/api/networkmodels/statusEntityPODO.dart';

import 'sleepDiaryPODO.dart';

class PatientProfilePodo {
  int? id;
  String? firstName;
  String? lastName;
  int? age;
  String? phoneNumber;
  String? email;
  bool? participatingInThestudy;
  String? gender;
  int? trialType;
  int? groupID;
  String? tapperStartDate;
  List<Regimen>? regimen;
  StatusEntity? statusEntity;
  List<SleepDiariesPODO>? sleepDiaries;
  List<Sleepwindows>? sleepwindows;
  InterventionLevelsEntity? interventionLevelsEntity;
  List<Sharedreports>? sharedreports;
  bool? voided;
  bool? verify;
  String? dateCreated;

  PatientProfilePodo(
      {this.id,
        this.firstName,
        this.lastName,
        this.age,
        this.phoneNumber,
        this.email,
        this.participatingInThestudy,
        this.gender,
        this.trialType,
        this.groupID,
        this.tapperStartDate,
        this.regimen,
        this.statusEntity,
        this.sleepDiaries,
        this.sleepwindows,
        this.interventionLevelsEntity,
        this.sharedreports,
        this.voided,
        this.verify,
        this.dateCreated});

  PatientProfilePodo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    participatingInThestudy = json['participatingInThestudy'];
    gender = json['gender'];
    trialType = json['trialType'];
    groupID = json['groupID'];
    tapperStartDate = json['tapperStartDate'];
    // tapperStartDate = json['tapperStartDate'] != null
    //     ? new TapperStartDate.fromJson(json['tapperStartDate'])
    //     : null;
    if (json['regimen'] != null ) {
      regimen = <Regimen>[];
     // regimen;
        json['regimen'].forEach((v) {
          regimen!.add(new Regimen.fromJson(v));
        });
    }
    statusEntity = json['statusEntity'] != null ? new StatusEntity.fromJson(json['statusEntity']) : null;
    if (json['sleepDiaries'] != null ) {
       sleepDiaries = <SleepDiariesPODO>[];
     //  sleepDiaries;
      json['sleepDiaries'].forEach((v) {
        sleepDiaries!.add(new SleepDiariesPODO.fromJson(v));
      });
    }
    if (json['sleepwindows'] != null) {
      print("Got to SleepWindow");
      sleepwindows = <Sleepwindows>[];
    //  sleepwindows;
      json['sleepwindows'].forEach((v) {
        print("Sleep Window is : ${new Sleepwindows.fromJson(v).toString()}");
        sleepwindows!.add(new Sleepwindows.fromJson(v));
      });
    }
    interventionLevelsEntity = json['interventionLevelsEntity'] != null
        ? new InterventionLevelsEntity.fromJson(
        json['interventionLevelsEntity'])
        : null;

    if (json['sharedreports'] != null) {
      // sharedreports;
      sharedreports = <Sharedreports>[];
        json['sharedreports'].forEach((v) {
          print(
              "Shared Report is : ${new Sharedreports.fromJson(v).toString()}");
          sharedreports!.add(new Sharedreports.fromJson(v));
        });
    }
    voided = json['voided'];
    verify = json['verify'];
    dateCreated = json['date_Created'];
    // dateCreated = json['date_Created'] != null
    //     ? new DateCreated.fromJson(json['date_Created'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['participatingInThestudy'] = this.participatingInThestudy;
    data['gender'] = this.gender;
    data['trialType'] = this.trialType;
    data['groupID'] = this.groupID;
    data['tapperStartDate'] = this.tapperStartDate;
    // if (this.tapperStartDate != null) {
    //   data['tapperStartDate'] = this.tapperStartDate!.toJson();
    // }
    if (this.regimen != null) {
      data['regimen'] = this.regimen!.map((v) => v.toJson()).toList();
    }
    if (this.statusEntity != null) {
      data['statusEntity'] = this.statusEntity!.toJson();
    }
    if (this.sleepDiaries != null) {
      data['sleepDiaries'] = this.sleepDiaries!.map((v) => v.toJson()).toList();
    }
    if (this.sleepwindows != null) {
      data['sleepwindows'] = this.sleepwindows!.map((v) => v.toJson()).toList();
    }
    if (this.interventionLevelsEntity != null) {
      data['interventionLevelsEntity'] = this.interventionLevelsEntity!.toJson();
    }
    if (this.sharedreports != null) {
      data['sharedreports'] =
          this.sharedreports!.map((v) => v.toJson()).toList();
    }
    // data['timeZoneID'] = this.timeZoneID;
    data['voided'] = this.voided;
    data['verify'] = this.verify;
    data['date_Created'] = this.dateCreated;
    // if (this.dateCreated != null) {
    //   data['date_Created'] = this.dateCreated!.toJson();
    // }
    return data;
  }
}



class BedTime {
  int? hour;
  int? minute;
  int? second;
  int? nano;

  BedTime({this.hour, this.minute, this.second, this.nano});

  BedTime.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minute = json['minute'];
    second = json['second'];
    nano = json['nano'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    data['second'] = this.second;
    data['nano'] = this.nano;
    return data;
  }
}
