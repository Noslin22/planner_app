// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:planner_app/domain/models/activitiy_model.dart';
import 'package:planner_app/domain/models/guest_model.dart';

import 'city_model.dart';
import 'link_model.dart';

class TripModel {
  final CityModel destination;
  final DateTimeRange dateRange;
  final String name;
  final String email;
  final List<GuestModel> guests;
  final List<ActivitiyModel> activities;
  final List<LinkModel> links;
  final String id;

  TripModel({
    required this.destination,
    required this.dateRange,
    required this.name,
    required this.email,
    required this.guests,
    required this.activities,
    required this.links,
    this.id = '',
  });

  TripModel copyWith({
    CityModel? destination,
    DateTimeRange? dateRange,
    String? name,
    String? email,
    List<GuestModel>? guests,
    List<ActivitiyModel>? activities,
    List<LinkModel>? links,
    String? id,
  }) {
    return TripModel(
      destination: destination ?? this.destination,
      dateRange: dateRange ?? this.dateRange,
      name: name ?? this.name,
      email: email ?? this.email,
      guests: guests ?? this.guests,
      activities: activities ?? this.activities,
      links: links ?? this.links,
      id: id ?? this.id,
    );
  }
}
