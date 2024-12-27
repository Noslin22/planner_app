import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planner_app/data/service/api/api_service.dart';
import 'package:planner_app/data/service/api/models/trip_api_model.dart';
import 'package:planner_app/domain/models/guest_model.dart';
import 'package:result_dart/result_dart.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Should get trip by id', () async {
    final service = ApiService(db: FakeFirebaseFirestore());
    final id = await service
        .createTrip(
          TripApiModel(
            destination: 'Nova Soure, BRA',
            startDate: Timestamp.fromDate(DateTime(2024, 12, 23)),
            endDate: Timestamp.fromDate(DateTime(2024, 12, 28)),
            name: 'João Nilson',
            email: 'joao@gmail.com',
            guests: [
              GuestModel(email: 'denisson.silva@adventistas.org'),
            ],
            activities: [],
            links: [],
            id: '',
          ),
        )
        .then<String>(
          (value) => value.getOrDefault(''),
        );

    final result = await service.getTripById(id);
    debugPrint(result.toString());

    expect(result.runtimeType, Success<TripApiModel, Exception>);
  });
}
