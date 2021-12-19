import 'package:healthensuite/api/networkmodels/interventionlevels/levelfivePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelsixPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelthreePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoPODO.dart';

class InterventionLevelsEntity {
  int? id;
  int? interventionLevel;
  // LevelOneEntity? levelOneEntity;
  InterventionlevelOne? levelOneEntity;
 // LevelTwoEntity? levelTwoEntity;
  InterventionlevelTwo? levelTwoEntity;
 // LevelThreeEntity? levelThreeEntity;
  LevelthreeVariables? levelThreeEntity;
 // LevelFiveEntity? levelFiveEntity;
  Levelfive? levelFiveEntity;
 // LevelSixEntity? levelSixEntity;
  LevelSix? levelSixEntity;
  List<PsychoEducationreports>? psychoEducationreports;
  String? dateCreated;

  InterventionLevelsEntity(
      {this.id,
        this.interventionLevel,
        this.levelOneEntity,
        this.levelTwoEntity,
        this.levelThreeEntity,
        this.levelFiveEntity,
        this.levelSixEntity,
        this.psychoEducationreports,
        this.dateCreated});

  InterventionLevelsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    interventionLevel = json['interventionLevel'];
    levelOneEntity = json['levelOneEntity'] != null ? new InterventionlevelOne.fromJson(json['levelOneEntity']): null;

    levelTwoEntity = json['levelTwoEntity'] != null ? new InterventionlevelTwo.fromJson(json['levelTwoEntity']): null;

    levelThreeEntity = json['levelThreeEntity'] != null ? new LevelthreeVariables.fromJson(json['levelThreeEntity'])
        : null;
    levelFiveEntity = json['levelFiveEntity'] != null ? new Levelfive.fromJson(json['levelFiveEntity']): null;
    levelSixEntity = json['levelSixEntity'] != null ? new LevelSix.fromJson(json['levelSixEntity'])
        : null;
    if (json['psychoEducationreports'] != null) {
      psychoEducationreports = <PsychoEducationreports>[];
      json['psychoEducationreports'].forEach((v) {
        psychoEducationreports!.add(new PsychoEducationreports.fromJson(v));
      });
    }
    dateCreated = json['date_Created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['interventionLevel'] = this.interventionLevel;
    if (this.levelOneEntity != null) {
      data['levelOneEntity'] = this.levelOneEntity!.toJson();
    }
    if (this.levelTwoEntity != null) {
      data['levelTwoEntity'] = this.levelTwoEntity!.toJson();
    }
    if (this.levelThreeEntity != null) {
      data['levelThreeEntity'] = this.levelThreeEntity!.toJson();
    }
    if (this.levelFiveEntity != null) {
      data['levelFiveEntity'] = this.levelFiveEntity!.toJson();
    }
    if (this.levelSixEntity != null) {
      data['levelSixEntity'] = this.levelSixEntity!.toJson();
    }
    if (this.psychoEducationreports != null) {
      data['psychoEducationreports'] =
          this.psychoEducationreports!.map((v) => v.toJson()).toList();
    }
    data['date_Created'] = this.dateCreated;
    return data;
  }
}

