import 'package:cloud_firestore/cloud_firestore.dart';

class ActivitiyModel {
  final String name;
  final DateTime dateTime;

  ActivitiyModel({
    required this.name,
    required this.dateTime,
  });

  factory ActivitiyModel.fromApi(
    QueryDocumentSnapshot query,
  ) {
    return ActivitiyModel(
      name: query['name'],
      dateTime: (query['dateTime'] as Timestamp).toDate(),
    );
  }

  @override
  String toString() => 'ActivitiyModel(name: $name, dateTime: $dateTime)';
}
