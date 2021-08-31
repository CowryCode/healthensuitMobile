class PsychoeducationDTO {
  bool? morethan30MinstoSleep;
  bool? wakeupfrequentlyatnight;
  bool? wakeuptooearly;
  bool? sleepqualitypoor;
  bool? ifeelconfident;
  bool? ithinkitsdifficult;
  bool? idontknow;

  PsychoeducationDTO(
      {this.morethan30MinstoSleep,
        this.wakeupfrequentlyatnight,
        this.wakeuptooearly,
        this.sleepqualitypoor,
        this.ifeelconfident,
        this.ithinkitsdifficult,
        this.idontknow});

  PsychoeducationDTO.fromJson(Map<String, dynamic> json) {
    morethan30MinstoSleep = json['morethan30MinstoSleep'];
    wakeupfrequentlyatnight = json['wakeupfrequentlyatnight'];
    wakeuptooearly = json['wakeuptooearly'];
    sleepqualitypoor = json['sleepqualitypoor'];
    ifeelconfident = json['ifeelconfident'];
    ithinkitsdifficult = json['ithinkitsdifficult'];
    idontknow = json['idontknow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['morethan30MinstoSleep'] = this.morethan30MinstoSleep;
    data['wakeupfrequentlyatnight'] = this.wakeupfrequentlyatnight;
    data['wakeuptooearly'] = this.wakeuptooearly;
    data['sleepqualitypoor'] = this.sleepqualitypoor;
    data['ifeelconfident'] = this.ifeelconfident;
    data['ithinkitsdifficult'] = this.ithinkitsdifficult;
    data['idontknow'] = this.idontknow;
    return data;
  }

  void setmorethan30MinstoSleep(bool value){
    this.morethan30MinstoSleep = value;
  }
  void setwakeupfrequentlyatnight(bool value){
    this.wakeupfrequentlyatnight = value;
  }
  void setwakeuptooearly(bool value){
    this.wakeuptooearly = value;
  }
  void setsleepqualitypoor(bool value){
    this.sleepqualitypoor = value;
  }
  void setifeelconfident(bool value){
    this.ifeelconfident = value;
  }
  void setithinkitsdifficult(bool value){
    this.ithinkitsdifficult = value;
  }
  void setidontknow(bool value){
    this.idontknow = value;
  }
}