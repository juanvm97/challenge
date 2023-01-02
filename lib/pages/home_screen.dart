import 'package:challenge/domain/entities/photo.dart';
import 'package:challenge/pages/upload_image.dart';
import 'package:challenge/providers/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.read(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wisy Mobile Challenge'),
      ),
      body: FutureBuilder(
        future: provider.getPhotos(),
        builder: ((context, snapshot) {
          if (snapshot.error != null) {
            return const Center(child: Text('Some error occurred'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return PhotoList(snapshot.data as List<Photo>);
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UploadImage()),
          ).then((value) => setState(() {}));
        }),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}

class PhotoList extends ConsumerWidget {
  final List<Photo> _photos;
  const PhotoList(this._photos, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;

    return _photos.isNotEmpty
        ? ListView.separated(
            itemCount: _photos.length,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 150,
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width / 2.5,
                      child: Text(_photos[index].name),
                    ),
                    Image.network(
                      _photos[index].url,
                      height: 150,
                      frameBuilder:
                          (context, child, frame, wasSynchronouslyLoaded) {
                        return child;
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            })
        : const Center(child: Text('No photos yet'));
  }
}
