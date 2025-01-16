import 'package:planner_app/domain/models/link_model.dart';
import 'package:planner_app/domain/models/trip_model.dart';
import 'package:result_dart/result_dart.dart';

import '../../service/api/api_service.dart';
import '../../service/api/models/trip_api_model.dart';

class LinksRepository {
  final ApiService _apiService;

  LinksRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  AsyncResult<TripModel> addLink(
    String tripId,
    LinkModel link,
  ) async {
    final result = await _apiService.addLink(tripId, link);
    return result.map(mapTrip);
  }

  ///Get all links from a trip
  AsyncResult<List<LinkModel>> getLinks(String tripId) async {
    final result = await _apiService.getLinks(tripId);
    return result;
  }

  // ///Remove a guest from a trip
  // AsyncResult<TripModel> removeGuest(
  //   String tripId,
  //   String guestId,
  // ) async {
  //   final result = await _apiService.removeGuest(tripId, guestId);
  //   return result.map(mapTrip);
  // }

  TripModel mapTrip(TripApiModel trip) {
    return trip.toTripModel;
  }
}
