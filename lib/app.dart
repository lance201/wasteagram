import 'package:flutter/material.dart';
import 'screens/post_list.dart';
import 'screens/camera_screen.dart';
import 'screens/detail_screen.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostList(),
    );
  }
}

