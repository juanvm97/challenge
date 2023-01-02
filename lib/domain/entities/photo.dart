import 'package:equatable/equatable.dart';

abstract class Photo extends Equatable {
  const Photo({
    required this.id,
    required this.url,
    required this.name,
  });

  final String? id;
  final String url;
  final String name;
}
