import 'dart:io';

import 'package:challenge/providers/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends ConsumerStatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  UploadImageState createState() => UploadImageState();
}

class UploadImageState extends ConsumerState<UploadImage> {
  late File _imageFile;
  final picker = ImagePicker();
  late bool _load = false;

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        _load = true;
      } else {
        _load = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void showsnackbar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add photo'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.upload),
            tooltip: 'Show Snackbar',
            onPressed: () async {
              if (_load) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Uploading photo')));
                await provider.uploadPhoto(_imageFile);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Take a photo')));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          margin: const EdgeInsets.only(
            left: 30.0,
            right: 30.0,
          ),
          child: _load
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.file(_imageFile),
                )
              : const Center(child: Text('Take a photo')),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
