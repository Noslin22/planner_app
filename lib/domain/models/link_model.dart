import 'package:cloud_firestore/cloud_firestore.dart';

class LinkModel {
  final String name;
  final String url;

  LinkModel({
    required this.name,
    required this.url,
  });

  factory LinkModel.fromApi(QueryDocumentSnapshot query) {
    return LinkModel(
      name: query['name'],
      url: query['url'],
    );
  }

  @override
  String toString() => 'LinkModel(name: $name, url: $url)';
}