// class LevelOneEntity {
//   int? id;
//   String? whichBestdescribesYoursituation;
//   String? howIsitgoingSofar;
//   String? sleepalone;
//   String? nominateRoommate;
//   String? supportPersonname;
//   String? supportPersonemail;
//   String? supportPersonrelationshipt;
//   String? dateCreated;
//
//   LevelOneEntity(
//       {this.id,
//         this.whichBestdescribesYoursituation,
//         this.howIsitgoingSofar,
//         this.sleepalone,
//         this.nominateRoommate,
//         this.supportPersonname,
//         this.supportPersonemail,
//         this.supportPersonrelationshipt,
//         this.dateCreated});
//
//   LevelOneEntity.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     whichBestdescribesYoursituation = json['whichBestdescribesYoursituation'];
//     howIsitgoingSofar = json['howIsitgoingSofar'];
//     sleepalone = json['sleepalone'];
//     nominateRoommate = json['nominateRoommate'];
//     supportPersonname = json['supportPersonname'];
//     supportPersonemail = json['supportPersonemail'];
//     supportPersonrelationshipt = json['supportPersonrelationshipt'];
//     dateCreated = json['date_Created'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['whichBestdescribesYoursituation'] =
//         this.whichBestdescribesYoursituation;
//     data['howIsitgoingSofar'] = this.howIsitgoingSofar;
//     data['sleepalone'] = this.sleepalone;
//     data['nominateRoommate'] = this.nominateRoommate;
//     data['supportPersonname'] = this.supportPersonname;
//     data['supportPersonemail'] = this.supportPersonemail;
//     data['supportPersonrelationshipt'] = this.supportPersonrelationshipt;
//     data['date_Created'] = this.dateCreated;
//     return data;
//   }
// }

// class LevelTwoEntity {
//   int? id;
//   String? bedtime;
//   String? risetime;
//   String? revisedbedtime;
//   String? revisedrisetime;
//   String? dateCreated;
//
//   LevelTwoEntity(
//       {this.id,
//         this.bedtime,
//         this.risetime,
//         this.revisedbedtime,
//         this.revisedrisetime,
//         this.dateCreated});
//
//   LevelTwoEntity.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     bedtime = json['bedtime'];
//     risetime = json['risetime'];
//     revisedbedtime = json['revisedbedtime'];
//     revisedrisetime = json['revisedrisetime'];
//     dateCreated = json['date_Created'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['bedtime'] = this.bedtime;
//     data['risetime'] = this.risetime;
//     data['revisedbedtime'] = this.revisedbedtime;
//     data['revisedrisetime'] = this.revisedrisetime;
//     data['date_Created'] = this.dateCreated;
//     return data;
//   }
// }
//
// class LevelThreeEntity {
//   int? id;
//   bool? bedforsleepingonly;
//   bool? sleep20minutes;
//   bool? dontTakenaps;
//   bool? excersiseNotbeforeBed;
//   bool? eatRiht;
//   bool? avoidStimulant;
//   bool? avoidAlcohol;
//   bool? createComfortablespace;
//   bool? limitScreentimeBeforebed;
//   bool? createUnwindrouting;
//   String? additionalNote;
//   String? dateCreated;
//
//   LevelThreeEntity(
//       {this.id,
//         this.bedforsleepingonly,
//         this.sleep20minutes,
//         this.dontTakenaps,
//         this.excersiseNotbeforeBed,
//         this.eatRiht,
//         this.avoidStimulant,
//         this.avoidAlcohol,
//         this.createComfortablespace,
//         this.limitScreentimeBeforebed,
//         this.createUnwindrouting,
//         this.additionalNote,
//         this.dateCreated});
//
//   LevelThreeEntity.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     bedforsleepingonly = json['bedforsleepingonly'];
//     sleep20minutes = json['sleep20minutes'];
//     dontTakenaps = json['dontTakenaps'];
//     excersiseNotbeforeBed = json['excersiseNotbeforeBed'];
//     eatRiht = json['eatRiht'];
//     avoidStimulant = json['avoidStimulant'];
//     avoidAlcohol = json['avoidAlcohol'];
//     createComfortablespace = json['createComfortablespace'];
//     limitScreentimeBeforebed = json['limitScreentimeBeforebed'];
//     createUnwindrouting = json['createUnwindrouting'];
//     additionalNote = json['additionalNote'];
//     dateCreated = json['date_Created'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['bedforsleepingonly'] = this.bedforsleepingonly;
//     data['sleep20minutes'] = this.sleep20minutes;
//     data['dontTakenaps'] = this.dontTakenaps;
//     data['excersiseNotbeforeBed'] = this.excersiseNotbeforeBed;
//     data['eatRiht'] = this.eatRiht;
//     data['avoidStimulant'] = this.avoidStimulant;
//     data['avoidAlcohol'] = this.avoidAlcohol;
//     data['createComfortablespace'] = this.createComfortablespace;
//     data['limitScreentimeBeforebed'] = this.limitScreentimeBeforebed;
//     data['createUnwindrouting'] = this.createUnwindrouting;
//     data['additionalNote'] = this.additionalNote;
//     data['date_Created'] = this.dateCreated;
//     return data;
//   }
// }
//
// class LevelFiveEntity {
//   int? id;
//   String? hoursofsleepeachnight;
//   String? fullofenergyeachday;
//   String? fallasleepfast;
//   String? didnotsleepwelllastnight;
//   String? cancelsocialmedia;
//   String? dateCreated;
//
//   LevelFiveEntity(
//       {this.id,
//         this.hoursofsleepeachnight,
//         this.fullofenergyeachday,
//         this.fallasleepfast,
//         this.didnotsleepwelllastnight,
//         this.cancelsocialmedia,
//         this.dateCreated});
//
//   LevelFiveEntity.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     hoursofsleepeachnight = json['hoursofsleepeachnight'];
//     fullofenergyeachday = json['fullofenergyeachday'];
//     fallasleepfast = json['fallasleepfast'];
//     didnotsleepwelllastnight = json['didnotsleepwelllastnight'];
//     cancelsocialmedia = json['cancelsocialmedia'];
//     dateCreated = json['date_Created'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['hoursofsleepeachnight'] = this.hoursofsleepeachnight;
//     data['fullofenergyeachday'] = this.fullofenergyeachday;
//     data['fallasleepfast'] = this.fallasleepfast;
//     data['didnotsleepwelllastnight'] = this.didnotsleepwelllastnight;
//     data['cancelsocialmedia'] = this.cancelsocialmedia;
//     data['date_Created'] = this.dateCreated;
//     return data;
//   }
// }
//
// class LevelSixEntity {
//   int? id;
//   String? fears;
//   String? strategy;
//   String? dateCreated;
//
//   LevelSixEntity({this.id, this.fears, this.strategy, this.dateCreated});
//
//   LevelSixEntity.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     fears = json['fears'];
//     strategy = json['strategy'];
//     dateCreated = json['date_Created'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['fears'] = this.fears;
//     data['strategy'] = this.strategy;
//     data['date_Created'] = this.dateCreated;
//     return data;
//   }
// }

