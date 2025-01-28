// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class GuestModel {
  final String name;
  final String email;
  final bool confirmed;
  final String? id;

  GuestModel({
    required this.email,
    this.confirmed = false,
    this.name = '',
    this.id,
  });

  GuestModel copyWith({
    String? name,
    String? email,
    bool? confirmed,
    String? id,
  }) {
    return GuestModel(
      name: name ?? this.name,
      confirmed: confirmed ?? this.confirmed,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  factory GuestModel.fromApi(
    QueryDocumentSnapshot query,
  ) {
    return GuestModel(
      email: query['email'],
      name: query['name'] ?? '',
      confirmed: query['confirmed'],
      id: query.id,
    );
  }

  @override
  String toString() =>
      'GuestModel(id: $id, name: $name, email: $email, confirmed: $confirmed)';
}
