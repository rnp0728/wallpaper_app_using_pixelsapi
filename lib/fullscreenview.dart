import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';


class FullScreenView extends StatefulWidget {
  final String imageUrl;
  const FullScreenView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  Future<void> setWallpaper(String screen) async{
    late int location;
    if(screen == 'Home Screen'){
      location = WallpaperManagerFlutter.HOME_SCREEN;
    }else if(screen == 'Lock Screen'){
      location = WallpaperManagerFlutter.LOCK_SCREEN;
    }else if(screen == 'Both Screens'){
      location = WallpaperManagerFlutter.BOTH_SCREENS;
    }
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    await WallpaperManagerFlutter().setwallpaperfromFile(file, location);
  }
  Widget _setupButtons(String title){
    return InkWell(
      onTap: (){
        setWallpaper(title);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            )),
      ),
    );
  }
  Widget _buildPopupScreen(){
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: const EdgeInsets.all(5),
      backgroundColor: Colors.white70,
      title: const Center(child: Text('Wallpaper for ', style: TextStyle(color: Colors.black),),),
      content: Container(
        height: 170,
        width: double.infinity,
        child: Column(
            children: [
              const Divider(color: Colors.black),
              _setupButtons('Home Screen'),
              // const Divider(color: Colors.white),
              _setupButtons('Lock Screen'),
              // const Divider(color: Colors.white),
              _setupButtons('Both Screens')
            ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black),
          ),
          child: const Text('Close',style: TextStyle(fontSize: 15),),
        ),
      ],
    );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
              child: Image.network(widget.imageUrl, fit: BoxFit.cover,),
            ),),
            InkWell(
              onTap: (){
                showDialog(context: context, builder: (context) => _buildPopupScreen());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.black,
                child: const Center(
                    child: Text(
                      'Set Wallpaper',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
