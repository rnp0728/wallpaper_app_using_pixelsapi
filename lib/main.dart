import 'package:flutter/material.dart';
import 'package:wallpaper_app/homescreen.dart';
// @dart 2.9

void main() => runApp(const WallpaperApp());

class WallpaperApp extends StatelessWidget {
  const WallpaperApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: const HomeScreen(),
    );
  }
}

