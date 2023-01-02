import 'package:challenge/data/models/photo_model.dart';

abstract class IRemoteDataSource {
  Future<List<PhotoModel>> getPhotos();

  Future<bool> uploadPhoto(imageFile);
}
