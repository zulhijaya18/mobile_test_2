import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_test_2/models/image_model.dart';

class ImageMemeAPI {
  Future<List<ImageMeme>> all() async {
    return await http
        .get(Uri.parse('https://api.imgflip.com/get_memes'))
        .then((res) {
      final json = jsonDecode(res.body);
      List<ImageMeme> _images = [];
      for (int i = 0; i <= json['data']['memes'].length - 1; i++) {
        final image = ImageMeme(
          id: int.parse(json['data']['memes'][i]['id']),
          name: json['data']['memes'][i]['name'],
          url: json['data']['memes'][i]['url'],
          width: json['data']['memes'][i]['width'].toString(),
          height: json['data']['memes'][i]['height'].toString(),
          boxCount: int.parse(json['data']['memes'][i]['box_count'].toString()),
        );
        _images.add(image);
      }
      return _images;
    });
  }
}
