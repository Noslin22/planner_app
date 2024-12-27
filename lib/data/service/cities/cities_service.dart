import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/city_model.dart';

class CitiesService {
  final _log = Logger('CitiesService');

  AsyncResult<List<CityModel>> getCities() async {
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
          ),
        );
      }

      _log.finer('Got cities from database');
      return Success(result);
    } on Exception catch (e) {
      _log.warning('Failed to get ciies', e);
      return Failure(e);
    }
  }
}
