class LevelSix {
  int? id;
  String? fears;
  String? strategy;

  LevelSix({this.id, this.fears, this.strategy});

  LevelSix.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fears = json['fears'];
    strategy = json['strategy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fears'] = this.fears;
    data['strategy'] = this.strategy;
    return data;
  }

  void setfears(String value){
    this.fears = value;
  }

  void setStrategy(String value){
    this.strategy = value;
  }

}