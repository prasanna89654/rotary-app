class Dg {
  String? name;
  String? position;
  String? dgMessage;
  String? messageMonth;

  Dg({this.name, this.position, this.dgMessage, this.messageMonth});

  Dg.fromJson(Map<String, dynamic> json) {
    name = json['name'] == null ? null : json['name'];
    position = json['position'] == null ? null : json['position'];
    dgMessage = json['dg_message'] == null ? null : json['dg_message'];
    messageMonth = json['message_month'] == null ? null : json['message_month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['position'] = this.position;
    data['dg_message'] = this.dgMessage;
    data['message_month'] = this.messageMonth;
    return data;
  }
}
