class SettingModel {
  late bool status;
  late SettingData data;

  SettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? SettingData.fromJson(json['data']) : null)!;
  }
}

class SettingData {
  late String about;
  late String terms;

  SettingData.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }
}
