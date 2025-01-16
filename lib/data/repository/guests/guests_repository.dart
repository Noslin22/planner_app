import 'package:planner_app/domain/models/guest_model.dart';
import 'package:planner_app/domain/models/trip_model.dart';
import 'package:result_dart/result_dart.dart';

import '../../service/api/api_service.dart';
import '../../service/api/models/trip_api_model.dart';

class GuestsRepository {
  final ApiService _apiService;

  GuestsRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  AsyncResult<TripModel> addGuest(
    String tripId,
    GuestModel guest,
  ) async {
    final result = await _apiService.addGuest(tripId, guest);
    return result.map(mapTrip);
  }

  ///Remove a guest from a trip
  AsyncResult<TripModel> removeGuest(
    String tripId,
    String guestId,
  ) async {
    final result = await _apiService.removeGuest(tripId, guestId);
    return result.map(mapTrip);
  }

  TripModel mapTrip(TripApiModel trip) {
    return trip.toTripModel;
  }

  ///Get all guests from a trip
  AsyncResult<List<GuestModel>> getGuests(String tripId) async {
    final result = await _apiService.getGuests(tripId);
    return result;
  }
}
