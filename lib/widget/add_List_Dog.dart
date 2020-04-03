import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddListDog extends StatefulWidget {
  @override
  _AddListDogState createState() => _AddListDogState();
}

class _AddListDogState extends State<AddListDog> {
  // Explicit
  File file;
  String nameDog, detailDog;

  // Method
  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 40,
          child: RaisedButton.icon(
            color: Colors.yellow[700],
            onPressed: () {
              print('Register DOG');

              if (file == null) {
                showAlert(
                    'No image selected', 'Please Click Camera or Gallery');
              } else if (nameDog == null || nameDog.isEmpty) {
                showAlert('No Name', 'Please fill your dog name');
              } else if (detailDog == null || detailDog.isEmpty) {
                showAlert('No Detail', 'Please fill your dog detail');
              } else {
                // Upload Value to Firebase
              }
            },
            icon: Icon(
              Icons.cloud_upload,
              color: Colors.white,
            ),
            label: Text(
              'REGISTER DOG',
              style: TextStyle(color: Colors.white),
            ),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showAlert(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              )
            ],
          );
        });
  }

  Widget nameInputForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'DOG NAME',
          helperText: 'Your dog name',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange[900],
          ),
          icon: Icon(
            Icons.pets,
            size: 30,
            color: Colors.orange[900],
          ),
        ),
        onChanged: (String text) {
          nameDog = text.trim();
        },
      ),
    );
  }

  Widget detailInputForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'DETAIL',
          helperText: 'Detail Your dog e.g. age, breed, habit',
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.orange[900],
          ),
          icon: Icon(
            Icons.description,
            size: 30,
            color: Colors.orange[900],
          ),
        ),
        onChanged: (String text) {
          detailDog = text.trim();
        },
      ),
    );
  }

  Widget cameraButton() {
    return IconButton(
        icon: Icon(
          Icons.add_a_photo,
          size: 36.0,
          color: Colors.green[700],
        ),
        onPressed: () {
          chooseImage(ImageSource.camera);
        });
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return IconButton(
        icon: Icon(
          Icons.add_photo_alternate,
          size: 38.0,
          color: Colors.green[700],
        ),
        onPressed: () {
          chooseImage(ImageSource.gallery);
        });
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(10.0),
      // color: Colors.brown,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.5,
      child: file == null ? Image.asset('images/pic.png') : Image.file(file),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          showButton(),
          SizedBox(
            height: 20,
          ),
          nameInputForm(),
          detailInputForm(),
          SizedBox(
            height: 50,
          ),
          uploadButton(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          showContent(),
        ],
      ),
    );
  }
}
