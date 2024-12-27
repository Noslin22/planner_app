import 'package:flutter_test/flutter_test.dart';
import 'package:planner_app/data/service/cities/cities_service.dart';
import 'package:planner_app/domain/models/city_model.dart';
import 'package:result_dart/result_dart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Should get cities', () async {
    final service = CitiesService();

    final result = await service.getCities();

    expect(result.runtimeType, Success<List<CityModel>, Exception>);
  });
}
