// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  int? id;
  String? type;
  String? title;
  String? message;
  dynamic created_on;
  dynamic updated_on;
  NotificationModel({
    this.id,
    this.type,
    this.title,
    this.message,
    required this.created_on,
    required this.updated_on,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'title': title,
      'message': message,
      'created_on': created_on,
      'updated_on': updated_on,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] != null ? map['id'] as int : null,
      type: map['type'] != null ? map['type'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      created_on: map['created_on'] as dynamic,
      updated_on: map['updated_on'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class NotificationsModel {
  List<NotificationModel>? notifications;
  NotificationsModel({
    this.notifications,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notifications': notifications!.map((x) => x.toMap()).toList(),
    };
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      notifications: map['notifications'] != null
          ? List<NotificationModel>.from(
              (map['notifications'] as List<dynamic>).map<NotificationModel?>(
                (x) => NotificationModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromJson(String source) =>
      NotificationsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
