class Post {

  int? quantity;
  DateTime? date;
  String? imageURL;
  double? latitude;
  double? longitude;

  Post({this.quantity, this.date, this.imageURL, this.latitude, this.longitude});

/*   factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      quantity: json['quantity'],
      date: json['date'],
      imageURL: json['imageURL'],
      latitude: json['latitude'],
      longitude: json['longitude']
    );
  } */

}