import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  final Logger _logger = Logger('LocalService');
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  final ValueNotifier<String?> tripId = ValueNotifier<String?>(null);

  Future<void> saveTripId(String id) async {
    tripId.value = id;
    await _prefs.setString('tripId', id);
    _logger.info('Trip ID saved: $id');
  }

  Future<String?> getTripId() async {
    final id = await _prefs.getString('tripId');
    tripId.value = id;
    _logger.info('Trip ID retrieved: $id');
    return id;
  }
}
