// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:searchfield/searchfield.dart';

class CityModel {
  final String name;
  final String countryId;
  final int population;

  CityModel({
    required this.name,
    required this.countryId,
    required this.population,
  });

  SearchFieldListItem<CityModel> get toListItem => SearchFieldListItem(
        destinationFormat,
        item: this,
      );

  String get destinationFormat => '$name, $countryId';

  @override
  String toString() => '$name - $countryId - $population people';

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.countryId == countryId &&
        other.population == population;
  }

  @override
  int get hashCode => name.hashCode ^ countryId.hashCode ^ population.hashCode;
}
