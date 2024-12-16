import 'package:planner_app/data/repository/cities/cities_repository.dart';
import 'package:planner_app/data/service/cities/cities_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/service/api/api_service.dart';

List<SingleChildWidget> get providers {
  return [
    Provider(
      create: (context) => ApiService(),
    ),
    Provider(
      create: (context) => CitiesService(),
    ),
    Provider(
      create: (context) => CitiesRepository(
        citiesService: context.read(),
      ),
    ),
  ];
}
