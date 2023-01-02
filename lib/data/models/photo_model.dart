import 'package:challenge/domain/entities/photo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

PhotoModel photoFromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc) =>
    PhotoModel.fromDocumentSnapshot(doc);

class PhotoModel implements Photo {
  const PhotoModel({
    this.id = '',
    required this.url,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory PhotoModel.fromDocumentSnapshot(QueryDocumentSnapshot<Object?> doc) {
    final map = doc.data() as Map<String, dynamic>;
    return PhotoModel(
      id: doc.id,
      url: map["url"],
      name: map["name"],
    );
  }

  @override
  List<Object?> get props => [url, name];

  @override
  bool? get stringify => throw UnimplementedError();

  @override
  final String id;

  @override
  final String url;

  @override
  final String name;
}
