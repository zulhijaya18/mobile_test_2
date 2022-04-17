import 'package:flutter/material.dart';
import 'package:mobile_test_2/api/image_api.dart';
import 'package:mobile_test_2/models/image_model.dart';

class ImagesProviderMeme extends ChangeNotifier {
  List<ImageMeme> _images = [];
  ImageMeme? _image;

  List<ImageMeme> get images => _images;
  ImageMeme? get image => _image;

  Future<void> all() async {
    _images = await ImageMemeAPI().all();
    notifyListeners();
  }
}
