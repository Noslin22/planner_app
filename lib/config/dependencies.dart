import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planner_app/data/repository/cities/cities_repository.dart';
import 'package:planner_app/data/repository/trip/trip_repository.dart';
import 'package:planner_app/data/service/cities/cities_service.dart';
import 'package:planner_app/ui/core/localization/app_localization.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/service/api/api_service.dart';
import '../data/service/local/local_service.dart';

List<SingleChildWidget> get providers {
  return [
    Provider(
      create: (context) => ApiService(db: FirebaseFirestore.instance),
    ),
    Provider(
      create: (context) => CitiesService(),
    ),
    Provider(
      create: (context) => LocalService(),
    ),
    Provider(
      create: (context) => AppLocalization.of(context),
    ),
    Provider(
      create: (context) => TripRepository(
        apiService: context.read(),
        localService: context.read(),
      ),
    ),
    Provider(
      create: (context) => CitiesRepository(
        citiesService: context.read(),
      ),
    ),
  ];
}
