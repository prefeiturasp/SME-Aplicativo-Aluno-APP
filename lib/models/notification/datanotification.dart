import 'package:sme_app_aluno/models/notification/data.dart';
import 'package:sme_app_aluno/models/notification/notification.dart';

class DataNotification {
  Notification notification;
  Data data;

  DataNotification({this.notification, this.data});

  DataNotification.fromJson(Map<String, dynamic> json) {
    notification = json['notification'] != null
        ? new Notification.fromJson(json['notification'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notification != null) {
      data['notification'] = this.notification.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}
