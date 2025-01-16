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
    this.trip,
  })  : _citiesRepository = citiesRepository,
        _tripRepository = tripRepository,
        guests = trip?.guests ?? [] {
    if (trip != null) {
      _destination = trip?.destination;
      _dateRange = trip?.dateRange;
      _state = RegisterState.complete;
    }

    load = Command0<List<CityModel>>(_load)..execute();
    createTrip = Command2<String, String, String>(_createTrip);
  }

  final CitiesRepository _citiesRepository;
  final TripRepository _tripRepository;

  final _log = Logger('RegisterViewModel');

  TripModel? trip;

  RegisterState _state = RegisterState.initial;

  RegisterState get state => _state;
  set state(RegisterState state) {
    _state = state;
    _log.finest('State updated: ${state.name}');
    notifyListeners();
  }

  CityModel? _destination;
  CityModel? get destination => _destination;

  set destination(CityModel? destination) {
    _destination = destination;
    if (trip != null) {
      trip = trip!.copyWith(destination: destination);
    }
    _log.finest('Selected destination: $destination');
    notifyListeners();
  }

  DateTimeRange? _dateRange;
  DateTimeRange? get dateRange => _dateRange;

  set dateRange(DateTimeRange? dateRange) {
    _dateRange = dateRange;
    if (trip != null) {
      trip = trip!.copyWith(dateRange: dateRange);
    }
    _log.finest('Selected date range: $dateRange');
    notifyListeners();
  }

  final List<GuestModel> guests;

  void addGuest(String email) {
    guests.add(GuestModel(email: email));

    if (trip != null) {
      trip = trip!.copyWith(guests: guests);
    }
    _log.finest('Guest added: $email');
    notifyListeners();
  }

  void removeGuest(String email) {
    guests.remove(GuestModel(email: email));

    if (trip != null) {
      trip = trip!.copyWith(guests: guests);
    }
    _log.finest('Guest removed: $email');
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
      trip ??
          TripModel(
            destination: destination!,
            dateRange: dateRange!,
            name: name,
            email: email,
            guests: guests,
            activities: [],
            links: [],
          ),
    );
    return result;
  }
}
