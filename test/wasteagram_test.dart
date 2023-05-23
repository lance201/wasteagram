// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/model/post.dart';

import 'package:wasteagram/main.dart';

void main() {

  test('Post should have appropriate property values', () {

    final date = DateTime.parse('2022-08-08');
    const url = 'Fake';
    const quantity = 1;
    const latitude = 1.5;
    const longitude = 2.0;

    final post = Post(
      date : date,
      imageURL: url,
      quantity : quantity,
      latitude : latitude,
      longitude : longitude
    );

    expect(post.date, date);
    expect(post.imageURL, url);
    expect(post.quantity, quantity);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);

  });

  test('Post can be updated partially and not all is required', () {

    const latitude = 1.5;
    const longitude = 2.0;

    final post = Post(
      latitude : latitude,
      longitude : longitude
    );

    expect(post.latitude, latitude);
    expect(post.longitude, longitude);

  });
  
}
