import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:planner_app/data/service/cities/model/city_model.dart';

import '../../../utils/result.dart';

class CitiesService {
  final _log = Logger('CitiesService');

  Future<Result<List<CityModel>>> getCities() async {
    try {
      final fileString =
          await rootBundle.loadString("assets/database/worldcities.csv");

      final lines = fileString.split("\n");
      lines.removeAt(0);

      final List<CityModel> result = [];

      for (String line in lines) {
        line = line.replaceAll('"', '');

        final fields = line.split(",");

        final name = fields[0];
        final countryId = fields[6];
        final population = int.tryParse(fields[9]) ?? 0;

        if (population < 50000) continue;

        result.add(
          CityModel(
            name: name,
            countryId: countryId,
            population: population,
          ),
        );
      }

      _log.finer('Got cities from database');
      return Result.ok(result);
    } on Exception catch (e) {
      _log.warning('Failed to get ciies', e);
      return Result.error(e);
    }
  }
}
