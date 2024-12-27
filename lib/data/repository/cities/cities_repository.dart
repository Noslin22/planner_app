import 'package:planner_app/data/service/cities/cities_service.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/city_model.dart';

class CitiesRepository {
  CitiesRepository({
    required CitiesService citiesService,
  }) : _citiesService = citiesService;
  final CitiesService _citiesService;

  List<CityModel>? _cachedData;

  AsyncResult<List<CityModel>> getCities() async {
    if (_cachedData == null) {
      // No cached data, request continents
      final result = await _citiesService.getCities();
      if (result is Success) {
        // Store value if result Ok
        _cachedData = result.getOrNull();
      }
      return result;
    } else {
      // Return cached data if available
      return Success(_cachedData!);
    }
  }
}
