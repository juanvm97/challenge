import 'dart:io';

import 'package:challenge/data/datasources/firestore_datasource.dart';
import 'package:challenge/data/datasources/photo_remote_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeProvider {
  IRemoteDataSource remoteDataSource = FirestoreDatasource();

  Future getPhotos() async {
    return remoteDataSource.getPhotos();
  }

  Future uploadPhoto(File imageFile) async {
    return await remoteDataSource.uploadPhoto(imageFile);
  }
}

final homeProvider = Provider((ref) => HomeProvider());
