import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_test_2/pages/halaman1.dart';
import 'package:mobile_test_2/provider/image_provider.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..maxConnectionsPerHost = 5;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ImagesProviderMeme>(
          create: (_) => ImagesProviderMeme(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mobile Test 2',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Halaman1(),
      ),
    );
  }
}
