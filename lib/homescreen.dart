import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/fullscreenview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List images = [];
  int page = 1;

  String apiKey = '563492ad6f917000010000019d87ce4ddc0f48d2a9f74398d1c996ad';
  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  fetchApi() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {'Authorization': apiKey}).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images = result['photos'];
      });
    });
  }

  loadMore() async {
    setState(() {
      page = page + 1;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80&page=$page';
    await http
        .get(Uri.parse(url), headers: {'Authorization': apiKey}).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        images.addAll(result['photos']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Wallpapers'),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 2),
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreenView(
                                  imageUrl: images[index]['src']['large2x'])));
                    },
                    child: Container(
                      color: Colors.white,
                      child: Image.network(
                        images[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
                itemCount: images.length,
              ),
            ),
          ),
          InkWell(
            onTap: loadMore,
            child: Container(
              padding: const EdgeInsets.all(5),
              height: 50,
              width: double.infinity,
              color: Colors.black,
              child: const Center(
                  child: Text(
                'Load Mode',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
          )
        ],
      ),
    );
  }
}
