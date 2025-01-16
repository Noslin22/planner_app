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

  /// Create a new trip
  /// The trip will have the user as the first guest
  /// The user will be confirmed by default
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

  /// Get trip by id
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

  ///Create a new activity for the trip
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

  /// Add a new Link to the trip
  AsyncResult<TripApiModel> addLink(String tripId, LinkModel link) async {
    try {
      await _db.collection('trips').doc(tripId).collection('links').add({
        'name': link.name,
        'url': link.url,
      });

      _log.finer('Created link successfully');

      return getTripById(tripId);
    } on Exception catch (e) {
      _log.warning('Failed to create link', e);
      return Failure(e);
    }
  }

  /// Update trip local and date
  AsyncResult<TripApiModel> updateTrip(TripApiModel tripModel) async {
    try {
      String tripId = tripModel.id;
      await _db.collection('trips').doc(tripId).update({
        'destination': tripModel.destination,
        'startDate': tripModel.startDate,
        'endDate': tripModel.endDate,
      });

      _log.finer('Updated trip successfully');

      return getTripById(tripId);
    } on Exception catch (e) {
      _log.warning('Failed to update trip', e);
      return Failure(e);
    }
  }

  /// Add new guest to the trip
  /// If the guest is already in the trip, it will update the guest
  AsyncResult<TripApiModel> addGuest(String tripId, GuestModel guest) async {
    try {
      if (guest.id != null) {
        await _db
            .collection('trips')
            .doc(tripId)
            .collection('guests')
            .doc(guest.id)
            .update({
          'name': guest.name,
          'email': guest.email,
          'confirmed': guest.confirmed,
        });
      } else {
        await _db.collection('trips').doc(tripId).collection('guests').add({
          'name': guest.name,
          'email': guest.email,
          'confirmed': guest.confirmed,
        });
      }

      _log.finer('Created guest successfully');

      return getTripById(tripId);
    } on Exception catch (e) {
      _log.warning('Failed to create guest', e);
      return Failure(e);
    }
  }

  /// Delete guest from the trip
  /// If the guest is not in the trip, it will do nothing
  AsyncResult<TripApiModel> removeGuest(String tripId, String guestId) async {
    try {
      await _db
          .collection('trips')
          .doc(tripId)
          .collection('guests')
          .doc(guestId)
          .delete();

      _log.finer('Deleted guest successfully');

      return getTripById(tripId);
    } on Exception catch (e) {
      _log.warning('Failed to delete guest', e);
      return Failure(e);
    }
  }

  ///Get all guests from a trip
  AsyncResult<List<GuestModel>> getGuests(String tripId) async {
    try {
      final guestsQuery =
          await _db.collection('trips').doc(tripId).collection('guests').get();

      final guests = guestsQuery.docs //
          .map(GuestModel.fromApi)
          .toList();

      _log.finer('Fetched guests successfully');
      return Success(guests);
    } on Exception catch (e) {
      _log.warning('Failed to get guests', e);
      return Failure(e);
    }
  }

  ///Get all links from a trip
  AsyncResult<List<LinkModel>> getLinks(String tripId) async {
    try {
      final linksQuery =
          await _db.collection('trips').doc(tripId).collection('links').get();

      final links = linksQuery.docs //
          .map(LinkModel.fromApi)
          .toList();

      _log.finer('Fetched links successfully');
      return Success(links);
    } on Exception catch (e) {
      _log.warning('Failed to get links', e);
      return Failure(e);
    }
  }
}
