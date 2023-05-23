import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'detail_screen.dart';
import '../model/post.dart';
import '../component/fab.dart';

class PostList extends StatefulWidget {

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var post = Post();
                var data = snapshot.data!.docs[index];
                Timestamp time = data['date'];

                post.date = DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
                post.quantity = data['quantity'];
                post.imageURL = data['imageURL'];
                post.latitude = data['latitude'];
                post.longitude = data['longitude'];

                return ListTile(
                  trailing: Text(post.quantity.toString()),
                  title: Text(DateFormat.yMMMd().format(post.date!)),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetail(post: post)
                    ),
                  )
                );
              }
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton: Semantics(
        child: NewEntryButton(),
        button: true,
        enabled: true,
        onTapHint: 'Select an image',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


}
