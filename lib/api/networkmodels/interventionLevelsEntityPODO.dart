import 'package:healthensuite/api/networkmodels/psychoeducationPODO.dart';

class InterventionLevelsEntity {
  int? id;
  int? interventionLevel;
 // Null levelOneEntity;
 // Null levelTwoEntity;
 // Null levelThreeEntity;
 // Null levelFiveEntity;
 // Null levelSixEntity;
 // List<PsychoeducationDTO>? psychoEducationreports;
  String? dateCreated;

  InterventionLevelsEntity(
      {this.id,
        this.interventionLevel,
      //  this.levelOneEntity,
      //  this.levelTwoEntity,
      //  this.levelThreeEntity,
      //  this.levelFiveEntity,
      //  this.levelSixEntity,
      //  this.psychoEducationreports,
        this.dateCreated});

  InterventionLevelsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    interventionLevel = json['interventionLevel'];
  //  levelOneEntity = json['levelOneEntity'];
  //  levelTwoEntity = json['levelTwoEntity'];
  //  levelThreeEntity = json['levelThreeEntity'];
  //  levelFiveEntity = json['levelFiveEntity'];
  //  levelSixEntity = json['levelSixEntity'];
    dateCreated = json['date_Created'];
  //  psychoEducationreports = json['psychoEducationreports'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['interventionLevel'] = this.interventionLevel;
   // data['levelOneEntity'] = this.levelOneEntity;
   // data['levelTwoEntity'] = this.levelTwoEntity;
   // data['levelThreeEntity'] = this.levelThreeEntity;
   // data['levelFiveEntity'] = this.levelFiveEntity;
   // data['levelSixEntity'] = this.levelSixEntity;
  //  data['psychoEducationreports'] = this.psychoEducationreports;
    data['date_Created'] = this.dateCreated;
    // if (this.dateCreated != null) {
    //   data['date_Created'] = this.dateCreated!.toJson();
    // }
    return data;
  }
}
