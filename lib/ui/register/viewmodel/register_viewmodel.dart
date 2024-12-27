import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:planner_app/data/repository/cities/cities_repository.dart';
import 'package:planner_app/data/repository/trip/trip_repository.dart';
import 'package:planner_app/domain/models/guest_model.dart';
import 'package:planner_app/domain/models/trip_model.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/city_model.dart';
import '../../../utils/command.dart';

enum RegisterState {
  initial,
  half,
  complete,
}

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel({
    required CitiesRepository citiesRepository,
    required TripRepository tripRepository,
  })  : _citiesRepository = citiesRepository,
        _tripRepository = tripRepository {
    load = Command0<List<CityModel>>(_load)..execute();
    createTrip = Command2<String, String, String>(_createTrip);
  }

  final CitiesRepository _citiesRepository;
  final TripRepository _tripRepository;

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
  AsyncResult<List<CityModel>> _load() async {
    final result = await _citiesRepository.getCities();

    result.fold(_loadCities, _reportFailure);
    notifyListeners();

    return result;
  }

  void _loadCities(List<CityModel> cities) {
    _cities = cities;
    _log.fine('Cities (${_cities.length}) loaded');
  }

  void _reportFailure(Exception e) {
    _log.warning('Failed to load cities', e);
  }

  late final Command2<String, String, String> createTrip;

  AsyncResult<String> _createTrip(String name, String email) async {
    final result = await _tripRepository.createTrip(
      TripModel(
        city: destination!,
        dateRange: dateRange!,
        name: name,
        email: email,
        guests: guests.map((e) => GuestModel(email: e)).toList(),
        activities: [],
        links: [],
      ),
    );
    return result;
  }
}
