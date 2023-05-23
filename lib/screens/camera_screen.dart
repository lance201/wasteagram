import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../model/post.dart';
import 'post_list.dart';
import 'package:location/location.dart';

class CameraScreen extends StatefulWidget {

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final post = Post();
  LocationData? locationData;
  var locationService = Location();
  File? image;
  final picker = ImagePicker();
  String? url;
  late Future<dynamic> loadedImage;
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;

  void initState() {
    super.initState();
    loadedImage = getImage();
    retrieveLocation();
  }

      /*
* Pick an image from the gallery, upload it to Firebase Storage and return 
* the URL of the image in Firebase Storage.
*/
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    var fileName = DateTime.now().toString() + '.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    url = await storageReference.getDownloadURL();
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        leading: BackButton()
      ),
      body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: loadedImage,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Semantics(
                        image: true,
                        label: 'Image of waste item',
                        child: Image.file(image!)
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
                )
              ),
              SizedBox(height: 40),
              quantityForm(),
            ]
          ),
        ),
      bottomNavigationBar: Semantics(
        button: true,
        enabled: true,
        onTapHint: 'Upload post to cloud',
        child: GestureDetector(
          onTap: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState?.save();
              uploadData();
              goBack(context);
            }
          },
          child: Container(
            color: Colors.blue,
            height: 75,
            child: Icon(Icons.cloud_upload_outlined, color: Colors.white, size: 40),)   
        )
      )   
    );
  }

  void retrieveLocation() async {
    try {
      var _serviceEnabled = await locationService.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await locationService.requestService();
        if (!_serviceEnabled) {
          print('Failed to enable service. Returning.');
          return;
        }
      }

      var _permissionGranted = await locationService.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await locationService.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          print('Location service permission not granted. Returning.');
        }
      }

      locationData = await locationService.getLocation();
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}, code: ${e.code}');
      locationData = null;
    }
    locationData = await locationService.getLocation();
    setState(() {});
  }

  void getCoordinates() {
    post.latitude = locationData!.latitude;
    post.longitude = locationData!.longitude;
    setState(() { });
  }

  void uploadData() {
    getCoordinates();
    post.imageURL = url;
    post.date = DateTime.now();

    FirebaseFirestore.instance
        .collection('posts')
        .add({
          'quantity': post.quantity,
          'date': post.date,
          'imageURL': post.imageURL,
          'latitude': post.latitude,
          'longitude': post.longitude
        })
        .then((DocumentReference doc) =>
          print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Widget quantityForm() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 10,
          child: TextFormField(
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: 'Quantity of waste items', border: OutlineInputBorder()
            ),
            onSaved: (value) {
              post.quantity = int.parse(value!);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter quantity of waste items';
              } else {
                return null;
              }
            },
          )
        )
    );
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
  }

}
