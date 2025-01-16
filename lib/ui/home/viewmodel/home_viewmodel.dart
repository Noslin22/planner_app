import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:result_dart/result_dart.dart';

import '../../../data/repository/trip/trip_repository.dart';
import '../../../domain/models/trip_model.dart';
import '../../../utils/command.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required String tripId,
    required TripRepository tripRepository,
  })  : _tripId = tripId,
        _tripRepository = tripRepository {
    load = Command0<TripModel>(_load)..execute();
  }

  final TripRepository _tripRepository;

  final _log = Logger('HomeViewModel');

  final String _tripId;

  late final Command0<TripModel> load;

  AsyncResult<TripModel> _load() async {
    final result = await _tripRepository.getTripById(_tripId);
    result.fold(_loadSuccess, _loadFailure);

    notifyListeners();
    return result;
  }

  void _loadSuccess(TripModel trip) {
    _trip = trip;
    _log.fine('Trip to ${trip.destination.name} loaded');
  }

  void _loadFailure(Exception e) {
    _log.warning('Failed to load cities', e);
  }

  TripModel? _trip;
  TripModel? get trip => _trip;
  set trip(TripModel? trip) {
    _trip = trip;
    _log.finest('Showing trip changed');
    notifyListeners();
  }

  bool _isActivities = true;
  bool get isActivities => _isActivities;
  set isActivities(bool screen) {
    _isActivities = screen;
    _log.finest('Is activities screen: $screen');
    notifyListeners();
  }
}
