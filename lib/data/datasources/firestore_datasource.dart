import 'package:challenge/data/datasources/photo_remote_datasource.dart';
import 'package:challenge/data/models/photo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirestoreDatasource implements IRemoteDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<List<PhotoModel>> getPhotos() async {
    QuerySnapshot snapshot = await _firestore.collection('photos').get();

    return snapshot.docs.map((e) => photoFromDocumentSnapshot(e)).toList();
  }

  @override
  Future<bool> uploadPhoto(imageFile) async {
    String fileName = basename(imageFile.path);
    final imagesRef = _storage.ref().child("photos/$fileName");
    await imagesRef.putFile(imageFile);
    final downloadUrl = await imagesRef.getDownloadURL();
    final photos = _firestore.collection('photos');
    try {
      await photos.add(PhotoModel(
        url: downloadUrl,
        name: fileName,
      ).toMap());
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
