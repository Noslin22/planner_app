import 'package:planner_app/data/service/cities/cities_service.dart';
import 'package:planner_app/data/service/cities/model/city_model.dart';

import '../../../utils/result.dart';

class CitiesRepository {
  CitiesRepository({
    required CitiesService citiesService,
  }) : _citiesService = citiesService;
  final CitiesService _citiesService;

  List<CityModel>? _cachedData;

  Future<Result<List<CityModel>>> getCities() async {
    if (_cachedData == null) {
      // No cached data, request continents
      final result = await _citiesService.getCities();
      if (result is Ok) {
        // Store value if result Ok
        _cachedData = result.asOk.value;
      }
      return result;
    } else {
      // Return cached data if available
      return Result.ok(_cachedData!);
    }
  }
}
