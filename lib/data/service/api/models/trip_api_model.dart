import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:planner_app/domain/models/activitiy_model.dart';
import 'package:planner_app/domain/models/city_model.dart';
import 'package:planner_app/domain/models/guest_model.dart';
import 'package:planner_app/domain/models/trip_model.dart';

import '../../../../domain/models/link_model.dart';

class TripApiModel {
  final String destination;
  final Timestamp startDate;
  final Timestamp endDate;
  final String name;
  final String email;
  final String id;
  final List<GuestModel> guests;
  final List<ActivitiyModel> activities;
  final List<LinkModel> links;

  TripApiModel({
    required this.destination,
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.email,
    required this.guests,
    required this.activities,
    required this.links,
    required this.id,
  });

  factory TripApiModel.fromTrip(TripModel trip) {
    return TripApiModel(
      destination: trip.destination.destinationFormat,
      startDate: Timestamp.fromDate(trip.dateRange.start),
      endDate: Timestamp.fromDate(trip.dateRange.end),
      name: trip.name,
      email: trip.email,
      guests: trip.guests,
      activities: trip.activities,
      links: trip.links,
      id: trip.id,
    );
  }

  TripModel get toTripModel {
    final destinationList = destination.split(', ');

    return TripModel(
      destination: CityModel(
        name: destinationList[0],
        countryId: destinationList[1],
      ),
      dateRange: DateTimeRange(
        start: startDate.toDate().copyWith(millisecond: 0),
        end: endDate.toDate().copyWith(millisecond: 0),
      ),
      name: name,
      email: email,
      guests: guests,
      activities: activities,
      links: links,
      id: id,
    );
  }

  @override
  String toString() {
    return 'TripApiModel(id: $id, destination: $destination, startDate: $startDate, endDate: $endDate, name: $name, email: $email, guests: $guests, activities: $activities, links: $links)';
  }
}