class PsychoEducationreports {
  int? id;
  bool? morethan30MinstoSleep;
  bool? wakeupfrequentlyatnight;
  bool? wakeuptooearly;
  bool? sleepqualitypoor;
  bool? ifeelconfident;
  bool? ithinkitsdifficult;
  bool? idontknow;
  String? dateCreated;

  PsychoEducationreports(
      {this.id,
        this.morethan30MinstoSleep,
        this.wakeupfrequentlyatnight,
        this.wakeuptooearly,
        this.sleepqualitypoor,
        this.ifeelconfident,
        this.ithinkitsdifficult,
        this.idontknow,
        this.dateCreated});

  PsychoEducationreports.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    morethan30MinstoSleep = json['morethan30MinstoSleep'];
    wakeupfrequentlyatnight = json['wakeupfrequentlyatnight'];
    wakeuptooearly = json['wakeuptooearly'];
    sleepqualitypoor = json['sleepqualitypoor'];
    ifeelconfident = json['ifeelconfident'];
    ithinkitsdifficult = json['ithinkitsdifficult'];
    idontknow = json['idontknow'];
    dateCreated = json['date_Created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['morethan30MinstoSleep'] = this.morethan30MinstoSleep;
    data['wakeupfrequentlyatnight'] = this.wakeupfrequentlyatnight;
    data['wakeuptooearly'] = this.wakeuptooearly;
    data['sleepqualitypoor'] = this.sleepqualitypoor;
    data['ifeelconfident'] = this.ifeelconfident;
    data['ithinkitsdifficult'] = this.ithinkitsdifficult;
    data['idontknow'] = this.idontknow;
    data['date_Created'] = this.dateCreated;
    return data;
  }
}