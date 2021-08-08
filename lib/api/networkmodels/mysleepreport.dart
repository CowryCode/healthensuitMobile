class SleepReportDTO {
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  String? averageBedtime;
  double? sleeplatency;
  double? averagenumberofawakenings;
  double? waso;
  double? tib;
  double? tst;
  double? se;
  double? averageSleepHours;
  String? startDate;
  String? endDate;

  SleepReportDTO(
      { this.firstName,
        this.lastName,
        this.age,
        this.gender,
        this.averageBedtime,
        this.sleeplatency,
        this.averagenumberofawakenings,
        this.waso,
        this.tib,
        this.tst,
        this.se,
        this.averageSleepHours,
        this.startDate,
        this.endDate});

  SleepReportDTO.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    gender = json['gender'];
    averageBedtime = json['averageBedtime'];
    sleeplatency = json['sleeplatency'];
    averagenumberofawakenings = json['averagenumberofawakenings'];
    waso = json['waso'];
    tib = json['tib'];
    tst = json['tst'];
    se = json['se'];
    averageSleepHours = json['averageSleepHours'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['averageBedtime'] = this.averageBedtime;
    data['sleeplatency'] = this.sleeplatency;
    data['averagenumberofawakenings'] = this.averagenumberofawakenings;
    data['waso'] = this.waso;
    data['tib'] = this.tib;
    data['tst'] = this.tst;
    data['se'] = this.se;
    data['averageSleepHours'] = this.averageSleepHours;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }
}