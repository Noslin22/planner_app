import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  final Logger _logger = Logger('LocalService');
  static SharedPreferences? _prefs;

  LocalService() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> saveTripId(String tripId) async {
    await _initPrefs();
    await _prefs?.setString('tripId', tripId);
    _logger.info('Trip ID saved: $tripId');
  }

  Future<String?> getTripId() async {
    await _initPrefs();
    final tripId = _prefs?.getString('tripId');
    _logger.info('Trip ID retrieved: $tripId');
    return tripId;
  }
}
