import 'package:flutter/foundation.dart';

class GenreModel {
  final int id;
  final String name;

  GenreModel({
    required this.id,
    required this.name});

  factory GenreModel.fromJson(Map m) => GenreModel(
      id: m['id'],
      name: m['name']);
}