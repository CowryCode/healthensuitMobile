class LeveltwoVariables {
  String? averagebedtiime;
  String? averagerisetime;
  double? averagetimeinbed;
  double? averagetotalsleeptime;
  double? averagesleepefficiency;
  double? averagenumberofsleephours;
  double? averagenumberofbedhours;
  String? message;
  String? newBedtime;
  String? newRisetime;

  LeveltwoVariables(
      {this.averagebedtiime,
        this.averagerisetime,
        this.averagetimeinbed,
        this.averagetotalsleeptime,
        this.averagesleepefficiency,
        this.averagenumberofsleephours,
        this.averagenumberofbedhours,
        this.message,
        this.newBedtime,
        this.newRisetime
      });

  LeveltwoVariables.fromJson(Map<String, dynamic> json) {
    averagebedtiime = json['averagebedtiime'];
    averagerisetime = json['averagerisetime'];
    averagetimeinbed = json['averagetimeinbed'];
    averagetotalsleeptime = json['averagetotalsleeptime'];
    averagesleepefficiency = json['averagesleepefficiency'];
    averagenumberofsleephours = json['averagenumberofsleephours'];
    averagenumberofbedhours = json['averagenumberofbedhours'];
    message = json['message'];
    message = json['newBedtime'];
    message = json['newRisetime'];
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
    data['newBedtime'] = this.newBedtime;
    data['newRisetime'] = this.newRisetime;
    return data;
  }

  void setNewbedTime(String bedtime){
    this.newBedtime = bedtime;
  }

  void setNewriseTime(String risetime){
    this.newRisetime = risetime;
  }
}