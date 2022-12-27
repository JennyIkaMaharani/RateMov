import 'dart:html';
import 'package:flutter/material.dart';
import 'movielist.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'RateMov',
      home: new MovieList(),
    );
  }

  Widget loading() {
    return LoadingAnimationWidget.waveDots(
      color: Colors.blue,
      size: 100.0,
    );
  }
}
