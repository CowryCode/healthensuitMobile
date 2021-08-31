class Levelfive {
  int? id;
  String? hoursofsleepeachnight;
  String? fullofenergyeachday;
  String? fallasleepfast;
  String? didnotsleepwelllastnight;
  String? cancelsocialmedia;

  Levelfive(
      {this.id,
        this.hoursofsleepeachnight,
        this.fullofenergyeachday,
        this.fallasleepfast,
        this.didnotsleepwelllastnight,
        this.cancelsocialmedia});

  Levelfive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hoursofsleepeachnight = json['hoursofsleepeachnight'];
    fullofenergyeachday = json['fullofenergyeachday'];
    fallasleepfast = json['fallasleepfast'];
    didnotsleepwelllastnight = json['didnotsleepwelllastnight'];
    cancelsocialmedia = json['cancelsocialmedia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hoursofsleepeachnight'] = this.hoursofsleepeachnight;
    data['fullofenergyeachday'] = this.fullofenergyeachday;
    data['fallasleepfast'] = this.fallasleepfast;
    data['didnotsleepwelllastnight'] = this.didnotsleepwelllastnight;
    data['cancelsocialmedia'] = this.cancelsocialmedia;
    return data;
  }
  void sethoursofsleepeachnight(String value){
    this.hoursofsleepeachnight = value;
  }
  void setfullofenergyeachday(String value){
    this.fullofenergyeachday = value;
  }
  void setfallasleepfast(String value){
    this.fallasleepfast = value;
  }
  void setdidnotsleepwelllastnight(String value){
    this.didnotsleepwelllastnight = value;
  }
  void setcancelsocialmedia(String value){
    this.cancelsocialmedia = value;
  }
}