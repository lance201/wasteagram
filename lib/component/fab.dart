import 'package:flutter/material.dart';
import '../screens/camera_screen.dart';

class NewEntryButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraScreen()
            )
          );
        }
    );
  }
}