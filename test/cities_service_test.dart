import 'package:flutter_test/flutter_test.dart';
import 'package:planner_app/data/service/cities/cities_service.dart';
import 'package:planner_app/data/service/cities/model/city_model.dart';
import 'package:planner_app/utils/result.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Should get cities', () async {
    final service = CitiesService();

    final result = await service.getCities();

    expect(result.runtimeType, Ok<List<CityModel>>);
  });
}
