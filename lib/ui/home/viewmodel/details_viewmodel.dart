import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:planner_app/data/repository/guests/guests_repository.dart';
import 'package:planner_app/data/repository/links/links_repository.dart';
import 'package:planner_app/domain/models/guest_model.dart';
import 'package:planner_app/domain/models/link_model.dart';
import 'package:planner_app/domain/models/trip_model.dart';
import 'package:result_dart/result_dart.dart';

import '../../../utils/command.dart';

class DetailsViewModel extends ChangeNotifier {
  DetailsViewModel({
    required GuestsRepository guestsRepository,
    required LinksRepository linksRepository,
    required TripModel trip,
  })  : _guestsRepository = guestsRepository,
        _linksRepository = linksRepository,
        _trip = trip {
    addGuest = Command0<TripModel>(_addGuest);
    removeGuest = Command1<TripModel, String>(_removeGuest);
    addLink = Command2<TripModel, String, String>(_addLink);
  }

  final Logger _log = Logger('DetailsViewModel');

  final GuestsRepository _guestsRepository;
  final LinksRepository _linksRepository;

  TripModel _trip;

  String get _tripId => _trip.id;
  TripModel get trip => _trip;

  set trip(TripModel trip) {
    _trip = trip;
    _log.fine('Updated Trip');
    notifyListeners();
  }

  String? _newGuest;
  String? get newGuest => _newGuest;
  set newGuest(String? newGuest) {
    _newGuest = newGuest;
    _log.fine('Updated New Guest Email');
    notifyListeners();
  }

  String? _linkName;
  String? get linkName => _linkName;
  set linkName(String? linkName) {
    _linkName = linkName;
    _log.fine('Updated Link Name');
    notifyListeners();
  }

  String? _linkUrl;
  String? get linkUrl => _linkUrl;
  set linkUrl(String? linkUrl) {
    _linkUrl = linkUrl;
    _log.fine('Updated Link Url');
    notifyListeners();
  }

  bool get canAddLink =>
      linkName != null && //
      linkUrl != null;

  late final Command0<TripModel> addGuest;

  AsyncResult<TripModel> _addGuest() async {
    final result = await _guestsRepository.addGuest(
      _tripId,
      GuestModel(email: newGuest!),
    );

    trip = result.getOrDefault(_trip);

    return result;
  }

  late final Command1<TripModel, String> removeGuest;

  AsyncResult<TripModel> _removeGuest(String guestId) async {
    final result = await _guestsRepository.removeGuest(
      _tripId,
      guestId,
    );

    trip = result.getOrDefault(_trip);

    return result;
  }

  late final Command2<TripModel, String, String> addLink;

  AsyncResult<TripModel> _addLink(String name, String url) async {
    final result = await _linksRepository.addLink(
      _tripId,
      LinkModel(
        name: name,
        url: url,
      ),
    );

    trip = result.getOrDefault(_trip);

    return result;
  }
}
