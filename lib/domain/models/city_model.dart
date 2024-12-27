import 'package:searchfield/searchfield.dart';

class CityModel {
  final String name;
  final String countryId;

  CityModel({
    required this.name,
    required this.countryId,
  });

  SearchFieldListItem<CityModel> get toListItem => SearchFieldListItem(
        destinationFormat,
        item: this,
      );

  String get destinationFormat => '$name, $countryId';

  @override
  String toString() => '$name - $countryId';

  @override
  bool operator ==(covariant CityModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.countryId == countryId;
  }

  @override
  int get hashCode => name.hashCode ^ countryId.hashCode;
}
