import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_test_2/models/image_model.dart';
import 'package:mobile_test_2/pages/halaman4.dart';
import 'package:path_provider/path_provider.dart';

class Halaman3 extends StatefulWidget {
  const Halaman3(
      {Key? key, required this.image, required this.text, required this.logo})
      : super(key: key);
  final ImageMeme image;
  final String text;
  final String logo;

  @override
  State<Halaman3> createState() => _Halaman3State();
}

class _Halaman3State extends State<Halaman3> {
  GlobalKey globalKey = GlobalKey();
  String? imagePath;

  Future<Uint8List?> capturePng() async {
    try {
      RenderRepaintBoundary? boundary = globalKey.currentContext
          ?.findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      String filename =
          '${Random().nextInt(100000).toString()}_zulhijaya_mobile_test_2.png';
      const folderName = "mobile_test_2";
      final newFolder = Directory("/storage/emulated/0/Pictures/$folderName");
      imagePath = '${newFolder.path}/$filename';
      if ((!await newFolder.exists())) {
        newFolder.create();
      }
      String bs64e = base64Encode(pngBytes);
      final bs64d = base64Decode(bs64e);
      var fl = await _localPath.then(
          (value) => File('${newFolder.path.toString()}/$filename').create());
      await fl.writeAsBytes(bs64d);
      print(fl.path);
      return pngBytes;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  alertShow() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Info'),
          content: const Text('Gambar disimpan di folder Pictures'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Oke'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future simpan() async {
    await capturePng();
    alertShow();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Halaman 3'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 7,
              child: RepaintBoundary(
                key: globalKey,
                child: Stack(
                  children: [
                    Image.network(
                      widget.image.url.toString(),
                    ),
                    Row(
                      children: [
                        widget.logo == ''
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(widget.logo.toString()),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            widget.text,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => simpan(),
                    child: const Text('Simpan'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await capturePng();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Halaman4(
                            image: imagePath!,
                          ),
                        ),
                      );
                    },
                    child: const Text('Share'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
