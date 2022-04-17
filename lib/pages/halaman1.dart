import 'package:flutter/material.dart';
import 'package:mobile_test_2/pages/halaman2.dart';
import 'package:mobile_test_2/provider/image_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Halaman1 extends StatefulWidget {
  const Halaman1({Key? key}) : super(key: key);

  @override
  State<Halaman1> createState() => _Halaman1State();
}

class _Halaman1State extends State<Halaman1> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  loadImages() async {
    final mm = Provider.of<ImagesProviderMeme>(context, listen: false);
    await mm.all();
  }

  onRefresh() async {
    await loadImages();
    refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Halaman 1'),
      ),
      body: Consumer<ImagesProviderMeme>(
        builder: (context, value, child) {
          return SmartRefresher(
            onRefresh: onRefresh,
            controller: refreshController,
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                for (final image in value.images)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Halaman2(image: image),
                        ),
                      );
                    },
                    child: Image.network(
                      image.url.toString(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
