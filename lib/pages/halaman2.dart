import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_test_2/models/image_model.dart';
import 'package:mobile_test_2/pages/halaman3.dart';

class Halaman2 extends StatefulWidget {
  const Halaman2({Key? key, required this.image}) : super(key: key);
  final ImageMeme image;
  @override
  State<Halaman2> createState() => _Halaman2State();
}

class _Halaman2State extends State<Halaman2> {
  TextEditingController textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Halaman 2'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Image.network(
                  widget.image.url.toString(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text('Add Logo'),
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: () async {
                                selectedImage = await _picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                setState(() {});
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: selectedImage == null
                                    ? BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(50),
                                      )
                                    : BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(
                                              selectedImage!.path.toString(),
                                            ),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Add Text'),
                            SizedBox(
                              width: 250,
                              child: TextField(
                                controller: textController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Halaman3(
                                image: widget.image,
                                text: textController.text,
                                logo: selectedImage == null
                                    ? ''
                                    : selectedImage!.path.toString(),
                              ),
                            ),
                          );
                        },
                        child: const Text('Lanjut'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
