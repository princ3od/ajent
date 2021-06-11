import 'dart:io';
import 'package:path/path.dart';
import 'package:ajent/app/data/services/collection_interface.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService implements CollectionInterface {
  @override
  String collectionName = 'images';
  StorageService._privateConstructor();
  static final StorageService instance = StorageService._privateConstructor();
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image, String uid) async {
    String imageUrl;
    Reference rootStorageReference = storage.ref();
    Reference pictureFolderReference = rootStorageReference
        .child('images')
        .child('$uid/${basename(image.path)}');
    await pictureFolderReference.putFile(image).whenComplete(() async {
      imageUrl = await pictureFolderReference.getDownloadURL();
    });
    return imageUrl;
  }
}
