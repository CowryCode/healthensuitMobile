import 'package:healthensuite/api/networkmodels/interventionlevels/levelfivePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelonePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelsixPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/levelthreePODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoPODO.dart';
import 'package:healthensuite/api/networkmodels/interventionlevels/leveltwoVariables.dart';

class InterventionLevelsEntity {
  int? id;
  int? interventionLevel;
  InterventionlevelOne? levelOneEntity;
  InterventionlevelTwo? levelTwoEntity;
  LeveltwoVariables? leveltwoVariables;
  LevelthreeVariables? levelThreeEntity;
  Levelfive? levelFiveEntity;
  LevelSix? levelSixEntity;
  List<PsychoEducationreports>? psychoEducationreports;
  String? dateCreated;

  InterventionLevelsEntity(
      {this.id,
        this.interventionLevel,
        this.levelOneEntity,
        this.levelTwoEntity,
        this.leveltwoVariables,
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
    leveltwoVariables = json['leveltwoVariables'] != null ? new LeveltwoVariables.fromJson(json['leveltwoVariables']): null;

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
    if (this.leveltwoVariables != null) {
      data['leveltwoVariables'] = this.leveltwoVariables!.toJson();
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

  void setLevelOne(InterventionlevelOne value){
    this.levelOneEntity = value;
  }
  void setLevelTwo(InterventionlevelTwo value){
    this.levelTwoEntity = value;
  }
  void setLevelTwoVariables(LeveltwoVariables value){
    this.leveltwoVariables = value;
  }
  void setLevelThree(LevelthreeVariables value){
    this.levelThreeEntity = value;
  }
  void setLevelFive(Levelfive value){
    this.levelFiveEntity = value;
  }
  void setLevelSix(LevelSix value){
    this.levelSixEntity = value;
  }
}



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