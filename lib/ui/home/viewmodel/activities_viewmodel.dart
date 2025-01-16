import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:planner_app/data/repository/activities/activities_repository.dart';
import 'package:planner_app/domain/models/trip_model.dart';
import 'package:planner_app/utils/command.dart';
import 'package:result_dart/result_dart.dart';

import '../../../domain/models/activitiy_model.dart';

class ActivitiesViewModel extends ChangeNotifier {
  ActivitiesViewModel({
    required ActivitiesRepository activitiesRepository,
    required TripModel trip,
  })  : _activitiesRepository = activitiesRepository,
        _trip = trip {
    createActivity = Command1<TripModel, ActivitiyModel>(_createActivity);
  }

  final _log = Logger('ActivitiesViewModel');
  final ActivitiesRepository _activitiesRepository;

  bool get canCreateActivity =>
      activityName != null && //
      activityDate != null &&
      activityTime != null;

  TripModel _trip;
  TripModel get trip => _trip;
  set trip(TripModel trip) {
    _trip = trip;
    _log.fine('Updated Trip');
    notifyListeners();
  }

  String? _activityName;
  String? get activityName => _activityName;
  set activityName(String? activityName) {
    _activityName = activityName;
    notifyListeners();
  }

  DateTime? _activityDate;
  DateTime? get activityDate => _activityDate;
  set activityDate(DateTime? activityDate) {
    _activityDate = activityDate;
    _log.fine('Activity Date Updated');
    notifyListeners();
  }

  TimeOfDay? _activityTime;
  TimeOfDay? get activityTime => _activityTime;
  set activityTime(TimeOfDay? activityTime) {
    _activityTime = activityTime;
    _log.fine('Activity Time Updated');
    notifyListeners();
  }

  late final Command1<TripModel, ActivitiyModel> createActivity;

  AsyncResult<TripModel> _createActivity(ActivitiyModel activity) async {
    final result =
        await _activitiesRepository.createActivity(trip.id, activity);
    result.fold(_activitySuccess, _activityFailure);

    notifyListeners();
    return result;
  }

  void _activitySuccess(TripModel newTrip) {
    trip = newTrip;
    _log.fine('Activity Created');
  }

  void _activityFailure(Exception e) {
    _log.warning('Failed to create activity', e);
  }
}
