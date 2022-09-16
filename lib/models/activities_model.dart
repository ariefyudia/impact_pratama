class ActivitiesModel {
  List<Activities>? activities;

  ActivitiesModel({this.activities});

  ActivitiesModel.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  int? id;
  String? activityType;
  String? institution;
  String? when;
  String? objective;
  String? remarks;

  Activities(
      {this.id,
      this.activityType,
      this.institution,
      this.when,
      this.objective,
      this.remarks});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityType = json['activityType'];
    institution = json['institution'];
    when = json['when'];
    objective = json['objective'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activityType'] = this.activityType;
    data['institution'] = this.institution;
    data['when'] = this.when;
    data['objective'] = this.objective;
    data['remarks'] = this.remarks;
    return data;
  }
}
