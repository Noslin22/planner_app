import 'package:planner_app/data/service/api/api_service.dart';
import 'package:planner_app/data/service/api/models/trip_api_model.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/trip_model.dart';
import '../../service/local/local_service.dart';

class TripRepository {
  TripRepository({
    required ApiService apiService,
    required LocalService localService,
  })  : _apiService = apiService,
        _localService = localService;
  final ApiService _apiService;
  final LocalService _localService;

  AsyncResult<String> createTrip(TripModel trip) async {
    final TripApiModel tripApi = TripApiModel.fromTrip(trip);
    return _apiService.createTrip(tripApi)..onSuccess(_saveTripId);
  }

  AsyncResult<TripModel> updateTrip(TripModel trip) async {
    final TripApiModel tripApi = TripApiModel.fromTrip(trip);
    final result = await _apiService.updateTrip(tripApi);
    return result.map(mapTrip);
  }

  void _saveTripId(String tripId) {
    _localService.saveTripId(tripId);
  }

  AsyncResult<TripModel> getTripById(String tripId) async {
    final result = await _apiService.getTripById(tripId);
    return result.map(mapTrip);
  }

  TripModel mapTrip(TripApiModel trip) {
    return trip.toTripModel;
  }
}
