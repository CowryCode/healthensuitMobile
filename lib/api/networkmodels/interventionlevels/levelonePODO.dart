class InterventionlevelOne {
  String? whichBestdescribesYoursituation;
  String? howIsitgoingSofar;
  String? sleepalone;
  String? nominateRoommate;
  String? supportPersonname;
  String? supportPersonemail;
  String? supportPersonrelationshipt;

  InterventionlevelOne(
      {this.whichBestdescribesYoursituation,
        this.howIsitgoingSofar,
        this.sleepalone,
        this.nominateRoommate,
        this.supportPersonname,
        this.supportPersonemail,
        this.supportPersonrelationshipt});

  InterventionlevelOne.fromJson(Map<String, dynamic> json) {
    whichBestdescribesYoursituation = json['whichBestdescribesYoursituation'];
    howIsitgoingSofar = json['howIsitgoingSofar'];
    sleepalone = json['sleepalone'];
    nominateRoommate = json['nominateRoommate'];
    supportPersonname = json['supportPersonname'];
    supportPersonemail = json['supportPersonemail'];
    supportPersonrelationshipt = json['supportPersonrelationshipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['whichBestdescribesYoursituation'] =
        this.whichBestdescribesYoursituation;
    data['howIsitgoingSofar'] = this.howIsitgoingSofar;
    data['sleepalone'] = this.sleepalone;
    data['nominateRoommate'] = this.nominateRoommate;
    data['supportPersonname'] = this.supportPersonname;
    data['supportPersonemail'] = this.supportPersonemail;
    data['supportPersonrelationshipt'] = this.supportPersonrelationshipt;
    return data;
  }

  void setwhichBestdescribesYoursituation(String value){
    this.whichBestdescribesYoursituation = value;
  }

  void sethowIsitgoingSofar(String value){
    this.howIsitgoingSofar = value;
  }
  void setsleepalone(String value){
    this.sleepalone = value;
  }
  void setnominateRoommate(String value){
    this.nominateRoommate = value;
  }
  void setsupportPersonname(String value){
    this.supportPersonname = value;
  }
  void setsupportPersonemail(String value){
    this.supportPersonemail = value;
  }
  void setsupportPersonrelationshipt(String value){
    this.supportPersonrelationshipt = value;
  }

  void nullifyWhichBestdescribesYoursituation(){
    this.whichBestdescribesYoursituation = null;
  }

  void nullifyHowIsitgoingSofar(){
    this.howIsitgoingSofar = null;
  }
}