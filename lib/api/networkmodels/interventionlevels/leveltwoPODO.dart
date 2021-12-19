class InterventionlevelTwo {
  int? id;
  String? bedtime;
  String? risetime;
  String? revisedbedtime;
  String? revisedrisetime;
  String? dateCreated;

  InterventionlevelTwo(
      {this.id,
        this.bedtime,
        this.risetime,
        this.revisedbedtime,
        this.revisedrisetime,
        this.dateCreated});

  InterventionlevelTwo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bedtime = json['bedtime'];
    // json['bedtime'] != null ? new BedTime.fromJson(json['bedtime']) : null;
    risetime = json['risetime'] ;
    // risetime = json['risetime'] != null
    //     ? new BedTime.fromJson(json['risetime'])
    //     : null;
    revisedbedtime = json['revisedbedtime'];
    // revisedbedtime = json['revisedbedtime'] != null
    //     ? new BedTime.fromJson(json['revisedbedtime'])
    //     : null;
    revisedrisetime = json['revisedrisetime'];
    // revisedrisetime = json['revisedrisetime'] != null
    //     ? new BedTime.fromJson(json['revisedrisetime'])
    //     : null;
    dateCreated = json['date_Created'];
    // dateCreated = json['date_Created'] != null
    //     ? new DateCreated.fromJson(json['date_Created'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.bedtime != null) {
      data['bedtime'] = this.bedtime;
    }
    if (this.risetime != null) {
      data['risetime'] = this.risetime;
    }
    if (this.revisedbedtime != null) {
      data['revisedbedtime'] = this.revisedbedtime;
    }
    if (this.revisedrisetime != null) {
      data['revisedrisetime'] = this.revisedrisetime;
    }
    data['date_Created'] = this.dateCreated;
    return data;
  }

  void setbedtime(String value){
    this.bedtime = value;
  }
  void setrisetime(String value){
    this.risetime = value;
  }
  void setrevisedbedtime(String value){
    this.revisedbedtime = value;
  }
  void setrevisedrisetime(String value){
    this.revisedrisetime = value;
  }
}
