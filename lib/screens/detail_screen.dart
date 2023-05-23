import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/post.dart';

class PostDetail extends StatelessWidget {

  Post post;
  PostDetail({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wasteagram')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateFormat.yMMMd().format(post.date!), style: TextStyle(fontSize: 26)),
          SizedBox(height: 40),
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Image.network(post.imageURL!, fit: BoxFit.cover)
          ),
          SizedBox(height: 40),
          Text('Number of items: ${post.quantity}', style: TextStyle(fontSize: 20)),
          SizedBox(height: 40),
          Text('Latitude: ${post.latitude}, Longitude: ${post.longitude}', style: TextStyle(fontSize: 14))
        ],)
        
    );
  }
}

