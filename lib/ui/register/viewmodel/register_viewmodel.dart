import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:planner_app/data/repository/cities/cities_repository.dart';
import 'package:planner_app/data/service/cities/model/city_model.dart';

import '../../../utils/command.dart';
import '../../../utils/result.dart';

enum RegisterState {
  initial,
  half,
  complete,
}

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel({
    required CitiesRepository citiesRepository,
  }) : _citiesRepository = citiesRepository {
    load = Command0<void>(_load)..execute();
  }

  final CitiesRepository _citiesRepository;

  final _log = Logger('RegisterViewModel');

  CityModel? _destination;
  DateTimeRange? _dateRange;
  RegisterState _state = RegisterState.initial;
  final List<String> _guests = [];

  RegisterState get state => _state;
  set state(RegisterState state) {
    _state = state;
    _log.finest('State updated: ${state.name}');
    notifyListeners();
  }

  CityModel? get destination => _destination;
  set destination(CityModel? destination) {
    _destination = destination;
    _log.finest('Selected destination: $destination');
    notifyListeners();
  }

  DateTimeRange? get dateRange => _dateRange;
  set dateRange(DateTimeRange? dateRange) {
    _dateRange = dateRange;
    _log.finest('Selected date range: $dateRange');
    notifyListeners();
  }

  List<String> get guests => _guests;

  void addGuest(String guest) {
    _guests.add(guest);
    _log.finest('Guest added: $guest');
    notifyListeners();
  }

  void removeGuest(String guest) {
    _guests.remove(guest);
    _log.finest('Guest removed: $guest');
    notifyListeners();
  }

  List<CityModel> _cities = [];

  List<CityModel> get cities => _cities;

  late final Command0 load;

  Future<Result<void>> _load() async {
    final result = await _loadCities();
    return result;
  }

  Future<Result<void>> _loadCities() async {
    final result = await _citiesRepository.getCities();
    switch (result) {
      case Ok():
        {
          _cities = result.value;
          _log.fine('Cities (${_cities.length}) loaded');
        }
      case Error():
        {
          _log.warning('Failed to load cities', result.asError.error);
        }
    }
    notifyListeners();
    return result;
  }
}
