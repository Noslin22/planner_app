// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'package:planner_app/domain/models/activitiy_model.dart';
import 'package:planner_app/domain/models/guest_model.dart';
import 'package:planner_app/domain/models/link_model.dart';
import 'package:result_dart/result_dart.dart';

import 'models/trip_api_model.dart';

class ApiService {
  ApiService({
    required FirebaseFirestore db,
  }) : _db = db;

  final _log = Logger('ApiService');
  final FirebaseFirestore _db;

  AsyncResult<String> createTrip(TripApiModel tripModel) async {
    try {
      final trip = await _db.collection('trips').add({
        'destination': tripModel.destination,
        'startDate': tripModel.startDate,
        'endDate': tripModel.endDate,
      });

      await trip.collection('guests').add({
        'name': tripModel.name,
        'email': tripModel.email,
        'confirmed': true,
      });

      for (final guest in tripModel.guests) {
        await trip.collection('guests').add({
          'name': null,
          'email': guest.email,
          'confirmed': false,
        });
      }

      _log.finer('Created trip successfully');
      return Success(trip.id);
    } on Exception catch (e) {
      _log.warning('Failed to create trip', e);
      return Failure(e);
    }
  }

  AsyncResult<TripApiModel> getTripById(String tripId) async {
    try {
      final trip = await _db.collection('trips').doc(tripId).get();

      final guestsQuery = await trip.reference.collection('guests').get();
      final guests = guestsQuery.docs //
          .map(GuestModel.fromApi)
          .toList();

      final activitiesQuery = await trip.reference //
          .collection('activities')
          .get();

      final activities = activitiesQuery.docs //
          .map(ActivitiyModel.fromApi)
          .toList();

      final linksQuery = await trip.reference.collection('links').get();
      final links = linksQuery.docs //
          .map(LinkModel.fromApi)
          .toList();

      _log.finer('Fetched trip successfully');
      return Success(
        TripApiModel(
          destination: trip['destination'],
          startDate: trip['startDate'],
          endDate: trip['endDate'],
          name: '',
          email: '',
          guests: guests,
          activities: activities,
          links: links,
          id: trip.id,
        ),
      );
    } on Exception catch (e) {
      _log.warning('Failed to get trip', e);
      return Failure(e);
    }
  }

  AsyncResult<TripApiModel> createActivity(
    String tripId,
    ActivitiyModel activity,
  ) async {
    try {
      await _db.collection('trips').doc(tripId).collection('activities').add({
        'name': activity.name,
        'dateTime': Timestamp.fromDate(activity.dateTime),
      });

      _log.finer('Created activity successfully');

      return getTripById(tripId);
    } on Exception catch (e) {
      _log.warning('Failed to create activity', e);
      return Failure(e);
    }
  }
}
