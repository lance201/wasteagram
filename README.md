# Wasteagram

Using the Flutter framework and dart, a mobile application is created to enable a coffee shop employee to document daily food waste in the form of posts consisting of a photo, number of leftover items, the current date and the location of the device when the post is created. The application will also display a list of all previous posts. This project is built based on emulation of an android device in Android Studio.

## Emulation of the mobile app
Click on the image to be directed to the Youtube video with the demonstration of the running app.
[![IMAGE ALT TEXT](http://img.youtube.com/vi/PnfP70KAT0I/0.jpg)](http://www.youtube.com/watch?v=PnfP70KAT0I "Wasteagram Flutter Mobile App")

## Functional requirements

There are several application functional and technical requirements:
1. Obtain device location inforrmation and integrate the use of camera or photo gallery of the device, each post should have the following attributes:
   date, imageURL, quantity, latitude and longitude
2. There is data persistence using Firebase Cloud Storage and a Firestore database from GCP, no data is stored locally in the device.
3. Provide a List Screen, a Detail Screen and a New Post screen.
4. Display a circular progress indicator when there are no previous posts to display in the List Screen.
5. Inclusion of a Semantics widget to aid accessibility.
6. Codebase should incorporate a model class and a few simple unit tests that test the model class.
