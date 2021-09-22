class LevelthreeVariables {
  bool? bedforsleepingonly;
  bool? sleep20minutes;
  bool? dontTakenaps;
  bool? excersiseNotbeforeBed;
  bool? eatRiht;
  bool? avoidStimulant;
  bool? avoidAlcohol;
  bool? createComfortablespace;
  bool? limitScreentimeBeforebed;
  bool? createUnwindrouting;
  String? additionalNote;

  LevelthreeVariables(
      {this.bedforsleepingonly,
        this.sleep20minutes,
        this.dontTakenaps,
        this.excersiseNotbeforeBed,
        this.eatRiht,
        this.avoidStimulant,
        this.avoidAlcohol,
        this.createComfortablespace,
        this.limitScreentimeBeforebed,
        this.createUnwindrouting,
        this.additionalNote});

  LevelthreeVariables.fromJson(Map<String, dynamic> json) {
    bedforsleepingonly = json['bedforsleepingonly'];
    sleep20minutes = json['sleep20minutes'];
    dontTakenaps = json['dontTakenaps'];
    excersiseNotbeforeBed = json['excersiseNotbeforeBed'];
    eatRiht = json['eatRiht'];
    avoidStimulant = json['avoidStimulant'];
    avoidAlcohol = json['avoidAlcohol'];
    createComfortablespace = json['createComfortablespace'];
    limitScreentimeBeforebed = json['limitScreentimeBeforebed'];
    createUnwindrouting = json['createUnwindrouting'];
    additionalNote = json['additionalNote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bedforsleepingonly'] = this.bedforsleepingonly;
    data['sleep20minutes'] = this.sleep20minutes;
    data['dontTakenaps'] = this.dontTakenaps;
    data['excersiseNotbeforeBed'] = this.excersiseNotbeforeBed;
    data['eatRiht'] = this.eatRiht;
    data['avoidStimulant'] = this.avoidStimulant;
    data['avoidAlcohol'] = this.avoidAlcohol;
    data['createComfortablespace'] = this.createComfortablespace;
    data['limitScreentimeBeforebed'] = this.limitScreentimeBeforebed;
    data['createUnwindrouting'] = this.createUnwindrouting;
    data['additionalNote'] = this.additionalNote;
    return data;
  }

  void updateFields(String choices){
    if(choices.contains("0")){
      this.bedforsleepingonly = true;
    }else{
      this.bedforsleepingonly = false;
    }
    if(choices.contains("1")){
      this.sleep20minutes = true;
    }else{
      this.sleep20minutes = false;
    }
    if(choices.contains("2")){
      this.dontTakenaps = true;
    }else{
      this.dontTakenaps = false;
    }
    if(choices.contains("3")){
      this.excersiseNotbeforeBed = true;
    }else{
      this.excersiseNotbeforeBed = false;
    }
    if(choices.contains("4")){
      this.eatRiht = true;
    }else{
      this.eatRiht = false;
    }
    if(choices.contains("5")){
      this.avoidStimulant = true;
    }else{
      this.avoidStimulant = false;
    }
    if(choices.contains("6")){
      this.avoidAlcohol = true;
    }else{
      this.avoidAlcohol = false;
    }
    if(choices.contains("7")){
      this.createComfortablespace = true;
    }else{
      this.createComfortablespace = false;
    }
    if(choices.contains("8")){
      this.limitScreentimeBeforebed = true;
    }else{
      this.limitScreentimeBeforebed = false;
    }
    if(choices.contains("9")){
      this.createUnwindrouting = true;
    }else{
      this.createUnwindrouting = false;
    }
  }

  void setNote({ String? note}){
    this.additionalNote = note;
  }
}