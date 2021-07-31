
class MysleepClock {
  String? averagebedtiime;
  String? averagerisetime;
  int? averagetimeinbed;
  int? averagetotalsleeptime;
  double? averagesleepefficiency;
  double? averagenumberofsleephours;
  int? averagenumberofbedhours;
  String? message;

  MysleepClock({this.averagebedtiime,
    this.averagerisetime,
    this.averagetimeinbed,
    this.averagetotalsleeptime,
    this.averagesleepefficiency,
    this.averagenumberofsleephours,
    this.averagenumberofbedhours,
    this.message});

  MysleepClock.fromJson(Map<String, dynamic> json) {
    averagebedtiime = json['averagebedtiime'];
    averagerisetime = json['averagerisetime'];
    averagetimeinbed = json['averagetimeinbed'];
    averagetotalsleeptime = json['averagetotalsleeptime'];
    averagesleepefficiency = json['averagesleepefficiency'];
    averagenumberofsleephours = json['averagenumberofsleephours'];
    averagenumberofbedhours = json['averagenumberofbedhours'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['averagebedtiime'] = this.averagebedtiime;
    data['averagerisetime'] = this.averagerisetime;
    data['averagetimeinbed'] = this.averagetimeinbed;
    data['averagetotalsleeptime'] = this.averagetotalsleeptime;
    data['averagesleepefficiency'] = this.averagesleepefficiency;
    data['averagenumberofsleephours'] = this.averagenumberofsleephours;
    data['averagenumberofbedhours'] = this.averagenumberofbedhours;
    data['message'] = this.message;
    return data;
  }
}