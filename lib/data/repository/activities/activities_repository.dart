import 'package:planner_app/domain/models/activitiy_model.dart';
import 'package:planner_app/domain/models/trip_model.dart';
import 'package:result_dart/result_dart.dart';

import '../../service/api/api_service.dart';
import '../../service/api/models/trip_api_model.dart';

class ActivitiesRepository {
  final ApiService _apiService;

  ActivitiesRepository({
    required ApiService apiService,
  }) : _apiService = apiService;

  AsyncResult<TripModel> createActivity(
    String tripId,
    ActivitiyModel activity,
  ) async {
    final result = await _apiService.createActivity(tripId, activity);
    return result.map(mapTrip);
  }

  TripModel mapTrip(TripApiModel trip) {
    return trip.toTripModel;
  }
}
