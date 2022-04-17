import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';

class Halaman4 extends StatefulWidget {
  const Halaman4({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  State<Halaman4> createState() => _Halaman4State();
}

class _Halaman4State extends State<Halaman4> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Halaman 4'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(
              File(widget.image),
            ),
            ElevatedButton(
              onPressed: () {
                SocialShare.shareOptions(
                  'Mobile Test 2 Zulhijaya',
                  imagePath: widget.image,
                );
              },
              child: const Text('Share to FB'),
            ),
            ElevatedButton(
              onPressed: () async {
                SocialShare.shareOptions(
                  'Mobile Test 2 Zulhijaya',
                  imagePath: widget.image,
                );
              },
              child: const Text('Share to Twitter'),
            ),
          ],
        ),
      ),
    );
  }
}
