class SleepReportDTO {
  int? id;
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
  Null? dateShared;
  List<AllbedTime> allbedTime = [];
  List<DateValueObject> allAwakenings = [];
  List<DateValueObject> allTimeinBed = [];
  List<DateValueObject> allSleepHours = [];

  SleepReportDTO(
      {this.id,
        this.firstName,
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
        this.endDate,
        this.dateShared,
        required this.allbedTime,
        required this.allAwakenings,
        required this.allTimeinBed,
        required this.allSleepHours});

  SleepReportDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    dateShared = json['dateShared'];
    if (json['allbedTime'] != null) {
      allbedTime = <AllbedTime>[];
      json['allbedTime'].forEach((v) {
        allbedTime.add(new AllbedTime.fromJson(v));
      });
    }
    if (json['allAwakenings'] != null) {
      allAwakenings = <DateValueObject>[];
      json['allAwakenings'].forEach((v) {
        allAwakenings.add(new DateValueObject.fromJson(v));
      });
    }
    if (json['allTimeinBed'] != null) {
      allTimeinBed = <DateValueObject>[];
      json['allTimeinBed'].forEach((v) {
        allTimeinBed.add(new DateValueObject.fromJson(v));
      });
    }
    if (json['allSleepHours'] != null) {
      allSleepHours = <DateValueObject>[];
      json['allSleepHours'].forEach((v) {
        allSleepHours.add(new DateValueObject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['dateShared'] = this.dateShared;
    // if (this.allbedTime != null) {
    //   data['allbedTime'] = this.allbedTime.map((v) => v.toJson()).toList();
    // }
    data['allbedTime'] = this.allbedTime.map((v) => v.toJson()).toList();
    // if (this.allAwakenings != null) {
    //   data['allAwakenings'] =  this.allAwakenings.map((v) => v.toJson()).toList();
    // }
    data['allAwakenings'] =  this.allAwakenings.map((v) => v.toJson()).toList();
    // if (this.allTimeinBed != null) {
    //   data['allTimeinBed'] = this.allTimeinBed.map((v) => v.toJson()).toList();
    // }
    data['allTimeinBed'] = this.allTimeinBed.map((v) => v.toJson()).toList();
    // if (this.allSleepHours != null) {
    //   data['allSleepHours'] = this.allSleepHours.map((v) => v.toJson()).toList();
    // }
    data['allSleepHours'] = this.allSleepHours.map((v) => v.toJson()).toList();
    return data;
  }
}

class AllbedTime {
  String? date;
  String? time;

  AllbedTime({this.date, this.time});

  AllbedTime.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}

class DateValueObject {
   String date = "2021-01-02";
   double value = 0.0;

  DateValueObject({required this.date, required this.value});

  DateValueObject.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['value'] = this.value;
    return data;
  }
}

// class SleepReportDTO {
//   String? firstName;
//   String? lastName;
//   int? age;
//   String? gender;
//   String? averageBedtime;
//   double? sleeplatency;
//   double? averagenumberofawakenings;
//   double? waso;
//   double? tib;
//   double? tst;
//   double? se;
//   double? averageSleepHours;
//   String? startDate;
//   String? endDate;
//
//   SleepReportDTO(
//       { this.firstName,
//         this.lastName,
//         this.age,
//         this.gender,
//         this.averageBedtime,
//         this.sleeplatency,
//         this.averagenumberofawakenings,
//         this.waso,
//         this.tib,
//         this.tst,
//         this.se,
//         this.averageSleepHours,
//         this.startDate,
//         this.endDate});
//
//   SleepReportDTO.fromJson(Map<String, dynamic> json) {
//     firstName = json['firstName'];
//     lastName = json['lastName'];
//     age = json['age'];
//     gender = json['gender'];
//     averageBedtime = json['averageBedtime'];
//     sleeplatency = json['sleeplatency'];
//     averagenumberofawakenings = json['averagenumberofawakenings'];
//     waso = json['waso'];
//     tib = json['tib'];
//     tst = json['tst'];
//     se = json['se'];
//     averageSleepHours = json['averageSleepHours'];
//     startDate = json['startDate'];
//     endDate = json['endDate'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['age'] = this.age;
//     data['gender'] = this.gender;
//     data['averageBedtime'] = this.averageBedtime;
//     data['sleeplatency'] = this.sleeplatency;
//     data['averagenumberofawakenings'] = this.averagenumberofawakenings;
//     data['waso'] = this.waso;
//     data['tib'] = this.tib;
//     data['tst'] = this.tst;
//     data['se'] = this.se;
//     data['averageSleepHours'] = this.averageSleepHours;
//     data['startDate'] = this.startDate;
//     data['endDate'] = this.endDate;
//     return data;
//   }
// }